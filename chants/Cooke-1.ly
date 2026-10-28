\version "2.24.1"

\header{
  composer = \markup{\hspace #-29 \italic "Robert Cooke (1768-1814)"}
  tagline=#f
}

global = {
  \key d \minor
  \time 2/4
}


S_notes = \relative g' {
  a2 | f'4 e | d2 \bar "||"
  bes2 | c4 bes8 a | g4 g | f2 | \bar "||"
  a2 | a4 bes | g2 \bar "||"
  a2 | f4 bes | a cis | d2 | \bar "||"
}

A_notes = \relative c' {
  f2 | a4 a8 g | f2 \bar "||"
  g2 | g4 f | f e | f2 | \bar "||"
  f2 | f4 g | e2 \bar "||"
  e2 | d4 d | a' g | f2 | \bar "||"
}

T_notes = \relative a {
  d2 | d4 cis | d2 \bar "||"
  d2 | c4 c | c bes | a2 | \bar "||"
  c2 | d4 d | c2 \bar "||"
  cis2 | d4 g | f e | d2 | \bar "||"
}

B_notes =  \relative c {
  d2 | d'4 a | bes2 \bar "||"
  g2 | e4 f | c c | f2 | \bar "||"
  f2 | d4 bes | c2 \bar "||"
  a'2 | bes4 g | a a, | d2 | \bar "||"
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