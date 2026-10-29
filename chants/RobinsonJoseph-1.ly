\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Joseph Robinson (1815-1898)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | bes4 a | g a \bar "||"
  f2 | f4 f | g a | g2 \bar "||"
  a2 | bes4 a | d c \bar "||"
  f,2 | g8 a bes4 | a g | f2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 f | e f \bar "||"
  c2 | f4 f | e f | e2 \bar "||"
  f2 | f4 f | f2 \bar "||"
  f2 | d4 g | f e | f2 \bar "||"
}

T_notes = \relative c' {
  c2 | d4 c | bes c \bar "||"
  c2 | d4 c | c c | c2 \bar "||"
  c2 | d4 c | bes a \bar "||"
  a2 | g4 d' | c bes | a2 \bar "||"
}

B_notes = \relative c {
  f2 | f4 f | f2 \bar "||"
  a2 | bes4 a | g f | c2 \bar "||"
  f2 | f4 f | f2 \bar "||"
  d2 | bes4 bes | c c | f2 \bar "||"
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
