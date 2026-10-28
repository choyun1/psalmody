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
  f2 | c'4 d | c2 \bar "||"
  a2 | bes4 a | f g | a2 | \bar "||"
  a2 | c4 e, | f2 \bar "||"
  g2 | a4 a | bes g | f2 | \bar "||"
}

A_notes = \relative c' {
  f2 | f4 f | e2 \bar "||"
  f2 | d4 cis | d d | cis2 | \bar "||"
  c?2 | c4. bes8 | a2 \bar "||"
  c2 | c4 f | g e | f2 | \bar "||"
}

T_notes = \relative a {
  a2 | c4 bes8 a | g2 \bar "||"
  f2 | g4 e | d e8 d | e2 | \bar "||"
  f2 | g4 g | f2 \bar "||"
  c'4. bes8 | a4 f | d' g,8 bes | a2 | \bar "||"
}

B_notes =  \relative c {
  f2 | a,4 bes | c2 \bar "||"
  d2 | g,4 a | bes bes | a2 | \bar "||"
  f'2 | e4 c | d2 \bar "||"
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