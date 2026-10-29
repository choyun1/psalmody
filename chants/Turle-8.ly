\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "James Turle (1802-1882)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  c2 | c4 c | bes2 \bar "||"
  a2 | d4 c | bes a | g2 \bar "||"
  a2 | a4 a | a2 \bar "||"
  a2 | bes4 d | a g | f2 \bar "||"
}

A_notes = \relative c'' {
  a2 | a4 a | g2 \bar "||"
  f2 | f4 f | f f | e2 \bar "||"
  f2 | g4 f | g2 \bar "||"
  fis2 | g4 d | f e | f2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 c | c2 \bar "||"
  c2 | bes4 a | d c | c2 \bar "||"
  c2 | cis4 d | e2 \bar "||"
  c2 | bes4 g | c4. bes8 | a2 \bar "||"
}

B_notes = \relative c {
  f2 | f4 f | e2 \bar "||"
  f2 | bes,4 c | d f | c2 \bar "||"
  f2 | e4 d | cis2 \bar "||"
  d2 | g4 bes, | c4 c | f2 \bar "||"
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
