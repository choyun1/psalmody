\version "2.24.1"

\header{
  composer = \markup{\hspace #-43.5 \italic "Edward Cuthbert Bairstow (1874-1946)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative g' {
  bes2 | des4 des | c2 \bar "||"
  bes2 | aes4 bes | g aes | f2 | \bar "||"
  f2 | aes4 aes | g2 \bar "||"
  f2 | ees4 f | d d | ees2 | \bar "||"
}

A_notes = \relative c' {
  ees2 | f4 g | aes2 \bar "||"
  g2 | g4 f | ees f | d2 | \bar "||"
  des2 | c4 d? | ees d \bar "||"
  c2 | c4 c | bes bes | bes2 | \bar "||"
}

T_notes = \relative a {
  g2 | aes4 des | ees2 \bar "||"
  d?2 | ees4 bes | bes c | bes2 | \bar "||"
  aes2 | c4 aes | bes2 \bar "||"
  aes2 | g4 aes | f aes | g2 | \bar "||"
}

B_notes =  \relative c {
  ees2 | des4 bes | aes2 \bar "||"
  bes2 | c4 d | ees aes, | bes2 | \bar "||"
  des2 | aes4 f | g2 \bar "||"
  aes2 | c4 aes | bes bes | ees2 | \bar "||"
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