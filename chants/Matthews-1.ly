\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Samuel Matthews (1796-1832)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | g4 f | es2 \bar "||"
  c'2 | bes4 es | as, g | f2 \bar "||"
  bes2 | bes4 as8 g | as2 \bar "||"
  c2 | d4 es | es,4 g8 f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 d | es2 \bar "||"
  es2 | es4 g | f es | d2 \bar "||"
  d2 | g4 e | f2 \bar "||"
  f2 | f4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | bes4. as8 | g2 \bar "||"
  as2 | bes4 es, | bes' bes | bes2 \bar "||"
  bes2 | c4 c | c2 \bar "||"
  as2 | as4 g | g as | g2 \bar "||"
}

B_notes = \relative c {
  es2 | g,4 bes | c2 \bar "||"
  as'2 | g4 c, | d es | bes2 \bar "||"
  g'2 | e4 c | f2 \bar "||"
  f2 | bes,4 c | bes bes | es2 \bar "||"
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
