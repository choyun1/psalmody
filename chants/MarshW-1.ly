\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Marsh (1757-1818)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c' {
  es2 | f4 g | as2 \bar "||"
  bes2 | c4 es | des c | c bes \bar "||"
  c2 | as4 bes | as g \bar "||"
  as2 | f4 bes | as g | as2 \bar "||"
}

A_notes = \relative c' {
  c2 | des4 des | c2 \bar "||"
  es2 | es4 c | des es | es2 \bar "||"
  es2 | es4 f | es2 \bar "||"
  es2 | des4 f | es es | es2 \bar "||"
}

T_notes = \relative c' {
  as2 | as4 bes | es,2 \bar "||"
  g2 | as4 as | g as | as g \bar "||"
  as2 | es'4 des | c bes \bar "||"
  as2 | as4 des | c bes | c2 \bar "||"
}

B_notes = \relative c {
  as2 | des4 bes | as2 \bar "||"
  es'2 | as,4 c | bes as | es'2 \bar "||"
  as2 | c,4 des | es2 \bar "||"
  c2 | des4 bes | es es | as,2 \bar "||"
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
