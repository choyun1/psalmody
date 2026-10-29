\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Stainer (1840-1901)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | a4 bes | c2 \bar "||"
  g2 | bes4 a | g f | g2 \bar "||"
  a2 | a4 bes | c2 \bar "||"
  f,2 | a4 g | f e | f2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 f | f4 e \bar "||"
  es2 | d4 f | d d | e2 \bar "||"
  f2 | f4 f | f4 e \bar "||"
  d2 | c4 d | c c | c2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 bes | a g \bar "||"
  g2 | g4 c | bes a | c2 \bar "||"
  c2 | c4 bes | a g \bar "||"
  f2 | f4 bes | a g | a2 \bar "||"
}

B_notes = \relative c {
  f2 | e4 d | c2 \bar "||"
  c2 | g4 a | bes d | c2 \bar "||"
  f2 | e4 d | c2 \bar "||"
  d2 | a4 bes | c c | f2 \bar "||"
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
