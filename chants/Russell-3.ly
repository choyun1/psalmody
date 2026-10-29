\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Russell (1777-1813)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c' {
  e4. f8 | g4 a | g2 \bar "||"
  c2 | c4 b | a a | g2 \bar "||"
  e2 | f4 g | a2 \bar "||"
  b2 | c4 d | c b | c2 \bar "||"
}

A_notes = \relative c' {
  c4. d8 | e4 f | e2 \bar "||"
  e2 | d4 g | g fis | g2 \bar "||"
  c,2 | f4 e | f2 \bar "||"
  d2 | c4 a' | g4. f8 | e2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 c | c2 \bar "||"
  c4. b8 | a4 g8 b | d4. c8 | b2 \bar "||"
  c2 | c4 bes | a2 \bar "||"
  g2 | g4 a8 f' | e4 d | c2 \bar "||"
}

B_notes = \relative c {
  c2 | c4 f | c2 \bar "||"
  a'4. g8 | fis4 g | d d | g2 \bar "||"
  c4. bes8 | a4 g | f2 \bar "||"
  f2 | e4 f | g g | c,2 \bar "||"
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
