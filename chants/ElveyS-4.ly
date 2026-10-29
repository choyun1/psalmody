\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Stephen Elvey (1805-1860)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | bes4 g | f2 \bar "||"
  bes2 | es,4 f8 g | as4 g | f2 \bar "||"
  as2 | c4 as | g2 \bar "||"
  c2 | bes4 as | bes g | as2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | d2 \bar "||"
  es2 | es4 es | d es | d2 \bar "||"
  f2 | f4 f | e2 \bar "||"
  as2 | g4 as | f es | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | bes4 bes | bes2 \bar "||"
  bes2 | c4 bes | as bes | bes2 \bar "||"
  c2 | c4 c | c2 \bar "||"
  es2 | des4 c | des bes | c2 \bar "||"
}

B_notes = \relative c {
  es2 | g4 es | bes'2 \bar "||"
  g2 | as4 g | f es | bes2 \bar "||"
  f'2 | as4 f | c'2 \bar "||"
  as2 | es4 f | des es | as,2 \bar "||"
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
