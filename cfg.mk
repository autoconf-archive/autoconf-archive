# autoconf-archive/cfg.mk

# settings required by the maintainer-makefile module

gnu_rel_host    := dl.sv.nongnu.org:/releases/autoconf-archive/
old_NEWS_hash   := 6617325115eed1b0e56a3c272f9d15d7
gpg_key_ID      := 99089D72
url_dir_list    := http://download.savannah.nongnu.org/releases/autoconf-archive
today           := $(date "+%Y-%m-%d")
TAR_OPTIONS     += --mtime=$(today)
manual_title    := Autoconf Archive Web Site

# maintainer targets

M4DIR           := $(srcdir)/m4
STAGEDIR        := $(srcdir)/stage
DOCDIR          := $(srcdir)/doc

M4_FILES        := $(wildcard $(M4DIR)/*.m4)
MACROS          := $(patsubst $(M4DIR)/%.m4,%, $(M4_FILES))
TEXI_FILES      := $(patsubst %,$(DOCDIR)/%.texi,$(MACROS))

.PHONY: maintainer-generate
.PRECIOUS: $(patsubst %,$(STAGEDIR)/%.m4,$(MACROS))
ALL_RECURSIVE_TARGETS += maintainer-generate
maintainer-generate: $(TEXI_FILES) $(DOCDIR)/all-macros.texi

$(STAGEDIR)/manifest:
	@$(MKDIR_P) $(STAGEDIR)
	@rm -f "$@"
	@for n in $(basename $(notdir $(M4_FILES))); do echo "$$n" >>"$@"; done

$(STAGEDIR)/%.m4 : $(M4DIR)/%.m4 $(STAGEDIR)/manifest $(srcdir)/macro.py $(srcdir)/macro2m4.py
	$(srcdir)/macro2m4.py "$<" "$@"
	@diff -u "$<" "$@"

$(DOCDIR)/%.texi : $(STAGEDIR)/%.m4 $(srcdir)/macro2texi.py $(srcdir)/macro.py
	$(srcdir)/macro2texi.py "$<" "$@"

$(DOCDIR)/all-macros.texi: $(srcdir)/configure
	@echo generating $@
	@$(MKDIR_P) $(DOCDIR)
	@rm -f "$@"
	@echo '@menu' >>"$@"
	@for n in $(MACROS); do echo "* $$n::" >>"$@"; done
	@echo '@end menu' >>"$@"
	@echo '' >>"$@"
	@for n in $(MACROS); do echo "@include $$n.texi" >>"$@"; done
