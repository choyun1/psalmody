\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Jones (1728-1796)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | g4 fis | e2 \bar "||"
  b'2 | cis4 d | fis, e | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | cis4 d | cis2 \bar "||"
  d2 | e4 fis | d cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | a4 a | a2 \bar "||"
  b2 | g4 a | a4. g8 | fis2 \bar "||"
}

B_notes = \relative c {
  fis2 | e4 d | a'2 \bar "||"
  g2 | e4 d | a'4 a, | d2 \bar "||"
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
