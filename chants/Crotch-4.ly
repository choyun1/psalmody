\version "2.24.1"

\header{
  composer = \markup{\hspace #-31.5 \italic "William Crotch (1775-1847)"}
  tagline=#f
}

global = {
  \key g \minor
  \time 2/4
}


S_notes = \relative g' {
  bes2 | a4 g | ees'2 \bar "||"
  c4. bes8 | a4 bes | bes a | bes2 | \bar "||"
  bes2 | a4 g | c2 \bar "||"
  aes4. g8 | fis4 g | g fis | g2 \bar "||"
}

A_notes = \relative c' {
  g'2 | fis4 g | g2 \bar "||"
  g2 | f4 f | f f | f2 | \bar "||"
  f2 | ees4 d | c2 \bar "||"
  ees4. d8 | c4 d | d d | d2 | \bar "||"
}

T_notes = \relative a {
  d2 | c4 d | ees2 \bar "||"
  ees2 | ees4 d | c c | d2 | \bar "||"
  d2 | c4 bes | g2 \bar "||"
  c2 | c4 bes | a a | bes2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | a4 bes | c2 \bar "||"
  c,2 | f4 bes | f f | bes,2 | \bar "||"
  bes2 | c4 d | ees2 \bar "||"
  c4. bes8 | a4 g | d' d | g,2 | \bar "||"
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