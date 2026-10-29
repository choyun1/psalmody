\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Frederick South (1850-1916)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | e4 f | g2 \bar "||"
  g2 | a4 a | a d | g,2 \bar "||"
  g2 | c4 e | d2 \bar "||"
  a2 | g4 c | d, g | c,2 \bar "||"
}

A_notes = \relative c' {
  c2 | c4 c | d2 \bar "||"
  c2 | c4 cis | d f | f2 \bar "||"
  e2 | e4 g | a2 \bar "||"
  d,2 | d4 c | c b | c2 \bar "||"
}

T_notes = \relative c {
  e2 | g4 c | b2 \bar "||"
  c2 | a4 a | f a | d2 \bar "||"
  c2 | c4 c | c2 \bar "||"
  c2 | b4 g | a g8 f | e2 \bar "||"
}

B_notes = \relative c {
  c2 | c4 a | g2 \bar "||"
  e'2 | f4 e | d c | b2 \bar "||"
  c2 | a'4 g | fis2 \bar "||"
  fis2 | f4 e | f g, | c2 \bar "||"
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
