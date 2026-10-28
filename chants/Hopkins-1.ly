\version "2.24.1"

\header{
  composer = \markup{\hspace #-39 \italic "Edward John Hopkins (1818-1901)"}
  tagline=#f
}

global = {
  \key f \minor
  \time 2/4
}


S_notes = \relative g' {
  aes2 | g4 f | e2 \bar "||"
  g2 | aes4 f | aes bes | c2 | \bar "||"
  c2 | bes4 c | aes2 \bar "||"
  g2 | g4 f | f e | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | c4 c | c2 \bar "||"
  c2 | c4 c | f f | e2 | \bar "||"
  f2 | f4 e | f2 \bar "||"
  des2 | c4 c | c c | c2 | \bar "||"
}

T_notes = \relative a {
  aes2 | bes4 aes | g2 \bar "||"
  g2 | f4 aes | aes f | g2 | \bar "||"
  c2 | des4 c | c2 \bar "||"
  bes2 | bes4 aes | g g | aes2 | \bar "||"
}

B_notes =  \relative c {
  f2 | e4 f | c2 \bar "||"
  e2 | f4 f | des des | c2 | \bar "||"
  aes'2 | g4 c, | f2 \bar "||"
  bes,2 | c4 c | c c | f,2 | \bar "||"
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