\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Samuel Wesley (1766-1837)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | a4 g | c2 \bar "||"
  b2 | a4 fis | g a | fis2 \bar "||"
  a2 | b4 c | d2 \bar "||"
  c2 | b4 a8 e | g4 fis | g2 \bar "||"
}

A_notes = \relative c'' {
  g2 | fis4 g | e2 \bar "||"
  g2 | e4 d | d cis | d2 \bar "||"
  d2 | d4 c | e2 \bar "||"
  e4. fis8 | g4 e | d d | d2 \bar "||"
}

T_notes = \relative c' {
  d2 | c4 b | a2 \bar "||"
  d2 | c4 b | b a | a2 \bar "||"
  fis2 | gis4 a | b2 \bar "||"
  a2 | d4 c | b c | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | d4 e | a,2 \bar "||"
  b2 | c4 d | e a, | d2 \bar "||"
  c2 | b4 a | gis2 \bar "||"
  a2 | b4 c | d d | g,2 \bar "||"
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
