\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George John Bennett (1863-1930)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | c4 e, | a2 \bar "||"
  b2 | c4. d8 | e4 d | g,2 \bar "||"
  g2 | c4 e, | a2 \bar "||"
  b2 | c4 b8 a | g4 g | c,2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | c2 \bar "||"
  g'2 | g4. g8 | g4 fis | g2 \bar "||"
  e2 | f4 e | e4 d \bar "||"
  d2 | c4 c | c b | c2 \bar "||"
}

T_notes = \relative c' {
  g2 | c4 gis | a2 \bar "||"
  d2 | c4. b8 | c4 c | b2 \bar "||"
  c2 | c4 bes | a2 \bar "||"
  gis2 | a4 f | d8 e f4 | e2 \bar "||"
}

B_notes = \relative c {
  c2 | c4 c | f2 \bar "||"
  g2 | e4. d8 | c4 d | g2 \bar "||"
  bes2 | a4 g | f2 \bar "||"
  e2 | a,4 d | g, g | c2 \bar "||"
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
