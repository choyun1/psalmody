\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Richard Woodward, Jr. (1743-1777)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  c2 | g4 c | b2 \bar "||"
  c4. b8 | a4 g | g fis | g2 \bar "||"
  g2 | e4 a | g2 \bar "||"
  c2 | f,4 a | e d | c2 \bar "||"
}

A_notes = \relative c' {
  e2 | g4 fis | g2 \bar "||"
  c,2 | e4 d | d c | b2 \bar "||"
  d2 | c4 c | c2 \bar "||"
  e2 | f4 c | c b | c2 \bar "||"
}

T_notes = \relative c' {
  g2 | c4 c | d2 \bar "||"
  g,2 | a4 b | b a | g2 \bar "||"
  b2 | c4 f, | g2 \bar "||"
  g2 | c4 c | g4. f8 | e2 \bar "||"
}

B_notes = \relative c {
  c2 | e4 a | g2 \bar "||"
  e2 | c4 b8 c8 | d4 d | g,2 \bar "||"
  g'2 | a4 f | e2 \bar "||"
  c2 | a4 f | g g | c2 \bar "||"
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
