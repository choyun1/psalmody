\version "2.24.1"

\header{
  composer = \markup{\hspace #-41.5 \italic "Samuel Sebastian Wesley (1810-1876)"}
  tagline=#f
}

global = {
  \key g \minor
  \time 2/4
}


S_notes = \relative g' {
  bes2 | bes4 bes | a2 \bar "||"
  bes2 | g4 bes | a g | fis2 | \bar "||"
  bes2 | ees4 c | a2 \bar "||"
  d2 | g,4 a | g fis | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | c8 d ees4 | ees2 \bar "||"
  d2 | ees4 g | ees c | d2 | \bar "||"
  d2 | g4 ees | c2 \bar "||"
  f2 | ees4 ees | d4. c8 | bes2 | \bar "||"
}

T_notes = \relative a {
  g2 | g4 c | c2 \bar "||"
  bes2 | bes4 d | c g | a2 | \bar "||"
  g2 | g4 g | f2 \bar "||"
  d'2 | bes4 c | bes a | g2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | ees4 c | f,2 \bar "||"
  bes2 | ees4 bes | c ees | d2 | \bar "||"
  g2 | c,4 ees | f2 \bar "||"
  bes,2 | ees4 c | d d | g,2 | \bar "||"
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