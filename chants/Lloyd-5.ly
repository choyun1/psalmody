\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Harford Lloyd (1849-1919)"}
  tagline=#f
}

global = {
  \key f \minor
  \time 2/4
}


S_notes = \relative c'' {
  c2 | bes4 bes | as2 \bar "||"
  as2 | bes4 c | des es | des c \bar "||"
  bes2 | as4 g | f2 \bar "||"
  ges2 | bes4 ges | f e | g f \bar "||"
}

A_notes = \relative c'' {
  as2 | g4 g | f2 \bar "||"
  f2 | f4 f | f es | es2 \bar "||"
  des2 | c4 bes | as2 \bar "||"
  des2 | ges4 des | c c | c2 \bar "||"
}

T_notes = \relative c' {
  c2 | des4 c | c2 \bar "||"
  c2 | bes4 a | bes bes | bes as \bar "||"
  f2 | e4 e | f2 \bar "||"
  bes2 | des4 bes | as g | bes as \bar "||"
}

B_notes = \relative c {
  f2 | f4 e | f2 \bar "||"
  es2 | des4 c | bes g | as2 \bar "||"
  bes2 | c4 c | des2 \bar "||"
  bes2 | ges4 bes | c c | f2 \bar "||"
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
