\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Macpherson (1870-1927)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c' {
  es2 | as4 bes | g2 \bar "||"
  as2 | bes4 c | as des | bes2 \bar "||"
  c2 | des4 es | a,2 \bar "||"
  bes2 | des4 c | bes as8 g | as2 \bar "||"
}

A_notes = \relative c' {
  c2 | es4 f | es2 \bar "||"
  c2 | f4 e | f f | es2 \bar "||"
  es2 | ges4 ges | f2 \bar "||"
  f2 | g4 as | f es | es2 \bar "||"
}

T_notes = \relative c' {
  as2 | as4 f | bes2 \bar "||"
  as2 | f4 g | as bes | g2 \bar "||"
  as2 | bes4 c | es2 \bar "||"
  des4. c8 | bes4 as | bes des | c2 \bar "||"
}

B_notes = \relative c {
  as2 | c4 des | es2 \bar "||"
  f2 | des4 c | f des | es2 \bar "||"
  as2 | ges4 es | f2 \bar "||"
  bes,2 | es4 f | des es | as,2 \bar "||"
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
