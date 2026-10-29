\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Macpherson (1870-1927)"}
  tagline=#f
}

global = {
  \key c \minor
  \time 2/4
}


S_notes = \relative c'' {
  g2 | g4 f | f2 \bar "||"
  bes2 | bes4 as | g es8 f | g2 \bar "||"
  c2 | c4 bes | bes2 \bar "||"
  as2 | as4 f | es d | c2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | d2 \bar "||"
  des2 | c4 c | c c | d2 \bar "||"
  g2 | f8 es d4 | es des \bar "||"
  c2 | des4 des | c b | c2 \bar "||"
}

T_notes = \relative c' {
  c2 | bes4 a | bes2 \bar "||"
  g4. f8 | e4 f | g c | c b \bar "||"
  c4. bes8 | as4 as | g2 \bar "||"
  es4. ges8 | f4 as | g4. f8 | es2 \bar "||"
}

B_notes = \relative c {
  c2 | c4 f | bes,2 \bar "||"
  bes2 | c4 f | es as | g2 \bar "||"
  e2 | f4 bes, | es2 \bar "||"
  as,2 | des4 f | g g, | c2 \bar "||"
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
