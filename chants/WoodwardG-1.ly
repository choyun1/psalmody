\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Woodward"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c' {
  es2 | es4 es | as2 \bar "||"
  c2 | bes4 as | as g | as2 \bar "||"
}

A_notes = \relative c' {
  c2 | des4 c | c2 \bar "||"
  es2 | f4 f | es es | es2 \bar "||"
}

T_notes = \relative c' {
  as2 | bes4 as | as2 \bar "||"
  as2 | f4 des'8 c | bes4 bes | c2 \bar "||"
}

B_notes = \relative c' {
  as2 | g4 as | f2 \bar "||"
  c2 | des4 des | es es | as,2 \bar "||"
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
