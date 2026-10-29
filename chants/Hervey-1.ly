\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Frederick Alfred John Hervey (1846-1910)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | a4 a | g2 \bar "||"
  g2 | g4 fis | e e | d2 \bar "||"
  g2 | f4 f | e2 \bar "||"
  c'2 | c4 b | a a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | e4 d | d2 \bar "||"
  e2 | e4 d | d cis | d2 \bar "||"
  d2 | c4 d | e2 \bar "||"
  e2 | d4 d | d4. c8 | b2 \bar "||"
}

T_notes = \relative c' {
  g2 | c4 c | b2 \bar "||"
  b2 | a4 a | a4. g8 | fis2 \bar "||"
  g2 | a4 g | g2 \bar "||"
  a2 | a4 g | g fis | g2 \bar "||"
}

B_notes = \relative c' {
  g2 | g4 fis | g2 \bar "||"
  e4. d8 | cis4 d | a a | d2 \bar "||"
  b2 | a4 b | c2 \bar "||"
  a'4. g8 | fis4 g | d d | g,2 \bar "||"
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
