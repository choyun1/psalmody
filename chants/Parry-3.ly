\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles H. H. Parry (1848-1918)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | g4 c | a2 \bar "||"
  g2 | f4 d' | c bes | c2 \bar "||"
  c2 | d4 a | bes2 \bar "||"
  a2 | g4 es' | d c | bes2 \bar "||"
}

A_notes = \relative c' {
  f2 | es4 g | f2 \bar "||"
  c2 | f4 f | g d | f2 \bar "||"
  g2 | fis4 a | g2 \bar "||"
  f2 | es4 g | f es8 d | d2 \bar "||"
}

T_notes = \relative c' {
  bes2 | bes4 es | c2 \bar "||"
  a2 | bes4 bes | g g | a2 \bar "||"
  g2 | a4 d | d2 \bar "||"
  d4. c8 | bes4 bes | bes a | bes2 \bar "||"
}

B_notes = \relative c {
  d2 | es4 c | f2 \bar "||"
  es2 | d4 bes | es g | f2 \bar "||"
  es2 | d4 fis | g2 \bar "||"
  d2 | es4 c | d8 es f4 | bes,2 \bar "||"
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
