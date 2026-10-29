\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Saunders Dupuis (1733-1796)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | bes4 a8 g | a2 \bar "||"
  f2 | bes8 c d4 | d c | bes2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 e | f2 \bar "||"
  c2 | f4 f | f4. es8 | d2 \bar "||"
}

T_notes = \relative c' {
  d2 | d4 c | c2 \bar "||"
  a2 | bes4 bes | bes a | bes2 \bar "||"
}

B_notes = \relative c' {
  bes2 | g4 c | f,2 \bar "||"
  f2 | d4 bes | f' f | bes,2 \bar "||"
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
