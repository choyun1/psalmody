\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Henry Maunder (1858-1920)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | c4 f, | bes2 \bar "||"
  g2 | a4 g8 f | e4 f | g2 \bar "||"
  bes2 | d4 g, | c2 \bar "||"
  a2 | bes4 a8 g | f4 e | f2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 f | f2 \bar "||"
  e2 | f4 c | c4 b | c2 \bar "||"
  d2 | d4 d | es2 \bar "||"
  d2 | d4 d | c4 c | c2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 c | d2 \bar "||"
  c2 | c4 c | g4 f | e2 \bar "||"
  g2 | g4 g | g2 \bar "||"
  fis2 | g4 g | a4 bes | a2 \bar "||"
}

B_notes = \relative c {
  f2 | a4 a | g2 \bar "||"
  c,2 | f4 a | g4 g, | c2 \bar "||"
  g'2 | bes,4 bes | a2 \bar "||"
  d2 | g,4 bes | c4 c | f2 \bar "||"
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
