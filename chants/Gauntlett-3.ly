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
  b2 | c4 d | g,2 \bar "||"
  b2 | e,4 g | c b | a2 \bar "||"
  b2 | a4 gis | a2 \bar "||"
  e2 | fis4 g | g fis | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | e4 d | e2 \bar "||"
  e2 | e4 d | d d | d2 \bar "||"
  g2 | e4 e | e2 \bar "||"
  c2 | d4 d | d d | d2 \bar "||"
}

T_notes = \relative c' {
  b2 | a4 a | b2 \bar "||"
  g2 | g4 g | fis g | fis2 \bar "||"
  b2 | c4 d | c2 \bar "||"
  g2 | c4 b | a a | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | g4 fis | e2 \bar "||"
  e4. d8 | c4 b | a g | d'2 \bar "||"
  d2 | e4 e | a,2 \bar "||"
  c2 | a4 g | d' d | g,2 \bar "||"
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
