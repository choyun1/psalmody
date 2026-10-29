\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George John Bennett (1863-1930)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | b4 a | fis2 \bar "||"
  e2 | d4. e8 | fis4 g | a2 \bar "||"
  b2 | d4 cis | b ais \bar "||"
  b2 | b4 a | fis4. g8 | g2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | d2 \bar "||"
  c2 | c4 b | cis cis | d2 \bar "||"
  d2 | fis4 e | e2 \bar "||"
  dis2 | e4 e | d c | b2 \bar "||"
}

T_notes = \relative c' {
  b2 | d4 c | a2 \bar "||"
  g2 | a4 b | a g | fis2 \bar "||"
  g2 | a4 g | fis2 \bar "||"
  fis2 | e4 c' | b a | g2 \bar "||"
}

B_notes = \relative c {
  e2 | c4 c | d2 \bar "||"
  e2 | fis4 g | e e | d2 \bar "||"
  g2 | d4 e | fis2 \bar "||"
  b,2 | c4 c | d d | g,2 \bar "||"
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
