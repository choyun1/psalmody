\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Henry Thomas Smart (1813-1879)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c'' {
  c2 | es4 g, | as2 \bar "||"
  g2 | f4 as | bes as8 g | as2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 des | c2 \bar "||"
  es2 | des4 es | f es | es2 \bar "||"
}

T_notes = \relative c' {
  as2 | bes4 bes | as2 \bar "||"
  c2 | as4 as | des c8 bes | c2 \bar "||"
}

B_notes = \relative c' {
  as2 | g4 es | f2 \bar "||"
  c2 | des4 c | bes es | as,2 \bar "||"
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
