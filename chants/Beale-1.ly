\version "2.24.1"

\header{
  composer = \markup{\hspace #-30 \italic "William Beale (1784-1854)"}
  tagline=#f
}

global = {
  \key a \minor
  \time 2/4
}


S_notes = \relative g' {
  c2 | b4 a | gis2 \bar "||"
  a2 | a4 a | d c | b2 | \bar "||"
  c2 | d4 e | f2 \bar "||"
  b,2 | e4 a,8 b | c4 b | a2 | \bar "||"
}

A_notes = \relative c' {
  e2 | e4. d8 | e2 \bar "||"
  e2 | f4 e | gis a | gis2 | \bar "||"
  e2 | a4 g | f2 \bar "||"
  e2 | e4 f | e4. d8 | c2 | \bar "||"
}

T_notes = \relative a {
  c2 | g4 a | b2 \bar "||"
  a2 | a4 a | b c8 d | e2 | \bar "||"
  e2 | d4 cis | d2 \bar "||"
  gis,2 | a4 a | a gis | a2 | \bar "||"
}

B_notes =  \relative c {
  a'2 | g4 f | e2 \bar "||"
  c2 | d4 e | b a | e'2 | \bar "||"
  a2 | f4 e | d2 \bar "||"
  e4. d8 | c4 d | e e | a,2 | \bar "||"
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