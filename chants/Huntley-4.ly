\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Frederick William Huntley (1859-1913)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | d4 d | g,2 \bar "||"
  g2 | c4 d | e4 a, | a2 \bar "||"
  b2 | b4 c | d2 \bar "||"
  fis,2 | g4 b | b4 a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | e4 fis | g2 \bar "||"
  e2 | e4 g | g4 a8 g | fis2 \bar "||"
  fis2 | g4 fis8 e | d2 \bar "||"
  c2 | b4 d | e4 fis | g2 \bar "||"
}

T_notes = \relative c' {
  b2 | b4 a | d2 \bar "||"
  b2 | c4 b | a4 e' | d2 \bar "||"
  b2 | g4 a | b2 \bar "||"
  a2 | g4 g | d'4 c | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | d4 c | b2 \bar "||"
  e2 | a,4 b | c4 cis | d2 \bar "||"
  dis2 | e4 c | b2 \bar "||"
  d2 | e4 b | c4 d | g2 \bar "||"
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
