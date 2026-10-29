\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Walter Galpin Alcock (1861-1947)"}
  tagline=#f
}

global = {
  \key g \minor
  \time 2/4
}


S_notes = \relative c'' {
  g2 | fis4 g | a2 \bar "||"
  bes2 | a4 bes | c f, | d'2 \bar "||"
  bes2 | es4 d | c2 \bar "||"
  a2 | bes4 g | g fis | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | d2 \bar "||"
  d2 | c4 f | g f8 es | d2 \bar "||"
  es2 | es4 as | g2 \bar "||"
  fis2 | g4 es | d d | d2 \bar "||"
}

T_notes = \relative c' {
  g2 | c4 bes | fis2 \bar "||"
  g2 | es'4 d | c8 bes a4 | bes2 \bar "||"
  g2 | c4 b | c2 \bar "||"
  d2 | d4 c8 bes | a4 a | bes2 \bar "||"
}

B_notes = \relative c {
  bes2 | a4 g | d'2 \bar "||"
  g2 | c,4 d | es f | bes,2 \bar "||"
  es2 | c4 f | es2 \bar "||"
  d2 | g4 c, | d d | g,2 \bar "||"
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
