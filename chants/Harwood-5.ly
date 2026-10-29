\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Basil Harwood (1859-1949)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | g4 f | bes2 \bar "||"
  bes2 | c4 d | c g | a2 \bar "||"
  bes2 | c4 bes | es2 \bar "||"
  c2 | d4 es | g, f | bes2 \bar "||"
}

A_notes = \relative c' {
  d2 | es4 c | f2 \bar "||"
  d2 | f4 f | f e | f2 \bar "||"
  f2 | f4 f | es2 \bar "||"
  f2 | f4 g | es c | d2 \bar "||"
}

T_notes = \relative c' {
  bes2 | bes4 a | bes2 \bar "||"
  bes2 | a4 bes | g c | c2 \bar "||"
  d2 | c4 d | bes2 \bar "||"
  c2 | bes4 bes | c a | f2 \bar "||"
}

B_notes = \relative c {
  bes2 | es4 f | d2 \bar "||"
  g2 | f4 bes, | c c | f2 \bar "||"
  bes2 | a4 bes | g2 \bar "||"
  a2 | bes4 es, | c f | bes,2 \bar "||"
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
