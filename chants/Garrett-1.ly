\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Mursell Garrett (1834-1897)"}
  tagline=#f
}

global = {
  \key e \major
  \time 2/4
}


S_notes = \relative c'' {
  gis2 | fis4 e | a2 \bar "||"
  gis2 | ais4 b | dis4. cis8 | b2 \bar "||"
  fis2 | e4 dis | gis2 \bar "||"
  a2 | b4 cis | gis fis | e2 \bar "||"
}

A_notes = \relative c' {
  e2 | dis4 e | fis2 \bar "||"
  e2 | fis4 fis | fis4. e8 | dis2 \bar "||"
  dis2 | e4 dis | d2 \bar "||"
  cis2 | b4 e | e dis | b2 \bar "||"
}

T_notes = \relative c' {
  b2 | a4 b | b2 \bar "||"
  b2 | cis4 b | b ais | b2 \bar "||"
  b2 | b4 b | b2 \bar "||"
  a2 | gis4 cis | b4. a8 | gis2 \bar "||"
}

B_notes = \relative c {
  e2 | fis4 gis | dis2 \bar "||"
  e2 | e4 dis | fis fis | b,2 \bar "||"
  a'2 | gis4 fis | eis2 \bar "||"
  fis2 | gis4 a | b b, | e2 \bar "||"
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
