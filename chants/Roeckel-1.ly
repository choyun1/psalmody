\version "2.24.1"

\header{
  composer = \markup{\hspace #-40 \italic "Joseph Leopold Roeckel (1838-1923)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | f4 ees | aes2 \bar "||"
  aes2 | g4 f | ees f | d2 | \bar "||"
  f2 | ees4 d | g2 \bar "||"
  g2 | f4 ees | d f | ees2 | \bar "||"
}

A_notes = \relative c' {
  g'2 | f4 ees | aes2 \bar "||"
  aes2 | g4 f | ees f | d2 | \bar "||"
  f2 | ees4 d | g2 \bar "||"
  g2 | f4 ees | d f | ees2 | \bar "||"
}

T_notes = \relative a {
  bes2 | c4 bes | c2 \bar "||"
  bes2 | bes4 bes | bes a | bes2 | \bar "||"
  c2 | c4 b | c2 \bar "||"
  bes2 | aes4 c | bes aes | g2 | \bar "||"
}

B_notes =  \relative c {
  ees2 | aes4 g | f2 \bar "||"
  d2 | ees4 d | c f | bes2 | \bar "||"
  aes2 | g4 f | ees2 \bar "||"
  e2 | f4 aes | bes bes, | ees2 | \bar "||"
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