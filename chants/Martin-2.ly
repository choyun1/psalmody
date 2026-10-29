\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Clement Martin (1844-1916)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis4. g8 | a4 a | a2 \bar "||"
  g2 | g4 fis | fis e | e2 \bar "||"
  g4. a8 | b4 b | b2 \bar "||"
  b4. cis8 | d4 b | g8 fis g4 | fis2 \bar "||"
}

A_notes = \relative c' {
  d4. e8 | fis4 fis | fis2 \bar "||"
  e2 | e4 d | d d | cis2 \bar "||"
  e2 | e4 e | dis2 \bar "||"
  e2 | d4 d | d cis | d2 \bar "||"
}

T_notes = \relative c' {
  a4. g8 | fis4 a | d2 \bar "||"
  b2 | a4 a | a gis | a2 \bar "||"
  b2 | b4 g | fis2 \bar "||"
  g2 | a4 g | b a | a2 \bar "||"
}

B_notes = \relative c {
  fis4. e8 | d4 fis | b2 \bar "||"
  e,4. d8 | cis4 d | b e | a,2 \bar "||"
  e'4. fis8 | g4 e | b2 \bar "||"
  e2 | fis4 g | e a | d,2 \bar "||"
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
