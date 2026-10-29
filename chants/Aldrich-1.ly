\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Henry Aldrich (1647-1710)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | c4 a | g2 \bar "||"
  g2 | a4 c | c4 b | c2 \bar "||"
  a2 | d4 c | bes2 \bar "||"
  c2 | a4 bes | a4 g | f2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 f | e2 \bar "||"
  e2 | f4 g | g4 g | e2 \bar "||"
  f2 | f4 fis | g2 \bar "||"
  g2 | f4 g | f4 e | f2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 c | c2 \bar "||"
  c2 | c4 c | d4 d | c2 \bar "||"
  c2 | bes4 d | d2 \bar "||"
  c2 | c4 d | c4 bes | a2 \bar "||"
}

B_notes = \relative c {
  f2 | a4 f | c2 \bar "||"
  c2 | f4 e | g4 g, | c2 \bar "||"
  f2 | bes4 a | g2 \bar "||"
  e2 | f4 bes, | c4 c | f2 \bar "||"
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
