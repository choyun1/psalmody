\version "2.24.1"

\header{
  composer = \markup{\hspace #-30.5 \italic "Richard Clark (1780-1856)"}
  tagline=#f
}

global = {
  \key f \minor
  \time 2/4
}


S_notes = \relative g' {
  f2 | aes4 f | e2 \bar "||"
  e2 | f4 g | aes bes | c2 | \bar "||"
  aes2 | c4 aes | g2 \bar "||"
  g2 | f4 g | f e | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | c4 c | c2 \bar "||"
  c2 | c4 c | c ees | ees2 | \bar "||"
  ees2 | ees4 ees | ees2 \bar "||"
  c2 | c4 des | c c | c2 | \bar "||"
}

T_notes = \relative a {
  aes2 | f4 f | g2 \bar "||"
  g2 | aes4 g | f g | aes2 | \bar "||"
  c2 | aes4 aes | bes2 \bar "||"
  g2 | aes4 bes | aes g | aes2 | \bar "||"
}

B_notes =  \relative c {
  f2 | f,4 aes | c2 \bar "||"
  c2 | f4 e | f ees | aes,2 | \bar "||"
  aes'2 | aes,4 c | ees2 \bar "||"
  e2 | f4 bes, | c c | f2 | \bar "||"
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