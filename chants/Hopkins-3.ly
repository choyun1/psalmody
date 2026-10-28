\version "2.24.1"

\header{
  composer = \markup{\hspace #-39 \italic "Edward John Hopkins (1818-1901)"}
  tagline=#f
}

global = {
  \key g \minor
  \time 2/4
}


S_notes = \relative g' {
  bes2 | a4 g | fis2 \bar "||"
  a2 | bes4 g | bes c | d2 | \bar "||"
  d2 | c4 d | bes2 \bar "||"
  a2 | a4 g | g fis | g2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | d2 \bar "||"
  d2 | d4 d | g g | fis2 | \bar "||"
  g2 | g4 fis | g2 \bar "||"
  ees2 | d4 d | d d | d2 | \bar "||"
}

T_notes = \relative a {
  bes2 | c4 bes | a2 \bar "||"
  a2 | g4 bes | bes g | a2 | \bar "||"
  d2 | ees4 d | d2 \bar "||"
  c2 | c4 bes | a a | bes2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | fis4 g | d2 \bar "||"
  fis2 | g4 g | ees ees | d2 | \bar "||"
  bes'2 | a4 d, | g2 \bar "||"
  c,2 | d4 d | d d | g,2 | \bar "||"
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