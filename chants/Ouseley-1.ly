\version "2.24.1"

\header{
  composer = \markup{\hspace #-64.5 \italic "Frederick A. Gore Ouseley (1825-1889)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative g' {
  f2 | bes4 d | c2 | \bar "||"
  a2 | bes4 g | f ees | d2 | \bar "||"
}

A_notes = \relative c' {
  d2 | f4 f | f2 | \bar "||"
  f2 | d4 ees | c c | bes2 | \bar "||"
}

T_notes = \relative a {
  bes2 | bes4 bes | a2 | \bar "||"
  c2 | bes4 bes | bes a | bes2 | \bar "||"
}

B_notes =  \relative c {
  bes2 | d4 bes | f'2 | \bar "||"
  f2 | g4 ees | f <f \parenthesize \tweak font-size -3 f,> | bes,2 | \bar "||"
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