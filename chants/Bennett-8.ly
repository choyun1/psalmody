\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George John Bennett (1863-1930)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | as4 bes | es2 \bar "||"
  g,2 | bes4 as | g f | g2 \bar "||"
  c2 | f,4 g | as2 \bar "||"
  bes2 | es,4 f | as4. g8 | g2 \bar "||"
}

A_notes = \relative c' {
  es2 | f4 f | es2 \bar "||"
  es2 | g4 f | es d | d2 \bar "||"
  e2 | d4 c | c2 \bar "||"
  f2 | es4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | c4 bes | bes as \bar "||"
  bes2 | des4 c | c c | b2 \bar "||"
  g2 | bes4 bes | as2 \bar "||"
  as2 | g4 as | f bes | bes2 \bar "||"
}

B_notes = \relative c {
  es2 | es4 d | c2 \bar "||"
  es2 | e4 f | as as | g2 \bar "||"
  c,2 | d4 e | f2 \bar "||"
  d2 | c4 ces | bes bes | es2 \bar "||"
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
