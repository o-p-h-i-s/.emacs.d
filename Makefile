EMACS ?= emacs
EL     = init.el
ELC    = $(EL:%.el=%.elc)

all: $(ELC)

init.el: README.org
	@mkdir -p backups
	@mkdir -p snippets
	$(EMACS) -Q --batch --eval \
		"(progn \
			(require 'ob-tangle) \
			(org-babel-tangle-file \"$<\" \"$@\" \"emacs-lisp\"))"
	$(EMACS) -Q -l init.el --batch --eval '(kill-emacs)'

%.elc: %.el
	$(EMACS) -Q -l init.el --batch -f batch-byte-compile $<

clean:
	rm -rf *.el *.elc *~ auto-save-list backups snippets
