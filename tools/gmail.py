"""Put the weekly email straight into Gmail's Drafts, attachments and all.

This talks to Gmail over IMAP with an app password: a 16-letter password Google makes for one program,
which can be revoked at any time and doesn't open the account's other settings. One-time setup:

  1. Sign in to Google as the music account. 2-Step Verification must be on.
  2. Go to https://myaccount.google.com/apppasswords, make one called "Psalter", copy it.
  3. In the Service planner, under the email, click "Connect Gmail" and paste it.
     (Or: python tools/gmail.py connect)

The password is kept in your computer's own password store (Windows Credential Manager, the macOS
Keychain) when the `keyring` package is installed, otherwise in a file in your home folder that only
you can read. Never in the repositories.

If the account's Google Workspace admin has turned app passwords off, IMAP drafting can't work; ask
them to allow it, or keep using "Open in Gmail".
"""
import imaplib, json, os, re, sys, time

SERVICE = 'psalter-gmail'
HOST = 'imap.gmail.com'


def get_password(account):
    import keystore
    return keystore.get(SERVICE, account)


def set_password(account, pw):
    import keystore
    return keystore.put(SERVICE, account, pw)


def forget(account):
    import keystore
    keystore.forget(SERVICE, account)


def login(account, pw=None):
    pw = (pw or get_password(account) or '').replace(' ', '')
    if not pw:
        raise RuntimeError('Gmail is not connected yet: click "Connect Gmail" and paste an app password')
    M = imaplib.IMAP4_SSL(HOST)
    try:
        M.login(account, pw)
    except imaplib.IMAP4.error as e:
        raise RuntimeError(f'Gmail refused the sign-in ({e}). Check the app password, and that IMAP and app '
                           'passwords are allowed for this account.')
    return M


def connect(account, pw):
    """Check the app password works, then keep it. Returns where it was kept."""
    M = login(account, pw)
    M.logout()
    return set_password(account, pw.replace(' ', ''))


def connected(account):
    return bool(account and get_password(account))


def _mailbox(M, flag):
    """The folder with a special-use flag (\\Drafts, \\Trash), whatever its name in the account's language."""
    typ, data = M.list()
    for line in data or []:
        line = line.decode('utf-8', 'replace')
        if flag in line:
            m = re.search(r'"([^"]+)"\s*$', line) or re.search(r'(\S+)\s*$', line)
            return m.group(1)
    raise RuntimeError(f'cannot find the Gmail folder marked {flag}')


def save_draft(account, msg_bytes, tag, subject):
    """Add the message to Drafts. An earlier draft written by this tool for the same Sunday (and not
    edited since, since Gmail's own edits drop our marker) goes to the Trash. Returns whether one did."""
    M = login(account)
    try:
        drafts, trash = _mailbox(M, '\\Drafts'), _mailbox(M, '\\Trash')
        replaced = False
        M.select(f'"{drafts}"')
        typ, data = M.search('UTF-8', 'SUBJECT', f'"{subject}"'.encode())
        ids = []
        for i in ((data[0] or b'').split() if typ == 'OK' else []):
            t, d = M.fetch(i, '(BODY.PEEK[HEADER.FIELDS (X-PSALTER-DRAFT)])')
            head = b''.join(x[1] for x in d if isinstance(x, tuple)).decode('utf-8', 'replace')
            if re.search(r'X-Psalter-Draft:\s*' + re.escape(tag) + r'\s*$', head, re.I | re.M):
                ids.append(i)
        if ids:
            seq = b','.join(ids).decode()
            M.copy(seq, f'"{trash}"')
            M.store(seq, '+FLAGS', '\\Deleted')
            M.expunge()
            replaced = True
        M.append(f'"{drafts}"', '(\\Draft)', imaplib.Time2Internaldate(time.time()), msg_bytes)
        return replaced
    finally:
        try:
            M.logout()
        except Exception:
            pass


def drafts_link(account):
    return f'https://mail.google.com/mail/u/?authuser={account}#drafts'


if __name__ == '__main__':
    import getpass
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import service
    acct = service.settings()['account']
    if sys.argv[1:2] == ['connect']:
        print(f'Connecting {acct}. Make an app password at https://myaccount.google.com/apppasswords')
        print('Kept in ' + connect(acct, getpass.getpass('App password: ')))
    elif sys.argv[1:2] == ['forget']:
        forget(acct)
        print('forgotten')
    else:
        print(__doc__)
        print('Connected.' if connected(acct) else 'Not connected yet: python tools/gmail.py connect')
