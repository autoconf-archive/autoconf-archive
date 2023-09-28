# autoconf-archive/cfg.mk

# settings required by the maintainer-makefile module

gnu_rel_host		:= ftp.gnu.org
old_NEWS_hash		:= cf265fa767e0fb81fc7965d0ae68078f
gpg_key_ID		:= 1A4F63A13A4649B632F65EE141BC28FE99089D72
today			:= $(date "+%Y-%m-%d")
TAR_OPTIONS		+= --mtime=$(today)
manual_title		:= GNU Autoconf Archive Web Site
news-check-lines-spec	:= 11

# maintainer targets

PYTHON		:= python3

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
	@diff -u "$<" "$@" || (touch -d "1970-01-01 01:00:00" "$@"; false)

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
