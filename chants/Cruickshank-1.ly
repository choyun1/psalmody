\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Alexander Campbell Cruickshank (1854-1934)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | c4 bes8 a | bes2 \bar "||"
  g2 | a4 f | e f | g2 \bar "||"
  g2 | a4 b | c2 \bar "||"
  f,2 | f4 d' | c e, | f2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 fis | g4 f \bar "||"
  e2 | f4 c | b b | c2 \bar "||"
  c2 | c4 d | c2 \bar "||"
  c2 | d4 f | f c | c2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 c | d2 \bar "||"
  c2 | c4 a | g f | f e \bar "||"
  g2 | f4 f | e2 \bar "||"
  f2 | f8 g as4 | a g8 bes | a2 \bar "||"
}

B_notes = \relative c {
  f2 | a,4 d | g,2 \bar "||"
  c2 | f4 f | d d | c2 \bar "||"
  e2 | d4 g, | c2 \bar "||"
  a2 | bes4 b | c c | f2 \bar "||"
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
