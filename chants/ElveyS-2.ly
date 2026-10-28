\version "2.24.1"

\header{
  composer = \markup{\hspace #-30 \italic "Stephen Elvey (1805-1860)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | aes4 bes | c2 \bar "||"
  d,2 | ees4 f | g aes | f2 | \bar "||"
  bes2 | bes4 aes | g2 \bar "||"
  aes2 | aes4 g | f f | ees2 | \bar "||"
}

A_notes = \relative c' {
  ees2 | ees4 des | c2 \bar "||"
  bes2 | bes4 bes | bes f' | d2 | \bar "||"
  f2 | ees4 f | ees2 \bar "||"
  f2 | d4 ees | ees d | ees2 | \bar "||"
}

T_notes = \relative a {
  bes2 | aes4 g | aes2 \bar "||"
  f2 | ees4 aes | g c | bes2 | \bar "||"
  d2 | c4 bes | bes2 \bar "||"
  c2 | bes4 bes | bes bes | g2 | \bar "||"
}

B_notes =  \relative c {
  ees2 | c4 bes | aes2 \bar "||"
  bes2 | c4 d | ees aes, | bes2 | \bar "||"
  bes2 | c4 d | ees2 \bar "||"
  aes,2 | bes4 ees | bes bes | ees2 | \bar "||"
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