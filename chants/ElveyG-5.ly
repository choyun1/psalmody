\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George J. Elvey (1816-1893)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  c2 | e4 c | g2 \bar "||"
  e4. f8 | g4 a | b c | c b \bar "||"
  c2 | e4 c | a2 \bar "||"
  g4. f8 | e4 f | e d | c2 \bar "||"
}

A_notes = \relative c' {
  e2 | g4 c, | d2 \bar "||"
  c2 | c4 c | f e | e d \bar "||"
  g2 | e4 g | f2 \bar "||"
  d2 | c4 c | c b | c2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 e | g,2 \bar "||"
  g2 | g4 c | d g, | g2 \bar "||"
  g2 | g4 c | c2 \bar "||"
  g2 | g4 a | g4. f8 | e2 \bar "||"
}

B_notes = \relative c {
  c2 | c4 c | b2 \bar "||"
  c4. d8 | e4 f8 e8 | d4 c | g'2 \bar "||"
  e2 | c4 e | f2 \bar "||"
  b,2 | c4 f | g g, | c2 \bar "||"
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
