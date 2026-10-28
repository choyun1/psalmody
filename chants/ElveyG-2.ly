\version "2.24.1"

\header{
  composer = \markup{\hspace #-31.5 \italic "George J. Elvey (1816-1893)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative g' {
  c2 | aes4 ees | f2 \bar "||"
  f2 | des'4 c | bes aes | g2 | \bar "||"
  ees'2 | c4 aes | des2 \bar "||"
  f,2 | ees4 aes | aes g | aes2 | \bar "||"
}

A_notes = \relative c' {
  ees2 | ees4 ees | des2 \bar "||"
  ees2 | des4 ees | f f | ees2 | \bar "||"
  ees2 | ees4 c | des2 \bar "||"
  des2 | des4 c | f ees | ees2 | \bar "||"
}

T_notes = \relative a {
  aes2 | c4 aes | aes2 \bar "||"
  c2 | f,4 a | bes bes | bes2 | \bar "||"
  bes2 | aes4 aes | aes2 \bar "||"
  bes2 | bes4 aes | bes bes | c2 | \bar "||"
}

B_notes =  \relative c {
  aes'2 | aes,4 c | des2 \bar "||"
  a2 | bes4 c | des d | ees2 | \bar "||"
  g2 | aes4 ges | f2 \bar "||"
  bes2 | g4 aes | des, ees | aes,2 | \bar "||"
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