\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George J. Elvey (1816-1893)"}
  tagline=#f
}

global = {
  \key des \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | ges4 bes | as2 \bar "||"
  ges2 | f4 as | as g | as2 \bar "||"
  a2 | bes4 des | c2 \bar "||"
  c2 | des4 f, | es f8 ges | f2 \bar "||"
}

A_notes = \relative c' {
  des2 | des4 des | des2 \bar "||"
  c2 | des4 es | des des | es2 \bar "||"
  f2 | f4 f | f2 \bar "||"
  es2 | des4 des | des c | des2 \bar "||"
}

T_notes = \relative c' {
  as2 | bes4 ges | f2 \bar "||"
  as2 | as4 as | bes des | c2 \bar "||"
  c2 | des4 bes | a2 \bar "||"
  as2 | as4 as | bes as | as2 \bar "||"
}

B_notes = \relative c {
  des2 | des4 des | des2 \bar "||"
  as2 | des4 c | bes bes | as2 \bar "||"
  f'2 | f4 f | f2 \bar "||"
  ges2 | f4 des | ges as | des,2 \bar "||"
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
