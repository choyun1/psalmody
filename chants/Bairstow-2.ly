\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edward Cuthbert Bairstow (1874-1946)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | g4 bes | f2 \bar "||"
  as2 | g4 bes | d4 a | bes2 \bar "||"
  bes2 | as4 bes | c2 \bar "||"
  bes2 | es4 es, | g4 d | es2 \bar "||"
}

A_notes = \relative c'' {
  g4. f8 | es4 d | c2 \bar "||"
  f2 | es4 f | g4 f | f2 \bar "||"
  es4. f8 | es8 f g4 | as4 g \bar "||"
  f2 | es4 bes | c4 bes | bes2 \bar "||"
}

T_notes = \relative c' {
  es4. d8 | c4 bes | as2 \bar "||"
  bes2 | bes4 bes | bes4 es | d2 \bar "||"
  g,4. bes8 | es4 des | c2 \bar "||"
  d4. c8 | bes4 es, | es4 as | g2 \bar "||"
}

B_notes = \relative c {
  es2 | es4 es | es2 \bar "||"
  d2 | es4 d | es4 f | bes,2 \bar "||"
  es4. des8 | c4 bes | as2 \bar "||"
  as2 | as4 g | as4 bes | es2 \bar "||"
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
