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
  f2 | f4 f | bes2 \bar "||"
  a2 | f4 g | a g | f2 \bar "||"
  bes2 | bes4 bes | es2 \bar "||"
  a,2 | bes4 c | d c | bes2 \bar "||"
}

A_notes = \relative c' {
  d2 | es4 d | e2 \bar "||"
  f2 | f4 f | f e | f2 \bar "||"
  d2 | g4 f | es2 \bar "||"
  f2 | f4 g | f f8 es | d2 \bar "||"
}

T_notes = \relative c' {
  bes2 | c4 bes | c2 \bar "||"
  c2 | c4 d | c c8 bes | a2 \bar "||"
  bes2 | bes4 bes | c2 \bar "||"
  c2 | bes4 bes | bes a | bes2 \bar "||"
}

B_notes = \relative c' {
  bes2 | a4 bes | g2 \bar "||"
  f2 | a,4 bes | c c | f2 \bar "||"
  g2 | es4 d | c2 \bar "||"
  f2 | d4 es | f f | bes,2 \bar "||"
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
