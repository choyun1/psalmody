\version "2.24.1"

\header{
  composer = \markup{\hspace #-36 \italic "Jonathan Battishill (1738-1801)"}
  tagline=#f
}

global = {
  \key a \minor
  \time 2/4
}


S_notes = \relative g' {
  a2 | g4 f | e2 \bar "||"
  c'2 | b4 a | d c | c b | \bar "||"
  c2 | b4 cis | d2 \bar "||"
  c2 | b4 a | e gis | a2 | \bar "||"
}

A_notes = \relative c' {
  e2 | d4 b | c2 \bar "||"
  e2 | f4 e | d e | e2 | \bar "||"
  e2 | e4 e | d2 \bar "||"
  g2 | f4 c8 d | e4. d8 | c2 | \bar "||"
}

T_notes = \relative a {
  c2 | d4 g, | g2 \bar "||"
  c2 | d4 e | gis, a | a gis | \bar "||"
  a2 | b4 g | a2 \bar "||"
  c2 | d4 a | c b | a2 | \bar "||"
}

B_notes =  \relative c {
  a2 | b4 g | c2 \bar "||"
  a2 | d4 c | b a | e'2 | \bar "||"
  a2 | g4 e | f2 \bar "||"
  e2 | d4 f | e e | a,2 | \bar "||"
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