\version "2.24.1"

\header{
  composer = \markup{\hspace #-37.5 \italic "Highmore Skeats, Jr. (1784-1835)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative g' {
  ees2 | g4 c | bes2 \bar "||"
  aes2 | g4 f | g a | bes2 | \bar "||"
  bes2 | c4 g | aes2 \bar "||"
  g2 | f4 aes | g f | ees2 \bar "||"
}

A_notes = \relative c' {
  bes2 | ees4 ees | d2 \bar "||"
  ees2 | ees4 f | ees ees | d2 | \bar "||"
  ees2 | ees4 e | f2 \bar "||"
  ees?2 | f4 f | ees d | ees2 | \bar "||"
}

T_notes = \relative a {
  g2 | bes4 aes | f2 \bar "||"
  aes2 | bes4 bes | bes c | f,2 | \bar "||"
  g2 | c4 c | c2 \bar "||"
  bes2 | c4 c | bes bes | g2 | \bar "||"
}

B_notes =  \relative c {
  ees2 | ees4 aes, | bes2 \bar "||"
  c2 | ees4 d | ees c | bes2 | \bar "||"
  ees2 | aes,4 c | f2 \bar "||"
  g2 | aes4 f | bes bes, | ees2 | \bar "||"
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