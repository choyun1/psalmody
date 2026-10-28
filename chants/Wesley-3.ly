\version "2.24.1"

\header{
  composer = \markup{\hspace #-41.5 \italic "Samuel Sebastian Wesley (1810-1876)"}
  tagline=#f
}

global = {
  \key fis \minor
  \time 2/4
}


S_notes = \relative g' {
  a2 | a4 a | gis2 \bar "||"
  a2 | fis4 a | gis fis | eis2 | \bar "||"
  a2 | d4 b | gis2 \bar "||"
  cis2 | fis,4 gis | fis eis | fis2 \bar "||"
}

A_notes = \relative c' {
  cis2 | b8 cis d4 | d2 \bar "||"
  cis2 | d4 fis | d b | cis2 | \bar "||"
  cis2 | fis4 d | b2 \bar "||"
  e2 | d4 d | cis4. b8 | a2 | \bar "||"
}

T_notes = \relative a {
  fis2 | fis4 b | b2 \bar "||"
  a2 | a4 cis | b fis | gis2 | \bar "||"
  fis2 | fis4 fis | e2 \bar "||"
  cis'2 | a4 b | a gis | fis2 | \bar "||"
}

B_notes =  \relative c {
  fis2 | d4 b | e2 \bar "||"
  a,2 | d4 a | b d | cis2 | \bar "||"
  fis2 | b,4 d | e2 \bar "||"
  a,2 | d4 b | cis cis | fis,2 | \bar "||"
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