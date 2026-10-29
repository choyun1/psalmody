\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "L. S. Tuckwell"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | bes4 a | g2 \bar "||"
  g2 | c4 f, | f e | f2 \bar "||"
}

A_notes = \relative c' {
  c2 | d8 e f4 | e2 \bar "||"
  c2 | c4 bes | c c | c2 \bar "||"
}

T_notes = \relative c' {
  a2 | bes4 c | c2 \bar "||"
  e,2 | f4 f | g g | a2 \bar "||"
}

B_notes = \relative c' {
  a2 | g4 f | c2 \bar "||"
  bes2 | a4 d | c c | f,2 \bar "||"
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
