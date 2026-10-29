\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Leman Rogers (1780-1847)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c'' {
  c2 | es4 des | c2 \bar "||"
  as2 | as4 bes | c bes8 as | g2 \bar "||"
  g2 | g4 a | bes2 \bar "||"
  g2 | as4 as | as g | as2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | es2 \bar "||"
  des2 | es4 es | es d | es2 \bar "||"
  es2 | es4 f | f2 \bar "||"
  e2 | f4 f | es es | es2 \bar "||"
}

T_notes = \relative c' {
  as2 | as4 g | as2 \bar "||"
  f2 | as4 g | as as | bes2 \bar "||"
  bes2 | c4 c | des2 \bar "||"
  c2 | c4 des | c bes | c2 \bar "||"
}

B_notes = \relative c' {
  as2 | c,4 es | as,2 \bar "||"
  des2 | c4 bes | as f' | es2 \bar "||"
  es2 | c4 f | bes,2 \bar "||"
  c2 | f4 des | es es | as,2 \bar "||"
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
