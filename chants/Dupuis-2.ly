\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Saunders Dupuis (1733-1796)"}
  tagline=#f
}

global = {
  \key a \minor
  \time 2/4
}


S_notes = \relative c'' {
  c2 | a4 b | gis2 \bar "||"
  a2 | b4 d | c b | a2 \bar "||"
}

A_notes = \relative c' {
  e2 | f4 f | e2 \bar "||"
  e2 | f4 d | e4. d8 | c2 \bar "||"
}

T_notes = \relative c' {
  a2 | c4 c | b2 \bar "||"
  c2 | b4 a | a gis | a2 \bar "||"
}

B_notes = \relative c' {
  a2 | f4 d | e2 \bar "||"
  a,2 | d4 f | e e | a,2 \bar "||"
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
