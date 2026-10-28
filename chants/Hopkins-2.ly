\version "2.24.1"

\header{
  composer = \markup{\hspace #-39 \italic "Edward John Hopkins (1818-1901)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | g4 f | e2 \bar "||"
  g2 | a4 f | a b | c2 | \bar "||"
  c2 | bes4 c | a2 \bar "||"
  g2 | g4 f | f e | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | c4 c | c2 \bar "||"
  c2 | c4 c | f f | e2 | \bar "||"
  f2 | f4 e | f2 \bar "||"
  d2 | e4 f | c c | c2 | \bar "||"
}

T_notes = \relative a {
  a2 | bes4 a | g2 \bar "||"
  g2 | f4 a | a f | g2 | \bar "||"
  c2 | d4 c | c2 \bar "||"
  bes2 | bes4 a | g g | a2 | \bar "||"
}

B_notes =  \relative c {
  f2 | e4 f | c2 \bar "||"
  e2 | f4 f | d d | c2 | \bar "||"
  a'2 | g4 c, | f2 \bar "||"
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