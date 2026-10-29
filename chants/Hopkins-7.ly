\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edward John Hopkins (1818-1901)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | c'4 bes | a2 \bar "||"
  bes2 | g4 a | f f | e2 \bar "||"
  c'2 | bes4 a | d2 \bar "||"
  bes2 | bes4 a | g g | f2 \bar "||"
}

A_notes = \relative c' {
  c2 | f4 d8 e | f2 \bar "||"
  f2 | c4 c | c b | c2 \bar "||"
  e2 | fis4 fis | g2 \bar "||"
  g2 | e4 f | f e | f2 \bar "||"
}

T_notes = \relative c' {
  a2 | a4 bes | c2 \bar "||"
  bes2 | bes4 a | a f | g2 \bar "||"
  c2 | d4 d | d2 \bar "||"
  d2 | bes4 c | d c8 bes | a2 \bar "||"
}

B_notes = \relative c {
  f2 | a4 g | f2 \bar "||"
  d2 | e4 f | d d | c2 \bar "||"
  a'2 | d4 c | bes2 \bar "||"
  g2 | g,4 a | bes c | f2 \bar "||"
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
