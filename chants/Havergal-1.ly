\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Henry Havergal (1793-1870)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | f4 bes | es,2 \bar "||"
  c'2 | bes4 es | as, as | g2 \bar "||"
  bes2 | bes4 bes | bes2 \bar "||"
  as2 | as4 g | f f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 d | es2 \bar "||"
  es2 | d4 es | es d | es2 \bar "||"
  g2 | f4 d | es2 \bar "||"
  es2 | d4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | as4 as | g2 \bar "||"
  as2 | bes4 bes | c bes | bes2 \bar "||"
  bes2 | bes4 bes | g2 \bar "||"
  as2 | bes4 bes | c bes8 as | g2 \bar "||"
}

B_notes = \relative c {
  es2 | es4 es | es2 \bar "||"
  as2 | as4 g | f bes, | es2 \bar "||"
  es2 | d4 g | c,2 \bar "||"
  c2 | bes4 es | as, bes | es2 \bar "||"
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
