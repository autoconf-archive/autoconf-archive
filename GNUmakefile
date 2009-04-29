# Build the Autoconf Archive

srcdir		:= .
m4dir		:= $(srcdir)/m4

STAGEDIR	:= $(srcdir)/stage
M4_FILES	:= $(wildcard $(m4dir)/*.m4)
MACROS		:= $(patsubst $(m4dir)/%.m4,%, $(M4_FILES))
CANON_M4_FILES	:= $(patsubst %,$(STAGEDIR)/%.m4,$(MACROS))
MARKDOWN_FILES	:= $(patsubst %,$(STAGEDIR)/%.mdown,$(MACROS))
HTML_FILES	:= $(patsubst %,$(STAGEDIR)/%.html,$(MACROS))

GENERATED_FILES := $(CANON_M4_FILES) $(MARKDOWN_FILES) $(HTML_FILES) \
		   $(STAGEDIR)/.canonUptodate $(STAGEDIR)/.markdownUptodate \
		   $(STAGEDIR)/autoconf-archive.css

.PHONY: all canon mdown html clean

all: canon mdown html

canon:	$(CANON_M4_FILES)

mdown:  canon $(MARKDOWN_FILES)

html:  mdown $(HTML_FILES)

clean:
	@rm -f $(GENERATED_FILES)
	@if [ -d "$(STAGEDIR)" ] ; then rmdir "$(STAGEDIR)"; fi

##### Generate canon versions of the m4 files #####

$(CANON_M4_FILES) : $(STAGEDIR)/.canonUptodate

$(STAGEDIR)/.canonUptodate :  $(M4_FILES)
	@mkdir -p $(STAGEDIR)
	@$(srcdir)/macro.py --template-lexer=angle-bracket --input-encoding=latin1 --output-encoding=latin1 --output-dir=$(STAGEDIR) --output-suffix=.m4 $(srcdir)/canon.st $?
	@date >$@

##### Generate markdown files #####

$(MARKDOWN_FILES) : $(STAGEDIR)/.canonUptodate $(STAGEDIR)/.markdownUptodate

$(STAGEDIR)/.markdownUptodate : $(CANON_M4_FILES)
	@mkdir -p $(STAGEDIR)
	@$(srcdir)/macro.py --template-lexer=angle-bracket --input-encoding=latin1 --output-encoding=latin1 --output-dir=$(STAGEDIR) --output-suffix=.mdown $(srcdir)/markdown.st $?
	@date >$@

##### Generate HTML files #####

$(STAGEDIR)/%.html : $(STAGEDIR)/%.mdown $(STAGEDIR)/autoconf-archive.css
	@echo generate $@
	@pandoc --standalone --css=autoconf-archive.css --from=markdown --to=html -o $@ $<

$(STAGEDIR)/autoconf-archive.css : $(srcdir)/autoconf-archive.css
	@cp -v -p $< $@
