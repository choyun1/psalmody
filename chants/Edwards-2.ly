\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edwin Edwards (1830-1907)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | bes4 g | f e \bar "||"
  f2 | g4 a | c bes | a2 \bar "||"
  c2 | d4 bes | a g \bar "||"
  c2 | e,4 f | a g | f2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 d | c2 \bar "||"
  c2 | c4 c | f g | f2 \bar "||"
  g2 | a4 g | e2 \bar "||"
  f2 | c4 c | f e | f2 \bar "||"
}

T_notes = \relative c' {
  c2 | bes4 bes | a g \bar "||"
  f2 | e4 f | a c | c2 \bar "||"
  c2 | a4 d | c2 \bar "||"
  c2 | bes4 a | c bes | a2 \bar "||"
}

B_notes = \relative c {
  f2 | d4 bes | c2 \bar "||"
  a2 | c4 f | d e | f2 \bar "||"
  e2 | fis4 g | bes2 \bar "||"
  a2 | g4 f | c c | f2 \bar "||"
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
