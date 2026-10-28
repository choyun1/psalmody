\version "2.24.1"

\header{
  composer = \markup{\hspace #-30 \italic "Stephen Elvey (1805-1860)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative g' {
  f2 | f4 g | a2 \bar "||"
  a2 | g4 f | e d | cis2 | \bar "||"
  e2 | f4 g | a2 \bar "||"
  a2 | bes4 a | g g | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | d4 d | cis2 \bar "||"
  c2 | bes4 a | bes g | a2 | \bar "||"
  cis2 | d4 e | f2 \bar "||"
  d2 | d4 c | d c | a2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 g | e2 \bar "||"
  f2 | e4 f | g d | e2 | \bar "||"
  a2 | a4 c | c2 \bar "||"
  f,2 | e4 f | f e | f2 | \bar "||"
}

B_notes =  \relative c {
  f2 | d4 bes | a2 \bar "||"
  f2 | c'4 d | g, bes | a2 | \bar "||"
  a2 | d4 c | f2 \bar "||"
  d2 | g,4 a | bes c | f2 | \bar "||"
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