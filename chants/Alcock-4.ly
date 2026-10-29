\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Walter Galpin Alcock (1861-1947)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c'' {
  as2 | g4 f | f es \bar "||"
  bes'2 | as4 g | as bes | c2 \bar "||"
  f,2 | des'4 c | c bes \bar "||"
  f2 | es4 es | as bes | as2 \bar "||"
}

A_notes = \relative c' {
  c2 | es4 des | bes2 \bar "||"
  es2 | es4 des | c f | e2 \bar "||"
  es2 | des4 ges | f2 \bar "||"
  des4. c8 | bes4 es | des des | c2 \bar "||"
}

T_notes = \relative c' {
  as2 | as4 as | des2 \bar "||"
  g,2 | as4 bes | as g8 f | g2 \bar "||"
  c2 | bes4 a | a bes \bar "||"
  bes4. as8 | g4 as | as g | as2 \bar "||"
}

B_notes = \relative c {
  as2 | c4 des | g,2 \bar "||"
  des'2 | c4 bes | f' des | c2 \bar "||"
  a2 | bes4 es | des2 \bar "||"
  bes2 | es4 c | f es | as,2 \bar "||"
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
