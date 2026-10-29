\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Foster (1752-1822)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis2 | e4 d | a'2 \bar "||"
  a2 | a4 g | d4 e | fis2 \bar "||"
}

A_notes = \relative c' {
  d2 | cis4 d | d2 \bar "||"
  d2 | d4 d | b4 b8 cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | g4 fis | fis2 \bar "||"
  d'4. cis8 | cis4 b | b4 b | a2 \bar "||"
}

B_notes = \relative c {
  d2 | e4 d | fis,2 \bar "||"
  fis'2 | g4 g | g4 g | d2 \bar "||"
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
