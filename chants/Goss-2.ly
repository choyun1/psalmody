\version "2.24.1"

\header{
  composer = \markup{\hspace #-26.5 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | bes4 aes | g2 \bar "||"
  f4. ees8 | d4 ees | aes g | f2 | \bar "||"
  bes2 | ees4 d | c2 \bar "||"
  f,2 | bes4 g | f f | ees2 | \bar "||"
}

A_notes = \relative c' {
  ees2 | bes4 c8 d | ees2 \bar "||"
  c2 | bes4 bes | d ees | d2 | \bar "||"
  d2 | ees4 ees | aes4 g \bar "||"
  f2 | bes,4 ees | ees d | ees2 | \bar "||"
}

T_notes = \relative a {
  ees'2 | d4 c | bes2 \bar "||"
  aes4. g8 | f4 bes | bes bes | bes2 | \bar "||"
  bes2 | g4 g | aes4 bes \bar "||"
  c4. d8 | ees4 bes | bes4. aes8 | g2 | \bar "||"
}

B_notes =  \relative c {
  ees2 | ees4 ees | ees2 \bar "||"
  aes,2 | aes'4 g | f ees | bes2 | \bar "||"
  g'2 | c,4 c | f4 g \bar "||"
  aes2 | g4 ees | bes bes | ees2 | \bar "||"
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