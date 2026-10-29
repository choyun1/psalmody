\version "2.24.1"

\header{
  composer = \markup{\hspace #-37 \italic "Ivor Algernon Atkins (1869-1953)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative g' {
  ees2 | f4 bes | bes2 \bar "||"
  aes2 | aes4 g | c d | g,2 | \bar "||"
  g2 | c4 bes | ees2 \bar "||"
  c2 | bes4 c | f, f | ees2 \bar "||"
}

A_notes = \relative c' {
  bes2 | bes4 bes | ees2 \bar "||"
  ees2 | e4 e | g f | d2 | \bar "||"
  d2 | c4 ees | ees2 \bar "||"
  ees2 | ees4 ees | ees d | ees2 | \bar "||"
}

T_notes = \relative a {
  g2 | f4 f | g2 \bar "||"
  aes2 | des4 des | c c | b2 | \bar "||"
  b2 | g4 g | aes2 \bar "||"
  aes2 | bes4 aes | f bes8 aes | g2 | \bar "||"
}

B_notes =  \relative c {
  ees2 | ees4 d | des2 \bar "||"
  c2 | bes4 bes' | aes aes | g2 | \bar "||"
  f2 | ees4 des | c2 \bar "||"
  aes2 | g4 f | bes bes | ees2 | \bar "||"
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