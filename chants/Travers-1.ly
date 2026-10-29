\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Travers (c. 1703-1758)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis4. g8 | a4 d | cis2 \bar "||"
  a2 | b4 fis8 g | a4. g8 | fis2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | e2 \bar "||"
  d2 | d4 d | d4 cis | d2 \bar "||"
}

T_notes = \relative c' {
  a4. g8 | fis4 gis | a2 \bar "||"
  fis2 | g4 d | e4 a | a2 \bar "||"
}

B_notes = \relative c {
  d4. e8 | fis4 b, | a2 \bar "||"
  d2 | g,4 b | a4 a | d2 \bar "||"
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
