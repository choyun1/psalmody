\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Crotch (1775-1847)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | g4 fis | e2 \bar "||"
  a2 | b8 cis d4 | d cis | d2 \bar "||"
}

A_notes = \relative c' {
  fis2 | e4 d | cis2 \bar "||"
  d2 | g4 fis | e fis8 g | fis2 \bar "||"
}

T_notes = \relative c' {
  d2 | b8 cis d4 | a2 \bar "||"
  a2 | g4 a | a a | a2 \bar "||"
}

B_notes = \relative c {
  d2 | e4 fis8 g | a2 \bar "||"
  fis2 | e4 d | a' a, | d2 \bar "||"
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
