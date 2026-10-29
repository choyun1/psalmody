\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Robert Philip Goodenough (1775-1826)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | bes4 g | c2 \bar "||"
  c2 | e,4 f | bes a | g f \bar "||"
  a2 | bes4 g | c2 \bar "||"
  c2 | e,4 f | g g | f2 \bar "||"
}

A_notes = \relative c' {
  f2 | e4 e | f2 \bar "||"
  f2 | c4 c | g' f | e d \bar "||"
  f2 | e4 e | f2 \bar "||"
  f2 | c4 f | f e | f2 \bar "||"
}

T_notes = \relative c' {
  c2 | bes4 bes | a2 \bar "||"
  c2 | c4 c | c c | c2 \bar "||"
  c2 | bes4 bes | a2 \bar "||"
  c2 | bes4 a | d c8 bes | a2 \bar "||"
}

B_notes = \relative c {
  f2 | g4 g | a2 \bar "||"
  a2 | bes4 a | e f | c2 \bar "||"
  f2 | g4 g | a2 \bar "||"
  a2 | g4 f | bes, c | f2 \bar "||"
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
