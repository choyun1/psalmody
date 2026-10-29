\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Attwood Walmisley (1814-1856)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | as4 c | f,2 \bar "||"
  bes2 | es,4 f | g as | f2 \bar "||"
  bes2 | c4 es | as,2 \bar "||"
  c2 | bes4 es, | f g8 as | g2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | d2 \bar "||"
  es2 | c4. d8 | es4 es | d2 \bar "||"
  d2 | g4 g | f2 \bar "||"
  es2 | f4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | as4 g8 f | bes2 \bar "||"
  bes2 | g4 as | bes c | bes2 \bar "||"
  bes2 | g4 c | c2 \bar "||"
  as2 | as4 g | c bes | bes2 \bar "||"
}

B_notes = \relative c {
  es2 | c4 as | bes2 \bar "||"
  g2 | c4 as' | g f | bes2 \bar "||"
  g2 | es4 c | f2 \bar "||"
  c2 | d4 es | as, bes | es2 \bar "||"
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
