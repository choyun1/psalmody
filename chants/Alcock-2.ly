\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Walter Galpin Alcock (1861-1947)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c' {
  d4. es8 | f4 f | g2 \bar "||"
  f2 | g4 a | bes g | c2 \bar "||"
  a2 | bes4 c | d2 \bar "||"
  g,2 | g4 a8 bes | c4 c | bes2 \bar "||"
}

A_notes = \relative c' {
  d4. c8 | bes4 a | g2 \bar "||"
  c2 | f4 es | d e | f2 \bar "||"
  f4. es8 | d4 g | g fis \bar "||"
  f2 | es4 es | c8 d es4 | d2 \bar "||"
}

T_notes = \relative c {
  f2 | d'4 c | bes2 \bar "||"
  a2 | bes4 c | bes bes | a2 \bar "||"
  c2 | bes4 g | a2 \bar "||"
  d2 | d4 c8 bes | bes4 a | bes2 \bar "||"
}

B_notes = \relative c {
  bes2 | bes4 c8 d | es2 \bar "||"
  es2 | d4 c | g' g | f2 \bar "||"
  f2 | g4 es | d2 \bar "||"
  b2 | c4 g' | f f | bes,2 \bar "||"
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
