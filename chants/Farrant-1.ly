\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Richard Farrant (1525-1580)"}
  tagline=#f
}

global = {
  \key g \minor
  \time 2/4
}


S_notes = \relative g' {
  g2 | g4 a | bes2 \bar "||"
  bes2 | a4 g | c bes | a2 | \bar "||"
  bes2 | a4 g | fis2 \bar "||"
  bes2 | a4 g | g fis | g2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 fis | g2 \bar "||"
  g2 | ees4 d | fis g | fis2 | \bar "||"
  g2 | ees4 c | d2 \bar "||"
  d2 | fis4 g | ees d | d2 | \bar "||"
}

T_notes = \relative a {
  bes2 | bes4 d | d2 \bar "||"
  d2 | c4 d | d d | d2 | \bar "||"
  d2 | c4 g | a2 \bar "||"
  g2 | d'8 c bes4 | c a | bes2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | g4 d | g2 \bar "||"
  g2 | c4 bes | a g | d2 | \bar "||"
  g,2 | c4 ees | d2 \bar "||"
  g2 | d4 ees | c d | g2 | \bar "||"
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