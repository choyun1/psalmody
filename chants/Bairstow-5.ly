\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edward Cuthbert Bairstow (1874-1946)"}
  tagline=#f
}

global = {
  \key c \minor
  \time 2/4
}


S_notes = \relative c'' {
  c2 | b4 c | as2 \bar "||"
  as2 | g4 es | f g | c,2 \bar "||"
}

A_notes = \relative c' {
  es2 | g4 g | g f \bar "||"
  es4. d8 | es4 c | a b | c2 \bar "||"
}

T_notes = \relative c' {
  g2 | g4 es' | es d \bar "||"
  c4. b8 | c4 g | f g | es2 \bar "||"
}

B_notes = \relative c {
  c2 | es4 c | f2 \bar "||"
  f2 | es4 es | es d | c2 \bar "||"
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
