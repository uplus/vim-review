if exists('g:loaded_syntastic_review_textlint_checker')
    finish
endif
let g:loaded_syntastic_review_textlint_checker = 1

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'review',
    \ 'name': 'textlint',
    \ 'redirect': 'text/textlint'})
