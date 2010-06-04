# autoconf-archive/cfg.mk

# settings required by the maintainer-makefile module

gnu_rel_host    := dl.sv.gnu.org
upload_dest_dir_:= /releases/autoconf-archive/
old_NEWS_hash   := f077b30c974bbfa37ecec88e5ce561b8
gpg_key_ID      := 99089D72
url_dir_list    := http://download.savannah.gnu.org/releases/autoconf-archive
today           := $(date "+%Y-%m-%d")
TAR_OPTIONS     += --mtime=$(today)
manual_title    := GNU Autoconf Archive Web Site

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
