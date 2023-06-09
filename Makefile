EMACS ?= emacs
INIT   = init.el
EARLY  = early-init.el
EL     = $(INIT) $(EARLY)
ELC    = $(EL:%.el=%.elc)
FILE   = *.el *.elc
DIRS   = backups snippets auto-save-list eln-cache elpa eshell

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
	rm -rf $(FILE)

cleandist:
	rm -rf $(DIRS)

cleanall:
	rm -rf $(FILE) $(DIRS)
