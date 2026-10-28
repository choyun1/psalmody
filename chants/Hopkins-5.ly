\version "2.24.1"

\header{
  composer = \markup{\hspace #-39 \italic "Edward John Hopkins (1818-1901)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | bes4 a | g2 \bar "||"
  c2 | f,4 f | g a | g2 | \bar "||"
  a2 | bes4 c | d2 \bar "||"
  g,2 | a4 a | bes g | f2 | \bar "||"
}

A_notes = \relative c' {
  f2 | f4 f | f2 \bar "||"
  e2 | f4 d | c c | e2 | \bar "||"
  f2 | e!4 ees | d2 \bar "||"
  e?2 | f4 fis | g e | f2 | \bar "||"
}

T_notes = \relative a {
  c2 | bes4 c | d2 \bar "||"
  c4. bes8 | a4 bes | bes a | c2 | \bar "||"
  c2 | bes4 f' | f2 \bar "||"
  c2 | c4 d | d c8 bes | a2 | \bar "||"
}

B_notes =  \relative c {
  f2 | d4 c | bes2 \bar "||"
  c2 | d4 d | e f | c2 | \bar "||"
  f2 | g4 a | bes2 \bar "||"
  bes2 | a4 d, | g c, | f2 | \bar "||"
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