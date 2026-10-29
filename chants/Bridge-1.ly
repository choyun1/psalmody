\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Frederick Bridge (1844-1924)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c' {
  e2 | a4 a | g2 \bar "||"
  c2 | b4 a | g a | b2 \bar "||"
  b2 | d4 d | c2 \bar "||"
  c2 | e4 d | b b | c2 \bar "||"
}

A_notes = \relative c' {
  c2 | c4 d | g2 \bar "||"
  e2 | fis4 fis | g d | d2 \bar "||"
  e2 | a4 gis | a2 \bar "||"
  fis2 | g4 a | a g8 f | e2 \bar "||"
}

T_notes = \relative c' {
  g2 | a4 b | c2 \bar "||"
  c2 | d4 d | d fis, | g2 \bar "||"
  gis2 | a4 b | c2 \bar "||"
  a2 | c4 f | f e8 d | c2 \bar "||"
}

B_notes = \relative c {
  c2 | f4 f | e2 \bar "||"
  a,2 | d4 c | b d | g2 \bar "||"
  e2 | f4 e | a2 \bar "||"
  d,2 | g4 g | g, g | c2 \bar "||"
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
