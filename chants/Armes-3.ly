\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Philip Armes (1836-1908)"}
  tagline=#f
}

global = {
  \key bes \minor
  \time 2/4
}


S_notes = \relative c' {
  f2 | bes4 ges | f2 \bar "||"
  a2 | c4 bes | a g | f2 \bar "||"
  as2 | des4 bes | as2 \bar "||"
  des,2 | es4 e | f c' | bes2 \bar "||"
}

A_notes = \relative c' {
  des2 | es4 es | des2 \bar "||"
  f2 | ges4 f | f e | f2 \bar "||"
  f2 | ges4 ges | f2 \bar "||"
  bes,2 | c4 des | des es | des2 \bar "||"
}

T_notes = \relative c {
  f2 | ges4 bes | des2 \bar "||"
  c2 | es4 des | c bes | a2 \bar "||"
  as2 | bes4 c | des2 \bar "||"
  des2 | c4 bes | bes a | bes2 \bar "||"
}

B_notes = \relative c {
  bes2 | bes4 bes | bes2 \bar "||"
  f'2 | a,4 bes | c c | f2 \bar "||"
  des2 | des4 des | des2 \bar "||"
  bes'2 | as4 ges | f f | bes,2 \bar "||"
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
