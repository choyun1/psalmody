\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Alan Gray (1855-1935)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | d4 f | bes2 \bar "||"
  c2 | d4 bes | es d | c2 \bar "||"
  bes2 | d4 bes | g2 \bar "||"
  g2 | f4 bes | c c | bes2 \bar "||"
}

A_notes = \relative c' {
  d2 | bes4 c | d2 \bar "||"
  f2 | f4 d | g f | f2 \bar "||"
  f2 | d4 f | es2 \bar "||"
  es2 | f4 d | g f | d2 \bar "||"
}

T_notes = \relative c' {
  bes2 | d4 c | bes2 \bar "||"
  a2 | a4 bes | bes bes | a2 \bar "||"
  bes2 | bes4 bes | bes2 \bar "||"
  c2 | c4 bes | bes a | bes2 \bar "||"
}

B_notes = \relative c {
  bes2 | bes'4 a | f2 \bar "||"
  f2 | d4 g | es bes | f'2 \bar "||"
  d2 | bes4 d | es2 \bar "||"
  c2 | d4 g | es f | bes,2 \bar "||"
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
