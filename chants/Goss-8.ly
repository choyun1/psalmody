\version "2.24.1"

\header{
  composer = \markup{\hspace #-26.5 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key des \major
  \time 2/4
}


S_notes = \relative g' {
  f2 | aes4 ges | f2 \bar "||"
  ees2 | c4 des | ges f | ees2 | \bar "||"
  aes2 | des4 c | bes2 \bar "||"
  ees,2 | aes4 f | ees ees | des2 | \bar "||"
}

A_notes = \relative c' {
  aes2 | aes4 bes8 c | des2 \bar "||"
  bes2 | aes4 aes | c des | c2 | \bar "||"
  c2 | des4 des | ges f \bar "||"
  ees2 | aes,4 des | des c | des2 | \bar "||"
}

T_notes = \relative a {
  des2 | c4 bes | aes2 \bar "||"
  ges2 | ees4 aes | ges aes | aes2 | \bar "||"
  aes2 | f4 f | ges aes \bar "||"
  bes4. c8 | des4 aes | aes4. ges8 | f2 | \bar "||"
}

B_notes =  \relative c {
  des2 | des4 des | des2 \bar "||"
  ges,2 | ges'4 f | ees des | aes2 | \bar "||"
  f'2 | bes,4 bes | ees f \bar "||"
  ges2 | f4 des | aes aes | des2 | \bar "||"
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