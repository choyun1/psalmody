\version "2.24.1"

\header{
  composer = \markup{\hspace #-29 \italic "James Turle (1802-1882)"}
  tagline=#f
}

global = {
  \key d \minor
  \time 2/4
}


S_notes = \relative g' {
  a2 | d,4 e | f2 \bar "||"
  g2 | a4 a | a d | d cis | \bar "||"
  d2 | c4 bes | a2 \bar "||"
  a2 | a4 g | f e | d2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 cis | d2 \bar "||"
  e2 | f4 g | f4. g8 | a2 | \bar "||"
  f2 | a4 f | f2 \bar "||"
  d4. e8 | f4 e | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  f2 | a4 a | a2 \bar "||"
  c2 | c4 cis | d d | f e | \bar "||"
  d2 | e4 d | c2 \bar "||"
  a2 | bes4 bes | a4. g8 | f2 | \bar "||"
}

B_notes =  \relative c {
  d2 | f4 a | d,2 \bar "||"
  c2 | f4 e | d bes' | a2 | \bar "||"
  d,2 | a'4 bes | f2 \bar "||"
  f2 | g4 g | a a, | d2 | \bar "||"
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