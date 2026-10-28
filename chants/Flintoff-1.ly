\version "2.24.1"

\header{
  composer = \markup{\hspace #-31.5 \italic "Luke Flintoff (c. 1680-1727)"}
  tagline=#f
}

global = {
  \key f \minor
  \time 2/4
}


S_notes = \relative g' {
  f2 | g4 g | aes2 \bar "||"
  aes2 | bes4 c | c bes | c2 | \bar "||"
  c2 | ees4 c | bes2 \bar "||"
  bes2 | bes4 aes | g g | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | des4 c | c2 \bar "||"
  c2 | ees4 ees | f f | e2 | \bar "||"
  ees2 | ees4 ees | ees2 \bar "||"
  bes2 | des4 c8 f | f4 e | f2 | \bar "||"
}

T_notes = \relative a {
  aes2 | bes4 bes | aes2 \bar "||"
  aes2 | g4 aes | aes f | g2 | \bar "||"
  aes2 | bes4 aes | g2 \bar "||"
  g2 | g4 aes | c4. bes8 | aes2 | \bar "||"
}

B_notes =  \relative c {
  f2 | f4 e | f2 \bar "||"
  f2 | ees4 aes, | des des | c2 | \bar "||"
  aes'2 | g4 aes | ees2 \bar "||"
  ees2 | e4 f | c c | f2 | \bar "||"
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