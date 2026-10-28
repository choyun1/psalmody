\version "2.24.1"

\header{
  composer = \markup{\hspace #-31 \italic "William Boyce (1711-1779)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative g' {
  d'2 | a4 g | fis2 \bar "||"
  fis2 | e4 a | a gis | a2 | \bar "||"
  a2 | b4 cis | d2 \bar "||"
  b2 | a4 g8 fis | fis4 e | d2 \bar "||"
}

A_notes = \relative c' {
  fis2 | d4 e | fis2 \bar "||"
  d2 | e4 e | e4. d8 | cis2 | \bar "||"
  d2 | d4 g | fis2 \bar "||"
  d2 | d4 e8 d | d4 cis | d2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 b8 cis | d2 \bar "||"
  a2 | a8 b cis d | cis4 b | a2 | \bar "||"
  a2 | g4 e' | d2 \bar "||"
  d2 | d4 b | a4. g8 | fis2 | \bar "||"
}

B_notes =  \relative c {
  d2 | fis4 e | d2 \bar "||"
  d2 | cis4 a | e' e | a,2 | \bar "||"
  fis'2 | g4 e | b2 \bar "||"
  g'2 | fis4 g | a a, | d2 | \bar "||"
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