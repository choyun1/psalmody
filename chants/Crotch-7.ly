\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Crotch (1775-1847)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | a4 g | fis2 \bar "||"
  g2 | a4 b | c b | a2 \bar "||"
  a2 | b4 c | d2 \bar "||"
  g,2 | c4 b | b a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | c4 b | d2 \bar "||"
  d2 | fis4 g | d d | d2 \bar "||"
  fis2 | g4 a | g2 \bar "||"
  g2 | d4 d | d4. c8 | b2 \bar "||"
}

T_notes = \relative c' {
  d2 | d4 d | d2 \bar "||"
  d2 | c4 b | a g | fis2 \bar "||"
  d'2 | d4 d | d2 \bar "||"
  b2 | a4 g | g fis | g2 \bar "||"
}

B_notes = \relative c' {
  g2 | a4 b | c2 \bar "||"
  b2 | a4 g | fis g | d2 \bar "||"
  d2 | d'4 c | b2 \bar "||"
  e,2 | fis4 g | d d | g,2 \bar "||"
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
