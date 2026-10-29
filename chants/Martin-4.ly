\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Clement Martin (1844-1916)"}
  tagline=#f
}

global = {
  \key aes \major
  \time 2/4
}


S_notes = \relative c'' {
  c2 | bes4. c8 | as2 \bar "||"
  g2 | f4 bes8 c | des4 des | des2 \bar "||"
  <c as>4. <des bes>8 | <es c>4 <es c> | <es c>4 <des bes> \bar "||"
  <c g>2 | <c f,>8 <bes f> as4 | <as es>4 <g es> | <as es>2 \bar "||"
}

A_notes = \relative c' {
  es2 | e4 g | f2 \bar "||"
  e2 | f4 f | f bes | bes2 \bar "||"
  as2 | es8 f ges4 | f2 \bar "||"
  e2 | f4 c8 des | es4 es | es2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 c | c2 \bar "||"
  bes2 | as4 f | bes f' | es2 \bar "||"
  es4. des8 | c4 c | bes2 \bar "||"
  bes2 | as4 as | bes8 c des4 | c2 \bar "||"
}

B_notes = \relative c' {
  as2 | g4 e | f2 \bar "||"
  c2 | des4 des8 c | bes4 <as' as,> | <g g,>2 \bar "||"
  as2 | as4 a | bes2 \bar "||"
  c,2 | des4 f | es es | as,2 \bar "||"
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
