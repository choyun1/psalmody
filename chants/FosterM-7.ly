\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Myles B. Foster (1851-1922)"}
  tagline=#f
}

global = {
  \key des \major
  \time 2/4
}


S_notes = \relative c' {
  f4. ges8 | as4 bes | c2 \bar "||"
  c2 | des4 f, | as g | as2 \bar "||"
  bes2 | as4 des | ges,2 \bar "||"
  as4. ges8 | f4 as | des, es | des2 \bar "||"
}

A_notes = \relative c' {
  des2 | des4 f | e2 \bar "||"
  f2 | f4 f | es es | es2 \bar "||"
  ges4. f8 | es4 des | es2 \bar "||"
  es2 | es4 des8 c | bes4 c | des2 \bar "||"
}

T_notes = \relative c' {
  as2 | as4 f | g2 \bar "||"
  a2 | as4 as | c bes | c2 \bar "||"
  des2 | c4 as | bes2 \bar "||"
  as2 | as4 as | f ges | f2 \bar "||"
}

B_notes = \relative c {
  des4. es8 | f4 des | c2 \bar "||"
  f2 | bes,4 des | es es | as2 \bar "||"
  ges2 | as4 f | es4 des \bar "||"
  c2 | des4 f | bes, as | des2 \bar "||"
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
