\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Leman Brownsmith (1809-1866)"}
  tagline=#f
}

global = {
  \key f \minor
  \time 2/4
}


S_notes = \relative c' {
  f2 | c'4 bes8 as | g2 \bar "||"
  as2 | bes4 c | des4 c8 bes | c2 \bar "||"
  c2 | c8 bes as4 | g2 \bar "||"
  f2 | es4 as | as g | f2 \bar "||"
}

A_notes = \relative c' {
  c2 | c4 f | e2 \bar "||"
  f2 | f4 es | f es8 des | c2 \bar "||"
  f2 | g4 c,8 d | e2 \bar "||"
  f2 | c4. des8 | c4 bes | as2 \bar "||"
}

T_notes = \relative c' {
  as2 | g4 c | c2 \bar "||"
  c2 | f,8 g as4 | as g | as2 \bar "||"
  as2 | g4 as8 bes | c2 \bar "||"
  as2 | as4 f | f e | f2 \bar "||"
}

B_notes = \relative c {
  f2 | e4 f | c2 \bar "||"
  f4. es8 | des4 c | bes es | as,2 \bar "||"
  f'2 | e4 f | c2 \bar "||"
  des2 | as4. bes8 | c4 c | f,2 \bar "||"
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
