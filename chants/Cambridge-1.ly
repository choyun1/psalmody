\version "2.24.1"

\header{
  composer = \markup{\hspace #-21.5 \italic "Cambridge Chant"}
  tagline=#f
}

global = {
  \key f \minor
  \time 2/4
}


S_notes = \relative g' {
  f2 | f4 g8 f | e2 \bar "||"
  aes2 | bes4 c | aes g | aes2 | \bar "||"
  aes2 | g4 f | e2 \bar "||"
  f2 | bes4 aes | g g | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | des4 des | c2 \bar "||"
  c2 | des4 ees | c bes | c2 | \bar "||"
  ees2 | ees4 c | c2 \bar "||"
  c2 | e4 f | f e | f2 | \bar "||"
}

T_notes = \relative a {
  aes2 | aes4 bes | g2 \bar "||"
  f2 | f4 ees | ees ees | ees2 | \bar "||"
  c'2 | bes4 aes | g2 \bar "||"
  c2 | bes4 c | c c | aes2 | \bar "||"
}

B_notes =  \relative c {
  f2 | des4 bes | c2 \bar "||"
  f2 | des4 aes | ees' ees | aes,2 | \bar "||"
  aes2 | ees'4 f | c2 \bar "||"
  aes2 | g4 f | c' c | f,2 | \bar "||"
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