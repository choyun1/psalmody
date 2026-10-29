\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Hawes (1785-1846)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | bes4 a | g2 \bar "||"
  c2 | f,4 f | bes a | a4 g \bar "||"
  c2 | d4 a | bes2 \bar "||"
  c2 | a4 bes8 g | f4 e | f2 \bar "||"
}

A_notes = \relative c' {
  c2 | c4 c | c2 \bar "||"
  c2 | a4 d | c c | c2 \bar "||"
  e2 | fis4 fis | g2 \bar "||"
  g2 | f8 es d4 | c bes | a2 \bar "||"
}

T_notes = \relative c' {
  a2 | g4 f | f4 e \bar "||"
  e2 | f4 bes8 a | g4 f | f4 e \bar "||"
  a2 | a4 d | d2 \bar "||"
  c2 | c4 bes | a g | f2 \bar "||"
}

B_notes = \relative c {
  f2 | e4 f | c2 \bar "||"
  a2 | d4 d | e f | c2 \bar "||"
  a2 | d4 d | g2 \bar "||"
  e2 | f4 bes, | c c | f,2 \bar "||"
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
