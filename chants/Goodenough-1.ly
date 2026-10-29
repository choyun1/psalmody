\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Robert Philip Goodenough (1775-1826)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | b4 d | a2 \bar "||"
  b4. a8 | g4 fis | e e | d2 \bar "||"
  b'2 | c4 b | a2 \bar "||"
  g2 | e8 fis g4 | g fis | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | d2 \bar "||"
  d2 | d4 d | d cis | d2 \bar "||"
  d2 | e4 d8 e | fis2 \bar "||"
  d2 | e4 d | c c | b2 \bar "||"
}

T_notes = \relative c' {
  b2 | g4 g | fis2 \bar "||"
  g2 | g4 a | a4. g8 | fis2 \bar "||"
  g2 | g8 a b c | d2 \bar "||"
  g,2 | g4 g | a a | g2 \bar "||"
}

B_notes = \relative c' {
  g2 | g,4 b | d2 \bar "||"
  g,2 | b4 d | a a | d2 \bar "||"
  g2 | e8 fis g4 | d2 \bar "||"
  b2 | c4 b | a d | g,2 \bar "||"
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
