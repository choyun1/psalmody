\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Morley (?-1731)"}
  tagline=#f
}

global = {
  \key d \minor
  \time 2/4
}


S_notes = \relative c' {
  d2 | d4 e | f2 \bar "||"
  f2 | e4 a | c b | a2 \bar "||"
  a2 | c4 g | a2 \bar "||"
  f2 | a4 d | d cis | d2 \bar "||"
}

A_notes = \relative c' {
  a2 | d4 cis | d2 \bar "||"
  a2 | c4 e | e4. d8 | c2 \bar "||"
  f2 | g4 e | f2 \bar "||"
  a,2 | d4 f | e e | f2 \bar "||"
}

T_notes = \relative c {
  f2 | f4 a | a2 \bar "||"
  d2 | a4 c | a gis | a2 \bar "||"
  c2 | c4 c | c2 \bar "||"
  d2 | a4 a | a a | a2 \bar "||"
}

B_notes = \relative c {
  d2 | d4 a | d2 \bar "||"
  d2 | c4 a | e' e | a,2 \bar "||"
  f'2 | e4 c | f2 \bar "||"
  d2 | f4 d | a' a | d,2 \bar "||"
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
