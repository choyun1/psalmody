\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Myles B. Foster (1851-1922)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c' {
  es2 | as4 g | as2 \bar "||"
  bes2 | c4 bes | g f | es2 \bar "||"
  as2 | des4 c | bes2 \bar "||"
  bes2 | es4 c8 bes | as4 bes | as2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | es2 \bar "||"
  es2 | es4 es | es d | es2 \bar "||"
  es2 | des4 es | f2 \bar "||"
  es2 | es4 f | es g | as2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 bes | c2 \bar "||"
  bes2 | as4 bes | bes4 bes8 as | g2 \bar "||"
  as2 | as4 as | as2 \bar "||"
  g2 | as4 as8 bes | c4 des | c2 \bar "||"
}

B_notes = \relative c' {
  as2 | as4 es | as2 \bar "||"
  g2 | as4 g | bes bes, | es2 \bar "||"
  c2 | f4 es | des2 \bar "||"
  des2 | c4 des | es es | as2 \bar "||"
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
