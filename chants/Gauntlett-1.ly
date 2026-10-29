\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Henry John Gauntlett (1805-1876)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | g4 g | g2 \bar "||"
  fis2 | g4 d' | c b | a2 \bar "||"
  a2 | cis4 d | d2 \bar "||"
  c2 | c4 b | b a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | d2 \bar "||"
  d2 | d4 g | a g | fis2 \bar "||"
  fis2 | e4 d | g2 \bar "||"
  g2 | a4 g | g fis | g2 \bar "||"
}

T_notes = \relative c' {
  b2 | c4 d | c2 \bar "||"
  c2 | d4 d | d d | d2 \bar "||"
  a2 | g4 a | b2 \bar "||"
  e2 | d4 d | d c | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | a4 b | a2 \bar "||"
  a2 | b4 b | fis g | d2 \bar "||"
  d2 | e4 fis | e2 \bar "||"
  e2 | fis4 g | d d | g2 \bar "||"
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
