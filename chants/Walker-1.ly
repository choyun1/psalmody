\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Frederick Edward Walker (1835-?)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c'' {
  as2 | bes4 es, | c'2 \bar "||"
  c2 | es4 des | as bes | c2 \bar "||"
  c2 | a4 f | des'2 \bar "||"
  g,2 | as4 as | c bes | as2 \bar "||"
}

A_notes = \relative c' {
  es2 | f4 es | es2 \bar "||"
  es2 | c4 des | f f | e2 \bar "||"
  f2 | f4 es | des2 \bar "||"
  des2 | c4 d | es es | es2 \bar "||"
}

T_notes = \relative c' {
  c2 | bes4 g | as2 \bar "||"
  as2 | as4 as | as g8 f | g2 \bar "||"
  a2 | c4 a | bes2 \bar "||"
  bes2 | as4 as | as g8 des' | c2 \bar "||"
}

B_notes = \relative c' {
  as2 | des,4 es | as2 \bar "||"
  as2 | ges4 f | des des | c2 \bar "||"
  f2 | f4 f | bes,2 \bar "||"
  e2 | f4 fes | es es | as,2 \bar "||"
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
