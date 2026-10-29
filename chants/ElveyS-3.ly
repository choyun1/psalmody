\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Stephen Elvey (1805-1860)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | a4 g | f2 \bar "||"
  f2 | g4 a | bes4 bes | a2 \bar "||"
  c2 | c4 b | c2 \bar "||"
  c2 | d4 c | bes4 bes | a2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 e | d2 \bar "||"
  d2 | d8 e f4 | f4 e | f2 \bar "||"
  f2 | c4 f | e2 \bar "||"
  f2 | f4 f | f4 e | f2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 c | a2 \bar "||"
  a2 | bes4 c | d4 bes | c2 \bar "||"
  a2 | g4 f | g2 \bar "||"
  a2 | bes4 c | d4 c | c2 \bar "||"
}

B_notes = \relative c {
  f2 | f4 c | d2 \bar "||"
  d4. c8 | bes4 a | g4 g | f2 \bar "||"
  f'2 | e4 d | c2 \bar "||"
  f2 | bes4 a | g4 c, | f2 \bar "||"
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
