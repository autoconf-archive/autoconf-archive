# Build the Autoconf Archive

srcdir		:= .
m4dir		:= $(srcdir)/m4

STAGEDIR	:= $(srcdir)/stage
M4_FILES	:= $(wildcard $(m4dir)/*.m4)
MACROS		:= $(patsubst $(m4dir)/%.m4,%, $(M4_FILES))
CANON_M4_FILES	:= $(patsubst %,$(STAGEDIR)/%.m4,$(MACROS))
MARKDOWN_FILES	:= $(patsubst %,$(STAGEDIR)/%.mdown,$(MACROS))
HTML_FILES	:= $(patsubst %,$(STAGEDIR)/%.html,$(MACROS))

GENERATED_FILES = $(CANON_M4_FILES) $(MARKDOWN_FILES) $(HTML_FILES)
CLEAN_FILES	= $(GENERATED_FILES) $(STAGEDIR)/.dirCreated $(STAGEDIR)/autoconf-archive.css

.SECONDARY: $(GENERATED_FILES)
.PHONY: all clean

all: $(HTML_FILES)

$(STAGEDIR)/%.m4 : $(m4dir)/%.m4 $(STAGEDIR)/.dirCreated $(srcdir)/macro.py $(srcdir)/canon.st
	@$(srcdir)/macro.py --template-lexer=angle-bracket --input-encoding=latin1 --output-encoding=latin1 --output-dir=$(STAGEDIR) --output-suffix=.m4 $(srcdir)/canon.st $<
	@diff -ub $@ $< || (rm $@; exit 1)

$(STAGEDIR)/%.mdown : $(STAGEDIR)/%.m4 $(srcdir)/macro.py $(srcdir)/markdown.st
	@$(srcdir)/macro.py --template-lexer=angle-bracket --input-encoding=latin1 --output-encoding=latin1 --output-dir=$(STAGEDIR) --output-suffix=.mdown $(srcdir)/markdown.st $<

$(STAGEDIR)/%.html : $(STAGEDIR)/%.mdown $(STAGEDIR)/autoconf-archive.css $(srcdir)/header.html
	@pandoc --standalone --title-prefix='Autoconf Macro: ' --include-before-body=$(srcdir)/header.html --css=autoconf-archive.css --from=markdown --to=html -o $@ $<

$(STAGEDIR)/autoconf-archive.css : $(srcdir)/autoconf-archive.css $(STAGEDIR)/.dirCreated
	@cp -v $< $@

%/.dirCreated:
	@install -D /dev/null $@

clean:
	@rm -f $(CLEAN_FILES)
	@if [ -d "$(STAGEDIR)" ] ; then rmdir "$(STAGEDIR)"; fi
