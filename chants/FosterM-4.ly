\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Myles B. Foster (1851-1922)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | bes4 es, | as2 \bar "||"
  g2 | f4 bes8 c | d4 c | bes2 \bar "||"
  bes2 | as4 g | as2 \bar "||"
  f2 | g4 bes | f f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | es4 d \bar "||"
  es2 | f4 f | f a | bes2 \bar "||"
  f2 | f4 e | f2 \bar "||"
  d2 | es4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | bes4 bes | bes2 \bar "||"
  bes2 | a4 bes | bes es | d2 \bar "||"
  des2 | c4 c | c2 \bar "||"
  bes2 | bes4 bes | as8 g as4 | g2 \bar "||"
}

B_notes = \relative c {
  es2 | g4 g | f2 \bar "||"
  es2 | es4 d | f f | bes2 \bar "||"
  g2 | c,4 c | f2 \bar "||"
  bes,2 | es4 g, | bes bes | es2 \bar "||"
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
