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
  a2 | bes4 a | c2 \bar "||"
  bes2 | a4 c | a g | g2 \bar "||"
  a2 | bes4 a | d2 \bar "||"
  c2 | bes4 d, | f g | f2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 f | f2 \bar "||"
  f2 | f4 c | c b | c2 \bar "||"
  c2 | cis4 c | d2 \bar "||"
  d2 | d4 d | d e | f2 \bar "||"
}

T_notes = \relative c' {
  c2 | d4 c | es2 \bar "||"
  d2 | c4 g | f f | e2 \bar "||"
  a2 | g4 g | fis2 \bar "||"
  a2 | bes4 bes | bes bes | a2 \bar "||"
}

B_notes = \relative c {
  f2 | f4 f | a,2 \bar "||"
  bes2 | f'4 e | d d | c2 \bar "||"
  f2 | es4 es | d2 \bar "||"
  fis2 | g4 bes, | c c | f2 \bar "||"
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
