\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Weldon (1676-1736)"}
  tagline=#f
}

global = {
  \key g \minor
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | d4 bes | a2 \bar "||"
  a2 | c4 g8 a | bes4 a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 g | fis2 \bar "||"
  f2 | es4 bes8 c | d4. c8 | bes2 \bar "||"
}

T_notes = \relative c' {
  bes2 | bes4 d | d2 \bar "||"
  c2 | a4 g | g fis | g2 \bar "||"
}

B_notes = \relative c' {
  g2 | bes4 g | d2 \bar "||"
  f2 | c4 es | d d | g,2 \bar "||"
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
