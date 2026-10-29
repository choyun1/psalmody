\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Samuel Sebastian Wesley (1810-1876)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | g4 a | bes2 \bar "||"
  a2 | d4 f,8 e | f4 g | a2 \bar "||"
  a2 | d4 c8 bes | a2 \bar "||"
  c2 | f,4 g | a g | f2 \bar "||"
}

A_notes = \relative c' {
  f2 | e4 fis | g2 \bar "||"
  d2 | d4 bes | a d | cis2 \bar "||"
  d2 | f4 e | f2 \bar "||"
  e2 | f4 f | f e | f2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 c | bes2 \bar "||"
  fis2 | g4 g | f d | e2 \bar "||"
  f2 | g4 g | f2 \bar "||"
  c'2 | a4 d | c4. bes8 | a2 \bar "||"
}

B_notes = \relative c {
  f2 | c4 a | g2 \bar "||"
  d'2 | bes4 c | d bes | a2 \bar "||"
  d2 | bes4 c | d2 \bar "||"
  a2 | d4 bes | c c | f2 \bar "||"
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
