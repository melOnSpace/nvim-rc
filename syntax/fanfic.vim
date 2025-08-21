if exists("b:current_syntax")
    finish
endif

syntax region fanficTodo start=+@TODO:+ end=+[@$]+
syntax region fanficFixMe start=+@FIXME:+ end=+[@$]+
syntax region fanficComment1 start=+\/\*+ end=+\*\/+
syntax region fanficComment2 start=+\/\/+ end=+$+

syntax region fanficItalicBold start=+#+ end=+\v(#)|(\n\n)+
syntax region fanficBold start=+\^+ end=+\v(\^)|(\n\n)+
syntax region fanficItalic start=+\*+ end=+\v(\*)|(\n\n)+
syntax region fanficUnderline start=+_+ end=+\v(_)|(\n\n)+

syntax region fanficQuote start=+"+ end=+\v(")|(\n\n)+ contains=fanficItalic,fanficBold,fanficItalicBold,fanficUnderline
syntax region fanficThought start=+`+ end=+`+ contains=fanficItalic,fanficBold,fanficItalicBold,fanficUnderline
syntax region fanficNote1 start=+\[+ end=+\]+ contains=fanficItalic,fanficBold,fanficItalicBold,fanficUnderline
syntax region fanficNote2 start=+{+ end=+\v(\})|(\n\n)+ contains=fanficItalic,fanficBold,fanficItalicBold,fanficUnderline
syntax region fanficSection start=+===+ end=+===+ contains=fanficBold,fanficItalic,fanficItalicBold,fanficUnderline

highlight fanficTodo guifg=LightRed
highlight fanficFixMe guifg=LightRed
highlight def link fanficComment1 Comment
highlight def link fanficComment2 Comment
highlight fanficItalicBold guifg=LightRed gui=italic,bold
highlight fanficBold guifg=LightRed gui=bold
highlight fanficItalic guifg=LightRed gui=italic
highlight fanficUnderline guifg=LightRed gui=underline
highlight def link fanficSection Title
highlight def link fanficQuote String
highlight def link fanficThought Boolean
highlight def link fanficNote1 Special
highlight def link fanficNote2 Underlined
