\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Joseph Barnby (1838-1896)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c' {
  es2 | as4 g | bes2 \bar "||"
  as2 | des4 c | bes bes | as2 \bar "||"
}

A_notes = \relative c' {
  c2 | es4 es | es2 \bar "||"
  es2 | des4 es | f es8 des | c2 \bar "||"
}

T_notes = \relative c' {
  as2 | as4 bes | g2 \bar "||"
  as2 | as4 as | as g | as2 \bar "||"
}

B_notes = \relative c {
  as2 | c4 bes | des2 \bar "||"
  c2 | f4 es | des es | as,2 \bar "||"
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
