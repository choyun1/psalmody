\version "2.24.1"

\header{
  composer = \markup{\hspace #-30 \italic "Kellow J. Pye (1812-1901)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | bes4 g | ees2 \bar "||"
  bes'2 | c4 ees | d c | b2 | \bar "||"
  c2 | ees4 c | aes2 \bar "||"
  g2 | bes4 aes | f f | ees2 | \bar "||"
}

A_notes = \relative c' {
  ees2 | f4 d | c2 \bar "||"
  f2 | g4 g | aes f | g2 | \bar "||"
  ees2 | ees4 g | f2 \bar "||"
  ees2 | ees4 ees | ees d | ees2 | \bar "||"
}

T_notes = \relative a {
  bes2 | f4 g | g2 \bar "||"
  bes2 | g4 c | aes c | d2 | \bar "||"
  c2 | bes4 c | c2 \bar "||"
  c2 | bes4 c | bes bes | g2 | \bar "||"
}

B_notes =  \relative c {
  ees2 | d4 bes | c2 \bar "||"
  d2 | ees4 c | f aes | g2 | \bar "||"
  aes2 | g4 ees | f2 \bar "||"
  c2 | g4 aes | bes bes | ees2 | \bar "||"
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