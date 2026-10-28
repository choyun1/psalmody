\version "2.24.1"

\header{
  composer = \markup{\hspace #-31.5 \italic "William Crotch (1775-1847)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative g' {
  c2 | e,4 d | c2 \bar "||"
  d2 | e4 c' | b a | g2 | \bar "||"
  e4. f8 | g4 a8 b | c2 \bar "||"
  d2 | e4 d8 c | c4 b | c2 | \bar "||"
}

A_notes = \relative c' {
  e2 | c4 b | c2 \bar "||"
  b2 | c4 e | b d8 c | b2 | \bar "||"
  c4. d8 | e8 f g4 | e2 \bar "||"
  g2 | e4 f | e d | e2 | \bar "||"
}

T_notes = \relative a {
  g2 | g4 g | e2 \bar "||"
  g2 | g4 a | g fis | g2 | \bar "||"
  g2 | e'4 d | c2 \bar "||"
  b2 | c4 a | g g | g2 | \bar "||"
}

B_notes =  \relative c {
  c2 | c4 g | a2 \bar "||"
  g2 | c4 a | d d | g,2 | \bar "||"
  c2 | c'4 b | a2 \bar "||"
  g2 | c4 f, | g g | c,2 | \bar "||"
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