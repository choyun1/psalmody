\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Russell (1777-1813)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | es4 d | c2 \bar "||"
  bes4. as8 | g4 es | as g | f2 \bar "||"
  bes2 | es4 g, | as2 \bar "||"
  c2 | bes4 es,8 f | g4 f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | g4 f | es2 \bar "||"
  f2 | es4 bes | c8 d es4 | d2 \bar "||"
  d2 | es4 es | es2 \bar "||"
  f4. es8 | d4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  g2 | bes4 as | g2 \bar "||"
  bes2 | bes4 g | as bes | bes2 \bar "||"
  d2 | bes4 bes | as2 \bar "||"
  as4. g8 | f4 bes8 c | bes4. as8 | g2 \bar "||"
}

B_notes = \relative c {
  es2 | es4 bes | c2 \bar "||"
  d2 | es4 g | f es | bes2 \bar "||"
  bes'4. as8 | g4 des | c2 \bar "||"
  as2 | as4 g8 as | bes4 bes | es2 \bar "||"
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
