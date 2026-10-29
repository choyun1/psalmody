\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Joseph Corfe (1740-1820)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | e'4 d | c2 \bar "||"
  c4. b8 | a4 g | f f | e2 \bar "||"
  g2 | g4 fis | g2 \bar "||"
  a2 | f'4 e | d d | c2 \bar "||"
}

A_notes = \relative c' {
  e2 | g4 f | e2 \bar "||"
  c2 | c4 c | c b | c2 \bar "||"
  e2 | d4 d | d2 \bar "||"
  f2 | f4 g | g4. f8 | e2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 b | c2 \bar "||"
  g2 | f4 g | a f | g2 \bar "||"
  c2 | d4 c | b2 \bar "||"
  c2 | b4 c | c b | c2 \bar "||"
}

B_notes = \relative c {
  c2 | c'4 g | a2 \bar "||"
  e2 | f4 e | d d | c2 \bar "||"
  c'2 | b4 a | g2 \bar "||"
  f2 | d4 c | g' g, | c2 \bar "||"
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
