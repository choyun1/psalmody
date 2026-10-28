\version "2.24.1"

\header{
  composer = \markup{\hspace #-39.5 \italic "Richard Woodward, Jr. (1743-1777)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative g' {
  c2 | bes4 aes | g2 \bar "||"
  aes2 | bes4 c | des c | bes2 | \bar "||"
  g2 | c4 bes | aes2 \bar "||"
  des2 | c4 bes | aes g | aes2 | \bar "||"
}

A_notes = \relative c' {
  ees2 | ees4 d | ees2 \bar "||"
  ees2 | des?4 c | ees ees | ees2 | \bar "||"
  ees2 | g4 e | f2 \bar "||"
  ees?2 | ees4 f | ees ees | ees2 | \bar "||"
}

T_notes = \relative a {
  aes2 | bes4 bes | bes2 \bar "||"
  aes2 | g4 aes | bes aes | g2 | \bar "||"
  bes2 | c4 c | c2 \bar "||"
  bes2 | c4 des | c bes | c2 | \bar "||"
}

B_notes =  \relative c {
  aes'2 | g4 f | ees2 \bar "||"
  c2 | bes4 aes | g aes | ees'2 | \bar "||"
  ees2 | e4 c | f2 \bar "||"
  g2 | aes4 des, | ees ees | aes,2 | \bar "||"
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