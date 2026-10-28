\version "2.24.1"

\header{
  composer = \markup{\hspace #-40 \italic "Parisian Tone"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | c4 bes | a g \bar "||"
  g2 | a4 bes | a g | f2 | \bar "||"
}

A_notes = \relative c' {
  f2 | f4 g | f e \bar "||"
  d2 | f4 f | f e | f2 | \bar "||"
}

T_notes = \relative a {
  c2 | c4 d | c2 \bar "||"
  bes2 | c4 d | c c | a2 | \bar "||"
}

B_notes =  \relative c {
  f2 | a,4 bes | c2 \bar "||"
  <g' \parenthesize \tweak font-size -3 g,>2 | <f \parenthesize \tweak font-size -3 f,>4 bes, | c c | f2 | \bar "||"
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