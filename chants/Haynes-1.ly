\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Walter Battison Haynes (1859-1900)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  c2 | g4 a | f2 \bar "||"
  g2 | a4 f | a b | c2 \bar "||"
  c2 | g4 a | f2 \bar "||"
  fis2 | a4 g | bes g | f2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 e | f2 \bar "||"
  c2 | c4 c | c f | e2 \bar "||"
  f2 | f4 e | d2 \bar "||"
  d2 | d4 d | bes bes | a2 \bar "||"
}

T_notes = \relative c' {
  a2 | d4 c | a2 \bar "||"
  c2 | a4 c | a f | g2 \bar "||"
  c2 | d4 c | a2 \bar "||"
  a2 | fis4 g | d e | f2 \bar "||"
}

B_notes = \relative c {
  f2 | bes,4 c | f2 \bar "||"
  e2 | f4 a | f d | c2 \bar "||"
  a2 | bes4 c | d2 \bar "||"
  d2 | c4 bes | g c | f2 \bar "||"
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
