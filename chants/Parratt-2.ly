\version "2.24.1"

\header{
  composer = \markup{\hspace #-31 \italic "Walter Parratt (1841-1924)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | a4 g | c2 \bar "||"
  c2 | d4 e | f a, | gis2 | \bar "||"
  e2 | f4 e | a2 \bar "||"
  g2 | c4 f, | e d | c2 | \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | e2 \bar "||"
  f2 | a4 g | f f | e2 | \bar "||"
  c2 | c4 c | c2 \bar "||"
  d2 | c4 d | c b | c2 | \bar "||"
}

T_notes = \relative a {
  c2 | c4 d | c2 \bar "||"
  a2 | b4 cis | d c? | b2 | \bar "||"
  c2 | bes4 bes | a2 \bar "||"
  b?2 | c4 a | g f | e2 | \bar "||"
}

B_notes =  \relative c {
  c2 | c'4 b | a2 \bar "||"
  f2 | f4 e | d d | e2 | \bar "||"
  a2 | g4 g | f2 \bar "||"
  f2 | e4 f | g g, | c2 | \bar "||"
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