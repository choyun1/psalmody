\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Robert Hindes Groome (1810-1889)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c'' {
  as2 | bes4 c | f,2 \bar "||"
  a2 | bes4 c | des bes | as4 g \bar "||"
  c2 | as4 ges | f2 \bar "||"
  g2 | as4 c8 bes | as4 g | as2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | des2 \bar "||"
  es2 | des4 f | f des | c4 bes \bar "||"
  c2 | c4 es | des2 \bar "||"
  des2 | es4 f | es4. des8 | c2 \bar "||"
}

T_notes = \relative c' {
  c2 | g4 as | as2 \bar "||"
  c2 | des4 c | bes f | es2 \bar "||"
  g2 | as4 as | as2 \bar "||"
  bes2 | as4 des | c bes | as2 \bar "||"
}

B_notes = \relative c' {
  as2 | es4 as, | des2 \bar "||"
  c2 | bes4 a | bes des | es2 \bar "||"
  e2 | f4 c | des2 \bar "||"
  bes2 | c4 des | es es | as,2 \bar "||"
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
