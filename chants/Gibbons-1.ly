\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Christopher Gibbons (1615-1676)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | d4 g, | fis2 \bar "||"
  a2 | c4 b | a a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 cis | d2 \bar "||"
  f2 | e8 fis g4 | g fis | g2 \bar "||"
}

T_notes = \relative c' {
  g2 | g4 g | a2 \bar "||"
  a2 | a4 d | d4. c8 | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | b,4 e | d2 \bar "||"
  d2 | a4 b8 c | d4 d | g,2 \bar "||"
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
