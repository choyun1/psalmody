\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Frederick William Huntley (1859-1913)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c'' {
  as2 | c4 as | des2 \bar "||"
  c2 | bes4 as | g f | c'2 \bar "||"
  c2 | es4 c | a2 \bar "||"
  bes2 | c4 des | as g | as2 \bar "||"
}

A_notes = \relative c' {
  es2 | f4 f | f2 \bar "||"
  e2 | f4 c | des f | e2 \bar "||"
  f2 | es4 ges | f2 \bar "||"
  f2 | es4 des | es es | es2 \bar "||"
}

T_notes = \relative c' {
  c2 | as4 c | bes2 \bar "||"
  g2 | f4 as | bes bes | g2 \bar "||"
  as2 | bes4 es | c2 \bar "||"
  bes2 | a4 bes | c des | c2 \bar "||"
}

B_notes = \relative c' {
  as2 | f4 f | bes,2 \bar "||"
  c2 | des4 f | bes, des | c2 \bar "||"
  f2 | ges4 es | f2 \bar "||"
  des2 | c4 bes | es es | as,2 \bar "||"
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
