\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Foster (1752-1822)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | g4 f | f2 \bar "||"
  e2 | c'4 a | g g | g2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 d | d2 \bar "||"
  b2 | e4 f | d d | e2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 a | b2 \bar "||"
  d2 | c4 c | c b | c2 \bar "||"
}

B_notes = \relative c' {
  c4. b8 | a4 d, | g2 \bar "||"
  gis2 | a4 f | g g | c,2 \bar "||"
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
