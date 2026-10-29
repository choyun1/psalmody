\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Alfred Herbert Brewer (1865-1928)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | f4 f | bes2 \bar "||"
  g2 | a4 bes | es4 d | c2 \bar "||"
  g2 | g4 g | c2 \bar "||"
  b2 | c4 es | d c | bes2 \bar "||"
}

A_notes = \relative c' {
  <d bes>2 | c4 <es a,> | <d bes>2 \bar "||"
  es2 | f4 f | es4 f | f2 \bar "||"
  bes,2 | <f' b,>4 es8 d | <g c,>2 \bar "||"
  g2 | g4 es | f f | d2 \bar "||"
}

T_notes = \relative c {
  f2 | f4 f | bes2 \bar "||"
  bes2 | c4 bes | g8 a bes4 | a2 \bar "||"
  g2 | g4 <b g> | <c g>2 \bar "||"
  d2 | c4 c | bes a | bes2 \bar "||"
}

B_notes = \relative c {
  bes2 | a4 f | g2 \bar "||"
  es'2 | es4 d | c4 d8 es | f2 \bar "||"
  es2 | d4 f | es2 \bar "||"
  g2 | es4 c | f f | bes,2 \bar "||"
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
