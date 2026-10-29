\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Bayley (1810-1858)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c' {
  es2 | es4 f | g2 \bar "||"
  g2 | es'4 d | c d | b2 \bar "||"
  c2 | bes4 as | g2 \bar "||"
  as4. g8 | f4 es | es d | es2 \bar "||"
}

A_notes = \relative c' {
  bes2 | c4 c | bes2 \bar "||"
  b2 | g'4 f | es d | d2 \bar "||"
  g2 | f4 es | d2 \bar "||"
  es4. d8 | c4 c | bes bes | bes2 \bar "||"
}

T_notes = \relative c' {
  g2 | g4 as | g2 \bar "||"
  f2 | es4 f | g as | g2 \bar "||"
  g2 | bes4 c | d2 \bar "||"
  c4. g8 | as4 g | f f | g2 \bar "||"
}

B_notes = \relative c {
  es2 | c4 as | es'2 \bar "||"
  d2 | c4 d | es f | g2 \bar "||"
  es2 | d4 c | b2 \bar "||"
  c4. bes8 | as4 as | bes bes | es2 \bar "||"
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
