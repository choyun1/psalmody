\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Tertius Noble (1867-1953)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | bes4 a | f2 \bar "||"
  g2 | c4 bes | g g | a2 \bar "||"
  a2 | d4 c | bes2 \bar "||"
  g2 | a4 bes | g f | f2 \bar "||"
}

A_notes = \relative c' {
  d2 | f4 es | f2 \bar "||"
  es2 | g4 f | es es | f2 \bar "||"
  f2 | d4 d | d2 \bar "||"
  es2 | f4 f | es d | d2 \bar "||"
}

T_notes = \relative c' {
  bes2 | d4 c | bes2 \bar "||"
  bes2 | es4 d | bes c | c2 \bar "||"
  c2 | a4 a | bes2 \bar "||"
  bes2 | c4 bes | bes a | bes2 \bar "||"
}

B_notes = \relative c {
  bes2 | bes4 c | d2 \bar "||"
  es2 | c4 d | es c | f2 \bar "||"
  f2 | fis4 fis | g2 \bar "||"
  es2 | es4 d | c f | bes,2 \bar "||"
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
