\version "2.24.1"

\header{
  composer = \markup{\hspace #-31 \italic "Walter Parratt (1841-1924)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | f4 ees | bes'2 \bar "||"
  aes2 | g4 f | g c | b2 | \bar "||"
  c2 | bes4 aes | ees'2 \bar "||"
  bes2 | aes4 g | f aes | g2 | \bar "||"
}

A_notes = \relative c' {
  ees2 | bes4 bes | bes2 \bar "||"
  f'2 | ees4 d | ees g | g2 | \bar "||"
  ees2 | ees4 ees | ees2 \bar "||"
  ees2 | d4 ees | ees d | ees2 | \bar "||"
}

T_notes = \relative a {
  bes2 | aes4 g | f2 \bar "||"
  bes2 | bes4 bes | bes ees | d2 | \bar "||"
  c2 | d4 d | bes2 \bar "||"
  bes2 | bes4 bes | c bes | bes2 | \bar "||"
}

B_notes =  \relative c {
  ees2 | ees4 ees | ees4 d \bar "||"
  d2 | ees4 bes | ees c | g'2 | \bar "||"
  aes2 | aes4 aes | aes4 g \bar "||"
  g2 | f4 ees | aes, bes | ees2 | \bar "||"
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