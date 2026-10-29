\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Alan Gray (1855-1935)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | c4 d | f,2 \bar "||"
  bes2 | a4 bes | c e, | f2 \bar "||"
  g2 | a4 bes | es,2 \bar "||"
  d2 | es4 f | g c | bes2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 f | f2 \bar "||"
  e2 | f4 f | c c | c2 \bar "||"
  es2 | f4 bes, | c2 \bar "||"
  bes2 | bes4 bes | es es | d2 \bar "||"
}

T_notes = \relative c' {
  d2 | c4 bes | bes2 \bar "||"
  bes2 | c4 bes | a g | a2 \bar "||"
  bes2 | c4 f, | f2 \bar "||"
  bes2 | bes4 bes | bes a | bes2 \bar "||"
}

B_notes = \relative c' {
  bes2 | a4 bes | d,2 \bar "||"
  g2 | f4 d | c c | f2 \bar "||"
  es2 | es4 d | a2 \bar "||"
  bes2 | c4 d | es f | bes,2 \bar "||"
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
