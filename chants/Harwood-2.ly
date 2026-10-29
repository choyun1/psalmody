\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Basil Harwood (1859-1949)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c'' {
  as2 | bes4 des | des2 \bar "||"
  c2 | bes4 as | g bes | as2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 as | g2 \bar "||"
  es2 | f4 f | es8 f es des | c2 \bar "||"
}

T_notes = \relative c' {
  c2 | bes4 as | bes2 \bar "||"
  c2 | des4 des | bes8 as g4 | as2 \bar "||"
}

B_notes = \relative c' {
  as2 | g4 f | es2 \bar "||"
  as2 | des,4 bes | es es | as,2 \bar "||"
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
