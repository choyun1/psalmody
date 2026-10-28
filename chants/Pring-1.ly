\version "2.24.1"

\header{
  composer = \markup{\hspace #-29.5 \italic "Joseph Pring (1776-1842)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | a4 bes | g2 \bar "||"
  a2 | f4 f | g e | d2 | \bar "||"
  f2 | g4 a | bes2 \bar "||"
  c2 | a4 a | bes g | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | d4 d | c2 \bar "||"
  cis2 | d4 d | d cis | d2 | \bar "||"
  d2 | d4 d | d2 \bar "||"
  c2 | c4 f | f e | f2 | \bar "||"
}

T_notes = \relative a {
  f2 | f4 f | e2 \bar "||"
  a2 | a4 bes | bes a | f2 | \bar "||"
  bes2 | g4 fis | g2 \bar "||"
  g2 | f4 a | d c | a2 | \bar "||"
}

B_notes =  \relative c {
  f2 | d4 bes | c2 \bar "||"
  a2 | d4 bes | g a | d2 | \bar "||"
  bes2 | bes4 d | g2 \bar "||"
  e2 | f4 d | bes c | f2 | \bar "||"
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