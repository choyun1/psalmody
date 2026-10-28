\version "2.24.1"

\header{
  composer = \markup{\hspace #-27 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative g' {
  f2 | a4 f | d2 \bar "||"
  e2 | f4 g | a b | c2 | \bar "||"
  g2 | c4 a | f2 \bar "||"
  bes2 | a4 g | f e | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | c4 c | bes2 \bar "||"
  bes2 | c4 c | c f | e2 | \bar "||"
  c2 | c4 c | a2 \bar "||"
  d4. e8 | f4 d | c4. bes8 | a2 | \bar "||"
}

T_notes = \relative a {
  a2 | c4 a | f2 \bar "||"
  g2 | f4 e | f f | g2 | \bar "||"
  e2 | e4 e | f2 \bar "||"
  g2 | c4 bes | a g | f2 | \bar "||"
}

B_notes =  \relative c {
  f2 | f4 a, | bes2 \bar "||"
  g2 | a4 c | f d | c2 | \bar "||"
  c2 | a4 c | d2 \bar "||"
  g,2 | a4 bes | c c | f,2 | \bar "||"
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