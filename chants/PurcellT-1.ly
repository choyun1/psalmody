\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Purcell (?-1682)"}
  tagline=#f
}

global = {
  \key f \minor
  \time 2/4
}


S_notes = \relative c'' {
  as2 | g4 f | e2 \bar "||"
  c'2 | f,4 g | f e | f2 \bar "||"
}

A_notes = \relative c' {
  c2 | c4. bes8 | c2 \bar "||"
  es2 | as,4 des | c c | c2 \bar "||"
}

T_notes = \relative c' {
  as2 | c4 f, | g2 \bar "||"
  g2 | f4 bes | as g | as2 \bar "||"
}

B_notes = \relative c {
  f2 | es4 des | c2 \bar "||"
  c2 | des4 bes | c c | <f f,>2 \bar "||"
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
