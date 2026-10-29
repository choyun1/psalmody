\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Myles B. Foster (1851-1922)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | c4 f | e2 \bar "||"
  c2 | b4 c | d g, | g2 \bar "||"
}

A_notes = \relative c' {
  e2 | g4 a | g2 \bar "||"
  g2 | f4 e | d e8 f | e2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 c | c2 \bar "||"
  g2 | g4 g | a b | c2 \bar "||"
}

B_notes = \relative c {
  c2 | e4 f | c2 \bar "||"
  e2 | d4 c | f g | c,2 \bar "||"
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
