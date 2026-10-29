\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Cross (1777-1825)"}
  tagline=#f
}

global = {
  \key c \minor
  \time 2/4
}


S_notes = \relative c'' {
  c2 | g4 f | es2 \bar "||"
  g2 | c4 bes | as as | g2 \bar "||"
  g2 | g4 c8 bes | as2 \bar "||"
  g2 | f4 es | es d | c2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 d | c2 \bar "||"
  bes2 | c4 es | es d | es2 \bar "||"
  g2 | g4 e | f2 \bar "||"
  bes,2 | g4 c | c b | c2 \bar "||"
}

T_notes = \relative c' {
  g2 | g4 g | g2 \bar "||"
  es'2 | es4 bes | c bes | bes2 \bar "||"
  bes2 | c4 c | c2 \bar "||"
  es2 | d4 g, | g4. f8 | es2 \bar "||"
}

B_notes = \relative c {
  c2 | c4 c | c2 \bar "||"
  es2 | as4 g | f bes, | es2 \bar "||"
  es2 | e4 c | f2 \bar "||"
  es2 | b4 c | g g | c2 \bar "||"
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
