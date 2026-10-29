\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Tallis (1505-1585)"}
  tagline=#f
}

global = {
  \key g \minor
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | c4. bes8 | a2 \bar "||"
  a2 | bes4 a8 g | g4 fis | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | es4 es | c2 \bar "||"
  c2 | d4 es | d d | d2 \bar "||"
}

T_notes = \relative c' {
  g2 | g4 g | a2 \bar "||"
  f2 | f4 c'8 bes | a4 a | bes2 \bar "||"
}

B_notes = \relative c' {
  g2 | c,4 c | f2 \bar "||"
  f2 | bes,4 c | d d | g,2 \bar "||"
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
