\version "2.24.1"

\header{
  composer = \markup{\hspace #-39 \italic "Edward John Hopkins (1818-1901)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative g' {
  c2 | bes4 aes | g2 \bar "||"
  ees2 | aes4 c | bes aes | g2 | \bar "||"
  bes2 | ees4 des | c2 \bar "||"
  bes2 | aes4 f | aes bes | aes2 | \bar "||"
}

A_notes = \relative c' {
  aes'2 | f4 f | ees2 \bar "||"
  ees2 | ees4 ees | d d | ees2 | \bar "||"
  ees2 | ees4 ees | ees2 \bar "||"
  e2 | f4 f | ees des | c2 | \bar "||"
}

T_notes = \relative a {
  ees'2 | des4 c | bes2 \bar "||"
  g2 | aes4 aes | aes bes | bes2 | \bar "||"
  g2 | aes4 g | aes2 \bar "||"
  c2 | c4 des | c g | aes2 | \bar "||"
}

B_notes =  \relative c {
  aes'2 | des,4 des | ees2 \bar "||"
  des2 | c4 aes | f' bes, | ees2 | \bar "||"
  des2 | c4 ees | aes2 \bar "||"
  c,2 | f4 des | ees ees | aes,2 | \bar "||"
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