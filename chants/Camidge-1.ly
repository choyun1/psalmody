\version "2.24.1"

\header{
  composer = \markup{\hspace #-34.5 \italic "Matthew Camidge (1764-1844)"}
  tagline=#f
}

global = {
  \key d \minor
  \time 2/4
}


S_notes = \relative g' {
  d2 | e4 e | f2 \bar "||"
  g2 | a4 d | c4. bes8 | a2 | \bar "||"
  a2 | g4 a | f2 \bar "||"
  g2 | g4 f | f e | d2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 cis | d2 \bar "||"
  e2 | f4 f | f e | f2 | \bar "||"
  c2 | cis4 e | d2 \bar "||"
  d2 | cis4 d | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  f2 | a4 a | a2 \bar "||"
  c2 | c4 bes | a g | f2 | \bar "||"
  f2 | g4 e | a2 \bar "||"
  g2 | e4 f8 g | a4. g8 | f2 | \bar "||"
}

B_notes =  \relative c {
  d2 | a4 a | d2 \bar "||"
  c2 | f4 bes, | c c | f2 | \bar "||"
  f2 | e4 cis | d2 \bar "||"
  bes2 | a4 d | a a | d2 | \bar "||"
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