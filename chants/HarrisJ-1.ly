\version "2.24.1"

\header{
  composer = \markup{\hspace #-30.5 \italic "Joseph Harris (1743-1814)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative g' {
  bes2 | bes4 bes | bes2 \bar "||"
  bes2 | aes4 g | f ees | f2 | \bar "||"
  g2 | bes4 aes | g2 \bar "||"
  g2 | g4 f | ees d | ees2 | \bar "||"
}

A_notes = \relative c' {
  g'2 | f4 g | aes2 \bar "||"
  g2 | ees4 ees | d ees | d2 | \bar "||"
  ees2 | ees4 ees | ees2 \bar "||"
  des2 | c4 c | bes bes | bes2 | \bar "||"
}

T_notes = \relative a {
  ees'2 | d4 ees | d2 \bar "||"
  des2 | c4 bes | aes g | bes2 | \bar "||"
  bes2 | d4 c | bes2 \bar "||"
  bes2 | bes4 aes | g f | g2 | \bar "||"
}

B_notes =  \relative c {
  ees2 | aes4 g | f2 \bar "||"
  ees2 | ees4 ees | ees ees | bes2 | \bar "||"
  ees2 | ees4 ees | ees2 \bar "||"
  ees2 | aes,4 aes | bes bes | ees2 | \bar "||"
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