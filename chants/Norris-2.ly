\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Norris (1741-1790)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c'' {
  as2 | c4 es | as,2 \bar "||"
  as4. g8 | f g as4 | des c | bes2 \bar "||"
  bes2 | es4 c | des2 \bar "||"
  bes2 | c4 des | c bes | as2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | f2 \bar "||"
  es2 | des4 es | f8 g as4 | g2 \bar "||"
  es2 | es4 f | f2 \bar "||"
  es2 | es4 f | es4. des8 | c2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 bes | c2 \bar "||"
  as2 | as8 bes c4 | des es | es2 \bar "||"
  g,2 | c4 a | bes2 \bar "||"
  g2 | as4 as | as g | as2 \bar "||"
}

B_notes = \relative c' {
  as2 | as4 g | f2 \bar "||"
  c2 | des4 c | bes as | es'2 \bar "||"
  es2 | c4 f | bes,2 \bar "||"
  es2 | as4 des, | es es | as,2 \bar "||"
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
