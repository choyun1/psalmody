\version "2.24.1"

\header{
  composer = \markup{\hspace #-29 \italic "James Turle (1802-1882)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative g' {
  f2 | f4 g | e2 \bar "||"
  f2 | f4 f | g a | g2 | \bar "||"
  c2 | c4 d | bes2 \bar "||"
  c2 | a4 bes | g g | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | d4 d | c2 \bar "||"
  f2 | d4 f | e f | e2 | \bar "||"
  e2 | d4 fis | g2 \bar "||"
  g2 | c,4 f | f e | f2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 bes | g2 \bar "||"
  c2 | d4 c | bes c | c2 | \bar "||"
  c2 | a4 d | d2 \bar "||"
  c2 | c4 bes | d c8 bes | a2 | \bar "||"
}

B_notes =  \relative c {
  f2 | d4 bes | c2 \bar "||"
  a'2 | bes4 a | g f | c2 | \bar "||"
  a'2 | fis4 d | g2 \bar "||"
  e2 | f4 d | bes c | f2 | \bar "||"
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