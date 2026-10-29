\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Joseph Barnby (1838-1896)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c' {
  es2 | as4 des | c2 \bar "||"
  bes2 | as4 c | es, f | es2 \bar "||"
  as2 | c4 es | des2 \bar "||"
  c2 | bes4 f | g es | as2 \bar "||"
}

A_notes = \relative c' {
  c2 | es4 des | es2 \bar "||"
  es2 | es4 es | es d | es2 \bar "||"
  es2 | es4 as | as2 \bar "||"
  f2 | f4 f | es des | c2 \bar "||"
}

T_notes = \relative c' {
  as2 | as4 as | as2 \bar "||"
  g2 | as4 f | g as | g2 \bar "||"
  as2 | as4 c | des2 \bar "||"
  a2 | bes4 des | bes g | as2 \bar "||"
}

B_notes = \relative c {
  as2 | c4 f | es2 \bar "||"
  des2 | c4 as | bes bes | es2 \bar "||"
  c2 | es4 ges | f2 \bar "||"
  f2 | des4 bes | es es | as,2 \bar "||"
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
