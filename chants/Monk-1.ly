\version "2.24.1"

\header{
  composer = \markup{\hspace #-58.5 \italic "Edwin George Monk (1819-1900)"}
  tagline=#f
}

global = {
  \key g \minor
  \time 2/4
}


S_notes = \relative g' {
  bes2 | a4 g | fis2 | \bar "||"
  a2 | d,4 g | g fis | g2 | \bar "||"
}

A_notes = \relative c' {
  d2 | ees4 ees | d2 | \bar "||"
  d2 | bes4 bes | ees d | d2 | \bar "||"
}

T_notes = \relative a {
  bes2 | c4 bes | a2 | \bar "||"
  a2 | g4 g | a a | bes2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | c,4 c | d2 | \bar "||"
  <fis \parenthesize \tweak font-size -3 fis,>2 | <g \parenthesize \tweak font-size -3 f,>4 ees | c d | g,2 | \bar "||"
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