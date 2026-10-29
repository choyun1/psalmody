\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Philip Armes (1836-1908)"}
  tagline=#f
}

global = {
  \key des \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | es4 f | ges2 \bar "||"
  f2 | bes4 as | ges f | es2 \bar "||"
  c'2 | bes4 c | des2 \bar "||"
  c2 | des4 f, | as as | as2 \bar "||"
}

A_notes = \relative c' {
  des2 | des4 des | des2 \bar "||"
  des2 | ges4 f | es des | c2 \bar "||"
  es2 | des4 es | f2 \bar "||"
  es2 | des4 des | des es | f2 \bar "||"
}

T_notes = \relative c' {
  as2 | ges4 as | bes2 \bar "||"
  as2 | c4 des | bes bes | c2 \bar "||"
  as2 | as4 as | as2 \bar "||"
  as2 | as4 as | bes c | des2 \bar "||"
}

B_notes = \relative c {
  des2 | des4 des | ges2 \bar "||"
  des2 | es4 f | ges g | as2 \bar "||"
  as,2 | as4 as | as'2 \bar "||"
  ges2 | f4 des | as as | des2 \bar "||"
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
