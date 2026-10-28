\version "2.24.1"

\header{
  composer = \markup{\hspace #-31.5 \italic "Joseph Barnby (1838-1896)"}
  tagline=#f
}

global = {
  \key d \minor
  \time 2/4
}


S_notes = \relative g' {
  a2 | f4 g | a2 \bar "||"
  a2 | f4 a | d d | cis2 | \bar "||"
  d2 | a4 c | bes2 \bar "||"
  a2 | f4 g | e4 e | d2 | \bar "||"
}

A_notes = \relative c' {
  a'2 | f4 g | a2 \bar "||"
  cis,2 | d4 e | d e | e2 | \bar "||"
  fis2 | d4 d | d2 \bar "||"
  e2 | d4 d | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  a2 | f4 g | a2 \bar "||"
  a2 | a4 a | f g | a2 | \bar "||"
  a2 | a4 fis | g2 \bar "||"
  e2 | a4 g | a a | f2 | \bar "||"
}

B_notes =  \relative c {
  a'2 | f4 g | a2 \bar "||"
  a,2 | d4 c | bes bes | a2 | \bar "||"
  d2 | fis4 d | g2 \bar "||"
  cis,2 | d4 bes | a a | d2 | \bar "||"
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