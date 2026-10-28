\version "2.24.1"

\header{
  composer = \markup{\hspace #-26.5 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key f \minor
  \time 2/4
}


S_notes = \relative g' {
  aes2 | f4 g | e2 \bar "||"
  c2 | f4 g | aes bes | c2 | \bar "||"
  c2 | ees4 bes | des2 \bar "||"
  c2 | aes4 bes | g g | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | f4 des | c2 \bar "||"
  c2 | c4 bes | f' f | e2 | \bar "||"
  ees?2 | ees4 ees | des2 \bar "||"
  g2 | f4 f | f e | f2 | \bar "||"
}

T_notes = \relative a {
  aes2 | aes4 bes | g2 \bar "||"
  e2 | f4 des' | bes g | g2 | \bar "||"
  aes2 | bes4 bes | aes2 \bar "||"
  c2 | c4 des | c4. bes8 | aes2 | \bar "||"
}

B_notes =  \relative c {
  f2 | des4 bes | c2 \bar "||"
  c2 | des4 des | des des | c2 | \bar "||"
  aes'2 | g4 g | f2 \bar "||"
  e2 | f4 bes, | c c | f2 | \bar "||"
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