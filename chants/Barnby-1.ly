\version "2.24.1"

\header{
  composer = \markup{\hspace #-31.5 \italic "Joseph Barnby (1838-1896)"}
  tagline=#f
}

global = {
  \key a \minor
  \time 2/4
}


S_notes = \relative g' {
  e2 | g4 f | e2 \bar "||"
  gis2 | a4 b | c d | b2 | \bar "||"
  c2 | e4 d | b2 \bar "||"
  c2 | a4 b | e,4 gis | a2 | \bar "||"
}

A_notes = \relative c' {
  e2 | d4 c | b2 \bar "||"
  e2 | e4 e | e f | e2 | \bar "||"
  e2 | g4 f | d2 \bar "||"
  e2 | c4 f | e4. d8 | c2 | \bar "||"
}

T_notes = \relative a {
  c2 | b4 a | gis2 \bar "||"
  b2 | a4 gis | a a | gis2 | \bar "||"
  a2 | a4 a | g2 \bar "||"
  g2 | a4 d | c b | a2 | \bar "||"
}

B_notes =  \relative c {
  a'2 | d,4 d | e2 \bar "||"
  d2 | c4 e | a d, | e2 | \bar "||"
  a2 | d,4 d | g2 \bar "||"
  c,2 | f4 d | e e | a,2 | \bar "||"
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