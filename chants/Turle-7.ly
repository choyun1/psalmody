\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "James Turle (1802-1882)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis2 | g4 fis | fis e \bar "||"
  b'2 | e,4 a | a gis | a2 \bar "||"
  ais2 | b4 cis | d2 \bar "||"
  g,2 | g4 fis | e e | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | e4 d | b2 \bar "||"
  e4. d8 | cis4 a | fis' e8 d | cis2 \bar "||"
  fis2 | fis4 e | d2 \bar "||"
  e2 | e4 d | d cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | a4 a | b2 \bar "||"
  b2 | a4 cis | b b | a2 \bar "||"
  cis2 | fis,8 gis ais4 | b2 \bar "||"
  b2 | a4 a | b a8 g | fis2 \bar "||"
}

B_notes = \relative c {
  d2 | cis4 d | g2 \bar "||"
  gis2 | a4 fis | d e | a,2 \bar "||"
  fis'4. e8 | d4 cis | b2 \bar "||"
  e4. d8 | cis4 d | g, a | d2 \bar "||"
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
