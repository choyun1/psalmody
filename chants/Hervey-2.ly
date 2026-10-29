\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Frederick Alfred John Hervey (1846-1910)"}
  tagline=#f
}

global = {
  \key f \minor
  \time 2/4
}


S_notes = \relative c'' {
  as2 | g4 g | f2 \bar "||"
  bes2 | bes4 as | as g | as2 \bar "||"
  c2 | bes4 bes | as2 \bar "||"
  g2 | g4 f | f e | f2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 es | des2 \bar "||"
  f2 | es4 es | es es | es2 \bar "||"
  f2 | f4 e | f2 \bar "||"
  des2 | c4 c | c c | c2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 c | as2 \bar "||"
  des2 | des4 c | bes bes | c2 \bar "||"
  c2 | des4 c8 bes | c2 \bar "||"
  bes2 | bes4 as | g g | as2 \bar "||"
}

B_notes = \relative c {
  f2 | c4 c | des2 \bar "||"
  bes4. as8 | g4 as | es' es | as,2 \bar "||"
  as'2 | g4 g | f2 \bar "||"
  g4. f8 | e4 f | c c | f,2 \bar "||"
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
