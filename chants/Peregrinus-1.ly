\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Tonus Peregrinus"}
  tagline=#f
}

global = {
  \key e \minor
  \time 2/4
}


S_notes = \relative c'' {
  b4. a8 | c4 b | a g \bar "||"
  a2 | a4 e | g fis | e2 \bar "||"
}

A_notes = \relative c' {
  d2 | g4 g | fis g \bar "||"
  e2 | e4 e | e dis | e2 \bar "||"
}

T_notes = \relative c' {
  d2 | c4 d | c b \bar "||"
  a4. b8 | c4 a | b4. a8 | g2 \bar "||"
}

B_notes = \relative c' {
  g4. fis8 | e4 g | d e \bar "||"
  c4. b8 | a4 c | b b | e2 \bar "||"
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
