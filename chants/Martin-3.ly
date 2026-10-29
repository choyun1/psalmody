\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Clement Martin (1844-1916)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | bes4 c | f,2 \bar "||"
  bes2 | c4 d | g, f | e2 \bar "||"
  c'2 | d4 c | f,2 \bar "||"
  a2 | bes4 c8 d | f,4 e | f2 \bar "||"
}

A_notes = \relative c' {
  c2 | f4 es | d2 \bar "||"
  g2 | g4 g8 f | e4 d | c2 \bar "||"
  g'2 | g4 g | f2 \bar "||"
  f2 | f4 e8 d | c4 c | c2 \bar "||"
}

T_notes = \relative c {
  f2 | f4 f | f2 \bar "||"
  d'2 | c4 bes8 a | g4 b | c2 \bar "||"
  e2 | d4 e | c2 \bar "||"
  d2 | d4 c8 bes | a4 g | a2 \bar "||"
}

B_notes = \relative c {
  f4. es8 | d4 a | bes2 \bar "||"
  g2 | a4 bes | b g | c2 \bar "||"
  c'2 | bes4 bes | a2 \bar "||"
  d,2 | g4 g | c, c | f2 \bar "||"
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
