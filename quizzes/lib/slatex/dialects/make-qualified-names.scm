(scmxlate-prefix 
 (if (eqv? *dialect* 'bigloo)
     "slatex$$"
     "slatex::")
 *slatex-version*
 *operating-system*
 defenum
 defrecord
 setf
 the-setter-for-of
 of
 ormapcdr
 list-prefix?
 string-suffix?
 mapcan
 lassoc
 lmember
 delete
 adjoin
 delete-if
 string-prefix?
 sublist
 position-char
 string-position-right
 *return*
 *tab*
 slatex-error
 exit-slatex
 *slatex-case-sensitive?*
 keyword-tokens
 variable-tokens
 constant-tokens
 data-tokens
 special-symbols
 macro-definers
 case-and-ilk
 tex-analog
 token=?
 *slatex-enabled?*
 *slatex-reenabler*
 *intext-triggerers*
 *resultintext-triggerers*
 *display-triggerers*
 *response-triggerers*
 *respbox-triggerers*
 *box-triggerers*
 *topbox-triggerers*
 *input-triggerers*
 *region-triggerers*
 *math-triggerers*
 *slatex-in-protected-region?*
 *protected-files*
 *include-onlys*
 *latex?*
 *slatex-separate-includes?*
 *tex-calling-directory*
 *max-line-length*
 make-raw-line
 =rtedge
 =char
 =space
 =tab
 =notab
 make-line
 *line1*
 *line2*
 make-case-frame
 =in-ctag-tkn
 =in-bktd-ctag-exp
 =in-case-exp
 make-bq-frame
 =in-comma
 =in-bq-tkn
 =in-bktd-bq-exp
 *latex-paragraph-mode?*
 *intext?*
 *code-env-spec*
 *in*
 *out*
 *in-qtd-tkn*
 *in-bktd-qtd-exp*
 *in-mac-tkn*
 *in-bktd-mac-exp*
 *case-stack*
 *bq-stack*
 display-space
 display-tab
 display-notab
 prim-data-token?
 set-keyword
 set-constant
 set-variable
 set-data
 set-special-symbol
 unset-special-symbol
 texify
 texify-data
 texify-aux
 display-begin-sequence
 display-end-sequence
 display-tex-char
 display-token
 get-line
 peephole-adjust
 add-some-tabs
 remove-some-tabs
 clean-init-spaces
 clean-inner-spaces
 blank-line?
 flush-comment-line?
 display-tex-line
 display-scm-line
 do-all-lines
 scheme2tex
 do-token
 output-token
 directory-namestring
 basename
 *texinputs*
 *texinputs-list*
 *path-separator*
 *directory-mark*
 *directory-mark-string*
 *file-hider*
 path-to-list
 find-some-file
 file-extension
 full-texfile-name
 full-styfile-name
 full-clsfile-name
 full-scmfile-name
 subjobname
 primary-aux-file-count
 new-primary-aux-file
 new-secondary-aux-file
 new-aux-file
 eat-till-newline
 read-ctrl-seq
 eat-tabspace
 eat-whitespace
 eat-tex-whitespace
 chop-off-whitespace
 read-grouped-latexexp
 read-filename
 read-schemeid
 read-delimed-commaed-filenames
 read-grouped-commaed-filenames
 read-bktd-commaed-filenames
 read-grouped-schemeids
 eat-delimed-text
 eat-bktd-text
 eat-grouped-text
 ignore2
 disable-slatex-temply
 enable-slatex-again
 add-to-slatex-db
 add-to-slatex-db-basic
 add-to-slatex-db-special
 process-slatex-alias
 decide-latex-or-tex
 process-include-only
 process-documentstyle
 process-documentclass
 process-case-info
 seen-first-command?
 process-main-tex-file
 dump-intext
 dump-display
 debug?
 process-tex-file
 process-scheme-file
 trigger-scheme2tex
 trigger-region
 inline-protected-files
 inline-protected
 )