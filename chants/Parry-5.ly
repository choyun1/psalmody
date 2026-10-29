\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles H. H. Parry (1848-1918)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | c4 bes | as2 \bar "||"
  f2 | g4 bes | es c | d2 \bar "||"
  bes2 | c4 as | g2 \bar "||"
  g4. as8 | bes4 c | as f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 e | f2 \bar "||"
  d2 | es4 f | g f | f2 \bar "||"
  f2 | c4 f8 es | d2 \bar "||"
  es2 | es4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | as4 bes | c2 \bar "||"
  bes2 | bes4 bes | bes a | bes2 \bar "||"
  bes2 | g4 c | b2 \bar "||"
  c2 | bes4 as8 g | f4 as | g2 \bar "||"
}

B_notes = \relative c {
  es2 | as4 g | f2 \bar "||"
  bes2 | es,4 d | c f | bes,2 \bar "||"
  d2 | e4 f | g2 \bar "||"
  c,2 | g4 as | bes bes | es2 \bar "||"
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
