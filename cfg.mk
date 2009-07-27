# autoconf-archive/cfg.mk

# settings required by the maintainer-makefile module

gnu_rel_host	:= savannah.nongnu.org
old_NEWS_hash	:= 5ad7b87198d89e04d76b99221591c076
gpg_key_ID	:= 99089D72
url_dir_list	:= http://download.savannah.nongnu.org/releases/autoconf-archive
today		:= $(date "+%Y-%m-%d")
TAR_OPTIONS	+= --mtime=$(today)

# maintainer targets

M4DIR		:= $(srcdir)/m4
HTMLDIR		:= $(srcdir)/html
STAGEDIR	:= $(srcdir)/stage

M4_FILES	:= $(wildcard $(M4DIR)/*.m4)
MACROS		:= $(patsubst $(M4DIR)/%.m4,%, $(M4_FILES))
CANON_M4_FILES	:= $(patsubst %,$(STAGEDIR)/%.m4,$(MACROS))
RAW_HTML_FILES	:= $(patsubst %,$(STAGEDIR)/%.html,$(MACROS))
HTML_FILES	:= $(patsubst %,$(HTMLDIR)/%.html,$(MACROS))

.PHONY: website
ALL_RECURSIVE_TARGETS += website
website: $(HTML_FILES)

$(STAGEDIR)/%.html : $(M4DIR)/%.m4 $(STAGEDIR)/.dirCreated $(srcdir)/macro.py $(srcdir)/macro2html.py
	@$(srcdir)/macro2html.py "$<" "$@"

$(HTMLDIR)/%.html : $(STAGEDIR)/%.html
	@echo generating $*.html
	@tidy -quiet -ascii --indent yes --indent-spaces 1 --tidy-mark no -wrap 80 --hide-comments yes "$<" >"$@"

$(STAGEDIR)/.dirCreated:
	@$(MKDIR_P) $(STAGEDIR)
	@touch $@

taint-distcheck:

my-distcheck:
