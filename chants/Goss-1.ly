\version "2.24.1"

\header{
  composer = \markup{\hspace #-48 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key f \minor
  \time 2/4
}


S_notes = \relative g' {
  f2 | aes4 g | bes2 \bar "||"
  aes2 | g4 f | f e | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | c4 c | bes2 \bar "||"
  c2 | des4 c | bes bes | aes2 | \bar "||"
}

T_notes = \relative a {
  aes2 | f4 g | f2 \bar "||"
  ees2 | des4 f | g g | c,2 | \bar "||"
}

B_notes =  \relative c {
  f2 | f4 ees | des2 \bar "||"
  c2 | bes4 aes | g g | f2 | \bar "||"
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