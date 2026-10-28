"""Small secrets (a plugin's password or web address) kept on this computer, never in a repository.

In the computer's own password store (Windows Credential Manager, the macOS Keychain) when the `keyring`
package is installed, otherwise in ~/.psalter/<name>.json, readable only by you.
"""
import json, os

DIR = os.path.join(os.path.expanduser('~'), '.psalter')


def _keyring():
    try:
        import keyring
        keyring.get_keyring()
        return keyring
    except Exception:
        return None


def _file(service):
    return os.path.join(DIR, service.replace('psalter-', '') + '.json')


def get(service, key):
    kr = _keyring()
    if kr:
        try:
            v = kr.get_password(service, key)
            if v:
                return v
        except Exception:
            pass
    f = _file(service)
    if os.path.exists(f):
        try:
            return json.load(open(f)).get(key)
        except ValueError:
            return None
    return None


def put(service, key, value):
    """Keep a value; returns where it went."""
    kr = _keyring()
    if kr:
        try:
            kr.set_password(service, key, value)
            return "your computer's password store"
        except Exception:
            pass
    os.makedirs(DIR, exist_ok=True)
    f, data = _file(service), {}
    if os.path.exists(f):
        try:
            data = json.load(open(f))
        except ValueError:
            pass
    data[key] = value
    fd = os.open(f, os.O_WRONLY | os.O_CREAT | os.O_TRUNC, 0o600)
    with os.fdopen(fd, 'w') as fh:
        json.dump(data, fh)
    return f


def forget(service, key):
    kr = _keyring()
    if kr:
        try:
            kr.delete_password(service, key)
        except Exception:
            pass
    f = _file(service)
    if os.path.exists(f):
        try:
            data = json.load(open(f))
        except ValueError:
            data = {}
        data.pop(key, None)
        json.dump(data, open(f, 'w'))
