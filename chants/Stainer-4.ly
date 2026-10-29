\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Stainer (1840-1901)"}
  tagline=#f
}

global = {
  \key a \minor
  \time 2/4
}


S_notes = \relative c' {
  e2 | b'4 gis | a2 \bar "||"
  c2 | c4 b | d gis, | a2 \bar "||"
}

A_notes = \relative c' {
  c2 | f4 e | e2 \bar "||"
  a4. g8 | f4 f | f e8 d | c2 \bar "||"
}

T_notes = \relative c' {
  a2 | gis4 b | a2 \bar "||"
  e'2 | e4 d | d c8 b | a2 \bar "||"
}

B_notes = \relative c' {
  a2 | d,4 d | c2 \bar "||"
  c2 | d4 d | b e | a,2 \bar "||"
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
