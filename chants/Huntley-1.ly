\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Frederick William Huntley (1859-1913)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | e4 fis | gis2 \bar "||"
  b2 | a4 gis | a d | cis2 \bar "||"
  gis2 | a4 fis | eis2 \bar "||"
  fis2 | fis4 b | gis gis | a2 \bar "||"
}

A_notes = \relative c' {
  e2 | cis4 dis | e2 \bar "||"
  fis2 | e4 e | e e | e2 \bar "||"
  cis2 | cis4 d | cis2 \bar "||"
  cis2 | b4 fis' | fis e | e2 \bar "||"
}

T_notes = \relative c' {
  cis2 | b4 a | b2 \bar "||"
  b2 | e4. d8 | cis4 b | cis2 \bar "||"
  b2 | a4 gis | gis2 \bar "||"
  fis2 | fis4 d' | b cis8 d | cis2 \bar "||"
}

B_notes = \relative c' {
  a2 | gis4 fis | e2 \bar "||"
  d2 | cis4 e | fis gis | a2 \bar "||"
  eis2 | fis4 b, | cis2 \bar "||"
  a2 | d4 b | e e | a,2 \bar "||"
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
