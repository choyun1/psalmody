\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Alfred Hollins (1865-1942)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c' {
  es2 | f4 es | as2 \bar "||"
  bes2 | c4 es | des bes | as4 g \bar "||"
  bes2 | bes4 as | des2 \bar "||"
  c2 | bes4 f | as g | as2 \bar "||"
}

A_notes = \relative c' {
  c2 | bes4 es | es2 \bar "||"
  es2 | es4 ges | f f | es2 \bar "||"
  c2 | ges'4 ges | f2 \bar "||"
  es2 | des4 f | es des | c2 \bar "||"
}

T_notes = \relative c' {
  as2 | f4 g | as2 \bar "||"
  g2 | as4 as | as des | c4 bes \bar "||"
  as2 | des4 c | des2 \bar "||"
  a2 | bes4 bes | c bes | as2 \bar "||"
}

B_notes = \relative c {
  as2 | des4 des | c2 \bar "||"
  es2 | c4 c | des des | es2 \bar "||"
  f2 | es4 es | des2 \bar "||"
  f2 | bes,4 des | es es | as,2 \bar "||"
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
