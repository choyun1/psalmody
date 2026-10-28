\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Attwood (1765-1838)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative g' {
  aes2 | ees4 des | c2 \bar "||"
  c'2 | ees4 c | aes bes | c2 | \bar "||"
  c,2 | des4 f | ees2 \bar "||"
  aes2 | aes4 f' | ees bes | c2 | \bar "||"
}

A_notes = \relative c' {
  aes'2 | ees4 des | c2 \bar "||"
  aes'2 | aes4 g | f f | e2 | \bar "||"
  c2 | des4 f | ees2 \bar "||"
  ees2 | f4 f8 g | aes4 g | aes2 | \bar "||"
}

T_notes = \relative a {
  aes2 | ees4 des | c2 \bar "||"
  aes'2 | c4 c | c f, | g2 | \bar "||"
  c,2 | des4 f | ees2 \bar "||"
  aes2 | aes4 aes8 bes | c4 ees | ees2 | \bar "||"
}

B_notes =  \relative c {
  aes'2 | ees4 des | c2 \bar "||"
  f2 | ees4 ees | f des | c2 | \bar "||"
  c2 | des4 f | ees2 \bar "||"
  c2 | des4 des | ees ees | aes2 | \bar "||"
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