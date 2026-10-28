\version "2.24.1"

\header{
  composer = \markup{\hspace #-58.5 \italic "George A. Macfarren (1813-1887)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative g' {
  ees2 | f4 ees | aes2 \bar "||"
  bes2 | c4 aes | aes g | aes2 | \bar "||"
}

A_notes = \relative c' {
  c2 | des4 ees | c2 \bar "||"
  ees2 | ees4 c | ees ees | ees2 | \bar "||"
}

T_notes = \relative a {
  aes2 | aes4 aes | aes2 \bar "||"
  g2 | g4 aes | bes bes | c2 | \bar "||"
}

B_notes =  \relative c {
  aes2 | des4 c | f2 \bar "||"
  ees2 | c4 f | ees ees | aes,2 | \bar "||"
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