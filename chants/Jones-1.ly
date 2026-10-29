\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Jones (1728-1796)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c'' {
  c2 | bes4 as | g2 \bar "||"
  as2 | as4 g | g f | es2 \bar "||"
  as2 | bes4 c | g2 \bar "||"
  bes2 | g4 as | as g | as2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 c | e2 \bar "||"
  f2 | f4 es | es d | es2 \bar "||"
  es2 | des4 c | es2 \bar "||"
  f2 | es4 es | es es | es2 \bar "||"
}

T_notes = \relative c' {
  as2 | g4 as | c2 \bar "||"
  c2 | bes4 bes | bes4. as8 | g2 \bar "||"
  as2 | g4 as | as2 \bar "||"
  des2 | bes4 c | bes bes | c2 \bar "||"
}

B_notes = \relative c' {
  as2 | es4 f | c2 \bar "||"
  f2 | d4 es | bes' bes, | es2 \bar "||"
  c2 | bes4 as | des2 \bar "||"
  des2 | des4 c8 des | es4 es | as,2 \bar "||"
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
