\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edward Francis Rimbault (1816-1876)"}
  tagline=#f
}

global = {
  \key c \minor
  \time 2/4
}


S_notes = \relative c'' {
  g2 | c4 bes | g2 \bar "||"
  g2 | g4 c | es d | c2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 f | es2 \bar "||"
  d2 | es4 es8 f | g4. f8 | es2 \bar "||"
}

T_notes = \relative c' {
  c2 | as4 f | bes2 \bar "||"
  b2 | c4 c | c b | c2 \bar "||"
}

B_notes = \relative c {
  c2 | c4 d | es2 \bar "||"
  g2 | c4 as | g g | c,2 \bar "||"
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
