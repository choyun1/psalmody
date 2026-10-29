\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles H. H. Parry (1848-1918)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | a4 g | e2 \bar "||"
  g2 | bes4 a | f4 g | a2 \bar "||"
  a2 | d4 c | bes2 \bar "||"
  g2 | c4 a | f4 e | f2 \bar "||"
}

A_notes = \relative c' {
  d2 | f4 d | c2 \bar "||"
  d2 | g4 f | d4 d | e2 \bar "||"
  e2 | d4 a' | a4 g \bar "||"
  e2 | f4 f | d4 c | c2 \bar "||"
}

T_notes = \relative c' {
  a2 | c4 bes | g2 \bar "||"
  g2 | d'4 c | bes4 d | cis2 \bar "||"
  cis2 | d4 es | d2 \bar "||"
  c2 | c4 c | bes8 a g4 | a2 \bar "||"
}

B_notes = \relative c {
  d2 | a4 bes | c2 \bar "||"
  bes4. a8 | g4 a | bes4 bes' | a2 \bar "||"
  g2 | f4 fis | g2 \bar "||"
  c4. bes8 | a4 a, | bes4 c | f,2 \bar "||"
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
