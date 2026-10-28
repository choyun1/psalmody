\version "2.24.1"

\header{
  composer = \markup{\hspace #-36 \italic "Jonathan Battishill (1738-1801)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative g' {
  f2 | e4 d | c2 \bar "||"
  a'2 | g4 f | bes a | g2 | \bar "||"
  a2 | g4 a | bes2 \bar "||"
  a2 | g4 f | c e | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | bes4 bes | c2 \bar "||"
  c2 | d4 f | e f | e2 | \bar "||"
  f2 | g4 e | f2 \bar "||"
  e2 | d4 a | c bes | a2 | \bar "||"
}

T_notes = \relative a {
  a2 | g4 e | f2 \bar "||"
  a2 | bes4 c | bes c | c2 | \bar "||"
  c2 | c4 c | bes2 \bar "||"
  c2 | g4 f | a g | f2 | \bar "||"
}

B_notes =  \relative c {
  f,2 | g4 g | a2 \bar "||"
  f2 | bes4 a | g f | c'2 | \bar "||"
  f2 | e4 c | d2 \bar "||"
  c2 | bes4 d | c c | f,2 | \bar "||"
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