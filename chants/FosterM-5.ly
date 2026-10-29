\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Myles B. Foster (1851-1922)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | e'4 c | c b \bar "||"
  c4. b8 | a4 c | g g | g2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 g | g2 \bar "||"
  g2 | a4 g | d d | e2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 c | d2 \bar "||"
  c2 | c4 c | c b | c2 \bar "||"
}

B_notes = \relative c {
  c2 | c4 e | g2 \bar "||"
  e2 | f4 e8 f | g4 g | c,2 \bar "||"
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
