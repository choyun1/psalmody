\version "2.24.1"

\header{
  composer = \markup{\hspace #-29 \italic "James Nares (1715-1783)"}
  tagline=#f
}

global = {
  \key g \minor
  \time 2/4
}


S_notes = \relative g' {
  bes2 | c4 a | bes2 \bar "||"
  g2 | a4 bes | a g | f2 | \bar "||"
  f2 | g4 c | a2 \bar "||"
  bes2 | g4 a | g fis | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | ees4 c | d2 \bar "||"
  bes2 | ees4 d | c bes | a2 | \bar "||"
  bes2 | bes4 ees | c2 \bar "||"
  f2 | ees4 ees | d d | d2 | \bar "||"
}

T_notes = \relative a {
  g2 | g4 f | f2 \bar "||"
  g2 | c4 f, | f e | f2 | \bar "||"
  bes2 | g4 g | f2 \bar "||"
  d'2 | bes4 c | bes a | bes2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | ees4 f | bes,2 \bar "||"
  ees2 | c4 bes | c c | f,2 | \bar "||"
  d'2 | ees4 c | f2 \bar "||"
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