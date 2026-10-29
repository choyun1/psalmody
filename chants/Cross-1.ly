\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Cross (1777-1825)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | d,4 es | as2 \bar "||"
  g2 | f4 es | d es | f2 \bar "||"
  bes2 | bes4 des | c2 \bar "||"
  c2 | d,4 es | f d | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | bes4 bes | bes2 \bar "||"
  bes2 | c4 es | bes4. c8 | d2 \bar "||"
  f2 | es4 es | es2 \bar "||"
  es2 | bes4 bes | c bes | bes2 \bar "||"
}

T_notes = \relative c' {
  g2 | as4 g | f2 \bar "||"
  g2 | as4 bes | as g | bes2 \bar "||"
  d2 | es4 g, | as2 \bar "||"
  as2 | f4 es | as f | g2 \bar "||"
}

B_notes = \relative c {
  es2 | f4 es | d2 \bar "||"
  es2 | as4 g | f es | bes2 \bar "||"
  bes'4. as8 | g4 es | as2 \bar "||"
  as,2 | as4 g | as bes | es2 \bar "||"
}

% Use markup to center the chant on the page
\markup {
  \fill-line {
    \score {  % centered
      <<
        \new ChoirStaff <<
          \new Staff <<
            \global
            \clef "treble"
            \new Voice = "Soprano" <<
              \voiceOne \S_notes
            >>
            \new Voice = "Alto" <<
              \voiceTwo \A_notes
            >>
          >>
          \new Staff <<
            \global
            \clef "bass"
            \new Voice = "Tenor" <<
              \voiceOne \T_notes
            >>
            \new Voice = "Bass" <<
              \voiceTwo \B_notes
            >>
          >>
        >>
      >>

      \layout {
        \context {
          \Staff
          \remove "Time_signature_engraver"
        }
      }
    }  % End score
  }
}  % End markup
