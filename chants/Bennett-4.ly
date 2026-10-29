\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George John Bennett (1863-1930)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | a4 bes8 g | f2 \bar "||"
  f2 | g4 a | bes4 d | c2 \bar "||"
  a4. bes8 | c4 d | es2 \bar "||"
  a,2 | bes4 d8 c | a4 a | bes2 \bar "||"
}

A_notes = \relative c' {
  d2 | es4 es | es2 \bar "||"
  d2 | es4 es | f4 g | c,2 \bar "||"
  f2 | f4 f | f2 \bar "||"
  es2 | d4 g | f4 es | d2 \bar "||"
}

T_notes = \relative c {
  f2 | fis4 g | c2 \bar "||"
  bes2 | bes4 c | bes4 bes | a2 \bar "||"
  f4. g8 | a4 b | c2 \bar "||"
  c2 | bes4 es | d4 c | bes2 \bar "||"
}

B_notes = \relative c {
  bes2 | c4 bes | a2 \bar "||"
  bes2 | es4 c | d4 e | f2 \bar "||"
  f2 | f4 f | f2 \bar "||"
  fis2 | g4 es | f4 f | bes,2 \bar "||"
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
