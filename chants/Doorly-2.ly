\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Carte Doorly (?-1926)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | a4 c | b2 \bar "||"
  b2 | c4 e | e d8 c | b2 \bar "||"
  b2 | c4 e | a,2 \bar "||"
  a2 | g4 e | g f | e2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | f2 \bar "||"
  f2 | g4 g | g g | g2 \bar "||"
  g2 | g4 gis | a2 \bar "||"
  f2 | e4 e | e d | c2 \bar "||"
}

T_notes = \relative c' {
  g2 | c4 a | g2 \bar "||"
  g2 | g4 c | a c | d2 \bar "||"
  d2 | e4 d | c2 \bar "||"
  b2 | c4 c | a b | c2 \bar "||"
}

B_notes = \relative c {
  c2 | c4 c | d2 \bar "||"
  d2 | e4 d | fis fis | g2 \bar "||"
  f2 | e4 e | f2 \bar "||"
  d2 | e4 a | d, g | c,2 \bar "||"
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
