\version "2.24.1"

\header{
  composer = \markup{\hspace #-49.5 \italic "James Nares (1715-1783)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative g' {
  cis2 | d4 cis8 b | a4 gis \bar "||"
  a2 | fis4 d' | cis b | a2 | \bar "||"
}

A_notes = \relative c' {
  e2 | fis4 fis | e2 \bar "||"
  e2 | d4 fis | e4. d8 | cis2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 d | cis b \bar "||"
  a2 | a4 a | a gis | a2 | \bar "||"
}

B_notes =  \relative c {
  a'2 | fis4 d | e2 \bar "||"
  cis2 | d4 b | e e | a,2 | \bar "||"
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