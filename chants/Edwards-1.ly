\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edwin Edwards (1830-1907)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | bes4 bes | es,2 \bar "||"
  f2 | g4 bes | es4 es | d2 \bar "||"
  g,2 | es'4 d | c2 \bar "||"
  bes2 | as4 g | f4 f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 d | es2 \bar "||"
  bes2 | es4 f | g4 es | f2 \bar "||"
  f2 | es4 g | g2 \bar "||"
  g2 | g8 f es4 | es4 d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | as4 as | g2 \bar "||"
  bes2 | bes4 bes | bes4 a | bes2 \bar "||"
  d2 | g,8 a b4 | c2 \bar "||"
  des2 | c4 bes | bes4. as8 | g2 \bar "||"
}

B_notes = \relative c {
  es2 | bes4 bes | c2 \bar "||"
  d2 | es4 d | c4 c | bes2 \bar "||"
  b2 | c4 d | es2 \bar "||"
  e2 | f4 g8 as | bes4 bes, | es2 \bar "||"
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
