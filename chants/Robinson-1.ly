\version "2.24.1"

\header{
  composer = \markup{\hspace #-31 \italic "John Robinson (1682-1762)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative g' {
  bes2 | ees4 c | bes2 \bar "||"
  g2 | a4 bes | bes a | bes2 | \bar "||"
  bes2 | aes4 g | c2 \bar "||"
  bes2 | f4 g | f f | ees2 | \bar "||"
}

A_notes = \relative c' {
  ees2 | ees4 ees | ees2 \bar "||"
  bes2 | ees4 d | c c | d2 | \bar "||"
  ees2 | d4 ees | ees2 \bar "||"
  ees2 | f4 ees | ees d | ees2 | \bar "||"
}

T_notes = \relative a {
  g2 | bes4 aes | g2 \bar "||"
  g2 | c4 f, | f f | f2 | \bar "||"
  g2 | aes4 bes | aes2 \bar "||"
  bes2 | bes4 bes | bes4. aes8 | g2 | \bar "||"
}

B_notes =  \relative c {
  ees2 | g4 aes | ees2 \bar "||"
  ees2 | c4 bes | f' f | bes,2 | \bar "||"
  ees2 | f4 g | aes2 \bar "||"
  g2 | d4 ees | bes bes | ees2 | \bar "||"
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