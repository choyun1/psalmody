\version "2.24.1"

\header{
  composer = \markup{\hspace #-44 \italic "Thomas Attwood Walmisley (1814-1856)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | a4 a | a2 \bar "||"
  a2 | d4 c| f, bes | g2 | \bar "||"
  a2 | b4 b | c2 \bar "||"
  f,2 | g4 a | bes e, | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | cis4 cis | d2 \bar "||"
  f2 | f4 f | f g | e2 | \bar "||"
  f2 | g4 g | g2 \bar "||"
  f2 | d8 e f4 | d c8 bes | a2 | \bar "||"
}

T_notes = \relative a {
  a2 | g4 g | f2 \bar "||"
  bes2 | bes4 c | a d | c2 | \bar "||"
  c2 | d4 d | c2 \bar "||"
  a2 | g4 c | bes g | f2 | \bar "||"
}

B_notes =  \relative c {
  f2 | e4 e | d2 \bar "||"
  d2 | bes4 a | d g, | c2 | \bar "||"
  f2 | f4 f | e2 \bar "||"
  d2 | bes4 a | g c | <\parenthesize f f,>2 | \bar "||"
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