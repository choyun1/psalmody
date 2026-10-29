\version "2.24.1"

\header{
  composer = \markup{\hspace #-37 \italic "Ivor Algernon Atkins (1869-1953)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative g' {
  f2 | g4 f | bes2 \bar "||"
  c2 | ees4 d | c bes | c2 | \bar "||"
  c2 | d4 g, | ees'2 \bar "||"
  d2 | c4 g | bes a | bes2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 f | d2 \bar "||"
  f2 | g4 bes | g g | a2 | \bar "||"
  aes2 | aes4 g | g2 \bar "||"
  fis2 | g4 g | f f | f2 | \bar "||"
}

T_notes = \relative a {
  bes2 | d4 c | bes2 \bar "||"
  a2 | bes4 f' | ees d | f2 | \bar "||"
  c2 | c4 b | c2 \bar "||"
  a2 | g4 ees' | c c | d2 | \bar "||"
}

B_notes =  \relative c {
  bes'2 | bes4 a | g2 \bar "||"
  f2 | ees4 bes | c g' | f2 | \bar "||"
  f2 | d4 g | c,2 \bar "||"
  d2 | ees4 c | f f | bes,2 | \bar "||"
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