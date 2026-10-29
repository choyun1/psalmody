\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Benjamin Cooke (1734-1793)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  c2 | a4 f | d'2 \bar "||"
  bes2 | c4 bes8 a | g4 g | f2 \bar "||"
}

A_notes = \relative c' {
  f2 | e4 f | d2 \bar "||"
  d2 | c4 f | f e | f2 \bar "||"
}

T_notes = \relative c' {
  a2 | c4 a | bes2 \bar "||"
  bes2 | g4 c | c4. bes8 | a2 \bar "||"
}

B_notes = \relative c {
  f2 | c4 d | bes2 \bar "||"
  g'2 | e4 f | c c | f2 \bar "||"
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
