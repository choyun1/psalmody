\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Clement Martin (1844-1916)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | g4 f | es2 \bar "||"
  c'2 | f,4 g | as g8 f | g2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 d | es2 \bar "||"
  f4. es8 | d4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  g2 | bes4 as | g2 \bar "||"
  as2 | bes4 bes | c bes | bes2 \bar "||"
}

B_notes = \relative c {
  es2 | es4 b | c2 \bar "||"
  as2 | as'4 g | f bes, | es2 \bar "||"
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
