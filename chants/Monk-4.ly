\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edwin George Monk (1819-1900)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c'' {
  c2 | bes4 as | g2 \bar "||"
  bes2 | es,4 as | as g | as2 \bar "||"
}

A_notes = \relative c' {
  es2 | f4 f | es2 \bar "||"
  es4. des8 | c4 c | f es | es2 \bar "||"
}

T_notes = \relative c' {
  c2 | des4 c | bes2 \bar "||"
  bes2 | as4 as | bes bes | c2 \bar "||"
}

B_notes = \relative c' {
  as2 | des,4 des | es2 \bar "||"
  g2 | as4 f | des es | as,2 \bar "||"
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
