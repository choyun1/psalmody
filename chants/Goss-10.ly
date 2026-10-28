\version "2.24.1"

\header{
  composer = \markup{\hspace #-27 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key c \minor
  \time 2/4
}


S_notes = \relative g' {
  ees2 | ees4 d | c2 \bar "||"
  ees4. f8 | g4 aes | bes f | g2 | \bar "||"
  g2 | aes4 f | b2 \bar "||"
  b2 | c4 d | ees b | c2 \bar "||"
}

A_notes = \relative c' {
  c2 | b4 b | c2 \bar "||"
  c2 | bes4 ees | ees d | ees2 | \bar "||"
  ees2 | d4 d | d2 \bar "||"
  aes'!2 | g4 aes | g f | ees2 | \bar "||"
}

T_notes = \relative a {
  g2 | aes4 aes | g2 \bar "||"
  aes2 | g4 ees8 f | g4 aes | g2 | \bar "||"
  c2 | c4 c | b2 \bar "||"
  d2 | c4 c | c d | c2 | \bar "||"
}

B_notes =  \relative c {
  c2 | f4 f | ees2 \bar "||"
  aes,2 | ees'4 c | bes bes | ees2 | \bar "||"
  c2 | f4 aes | g2 \bar "||"
  f2 | ees4 f | g g | c,2 | \bar "||"
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