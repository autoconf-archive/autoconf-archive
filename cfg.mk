# autoconf-archive/cfg.mk

# settings required by the maintainer-makefile module

gnu_rel_host		:= ftp.gnu.org
old_NEWS_hash		:= b59fa3d002aa90261fec5a87a3346c42
gpg_key_ID		:= 99089D72
today			:= $(date "+%Y-%m-%d")
TAR_OPTIONS		+= --mtime=$(today)
manual_title		:= GNU Autoconf Archive Web Site
news-check-lines-spec	:= 11

# maintainer targets

PYTHON		:= python

M4DIR		:= $(srcdir)/m4
STAGEDIR	:= $(srcdir)/stage
DOCDIR		:= $(srcdir)/doc

M4_FILES	:= $(sort $(wildcard $(M4DIR)/*.m4))
MACROS		:= $(patsubst $(M4DIR)/%.m4,%, $(M4_FILES))
TEXI_FILES	:= $(patsubst %,$(DOCDIR)/%.texi,$(MACROS))

.PHONY: maintainer-all
.PRECIOUS: $(patsubst %,$(STAGEDIR)/%.m4,$(MACROS))
maintainer-all: $(TEXI_FILES) $(DOCDIR)/all-macros.texi $(srcdir)/README

$(STAGEDIR)/manifest:
	@$(MKDIR_P) $(STAGEDIR)
	@rm -f "$@"
	@for n in $(basename $(notdir $(M4_FILES))); do echo "$$n" >>"$@"; done

$(STAGEDIR)/%.m4 : $(M4DIR)/%.m4 $(STAGEDIR)/manifest $(srcdir)/macro.py $(srcdir)/macro2m4.py
	$(PYTHON) $(srcdir)/macro2m4.py "$<" "$@"
	@diff -u "$<" "$@" || (touch --date="1970-01-01 01:00:00" "$@"; false)

$(DOCDIR)/%.texi : $(STAGEDIR)/%.m4 $(srcdir)/macro2texi.py $(srcdir)/macro.py
	$(PYTHON) $(srcdir)/macro2texi.py "$<" "$@"

$(DOCDIR)/all-macros.texi: $(srcdir)/configure
	@echo generating $@
	@$(MKDIR_P) $(DOCDIR)
	@rm -f "$@"
	@echo '@menu' >>"$@"
	@for n in $(MACROS); do echo "* $$n::" >>"$@"; done
	@echo '@end menu' >>"$@"
	@echo '' >>"$@"
	@for n in $(MACROS); do echo "@include $$n.texi" >>"$@"; done

$(srcdir)/README : $(srcdir)/README.md
	@cp -f $< $@
	@chmod -w $@
