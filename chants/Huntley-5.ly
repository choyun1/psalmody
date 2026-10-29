\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Frederick William Huntley (1859-1913)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | c4 d | es2 \bar "||"
  c2 | d4 bes | c c | c2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 f | g2 \bar "||"
  f2 | f4 f | f e | f2 \bar "||"
}

T_notes = \relative c' {
  c2 | a4 bes | bes2 \bar "||"
  a2 | bes4 f | g bes | a2 \bar "||"
}

B_notes = \relative c {
  f2 | f4 bes, | es2 \bar "||"
  f2 | bes,4 d | c c | f2 \bar "||"
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
