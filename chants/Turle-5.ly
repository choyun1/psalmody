\version "2.24.1"

\header{
  composer = \markup{\hspace #-28.5 \italic "James Turle (1802-1882)"}
  tagline=#f
}

global = {
  \key c \minor
  \time 2/4
}


S_notes = \relative g' {
  g2 | c,4 d | ees2 \bar "||"
  f2 | g4 g | g c | c b | \bar "||"
  c2 | bes4 aes | g2 \bar "||"
  g2 | g4 f | ees d | c2 | \bar "||"
}

A_notes = \relative c' {
  c2 | c4 b | c2 \bar "||"
  d2 | ees4 f | ees4. f8 | g2 | \bar "||"
  ees2 | g4 ees | ees2 \bar "||"
  c4. d8 | ees4 d | c b | c2 | \bar "||"
}

T_notes = \relative a {
  ees2 | g4 g | g2 \bar "||"
  bes2 | bes4 b | c c | ees d | \bar "||"
  c2 | d4 c | bes2 \bar "||"
  g2 | aes4 aes | g4. f8 | ees2 | \bar "||"
}

B_notes =  \relative c {
  c2 | ees4 g | c,2 \bar "||"
  bes2 | ees4 d | c aes' | g2 | \bar "||"
  c,2 | g'4 aes | ees2 \bar "||"
  ees2 | f4 f | g g, | c2 | \bar "||"
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