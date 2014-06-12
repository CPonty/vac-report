# Simple pdflatex document-building makefile for Mac OSX
# Written by Chris Ponticello - christopher.ponticello@uqconnect.edu.au

# =====================================================================

#IMG := $(wildcard *.bmp *.gif)
TEX := $(wildcard *.tex)

#BMP_PDF := $(patsubst %.bmp, %.pdf, $(IMG))
#GIF_PDF := $(patsubst %.gif, %.pdf, $(IMG))
# (add more for further image types)

TEX_PDF := $(patsubst %.tex, %.pdf, $(TEX))
#IMG_PDF := $(BMP_PDF) $(GIF_PDF)

REFERENCES := references/bibliography.bib
DOC_AUX := vac-report.aux
DOC_PDF := vac-report.pdf
DOC_TEX := vac-report.tex

# =====================================================================

%.bib: $(AUX)
	pdflatex $(DOC_TEX)
	bibtex $(DOC_AUX)
%.pdf: %.tex
	pdflatex "$<" "$@"

#%.pdf: %.bmp
#	convert "$<" "$@"
#%.pdf: %.gif
#	convert "$<" "$@"

open: all reopen

reopen:
	open -a /Applications/Skim.app $(DOC_PDF)

# compile multi-file latex document:
# 	unsupported images -> pdf
#	tex -> pdf
#	make follow-up passes on the $(DOCUMENT) - ensures everything gets done
#all: $(IMG_PDF) $(TEX_PDF) doc
all: $(TEX_PDF) doc

# compile single-file latex document with some images
#doc: $(IMG_PDF) $(REFERENCES)
doc: $(REFERENCES)
	pdflatex $(DOC_TEX)
	pdflatex $(DOC_TEX)

# compile single-file latex document
single: $(DOC_PDF)

clean: clean_lite
	rm $(DOC_PDF) 2>/dev/null; exit 0

clean_lite:
	rm *.log *.lof *.lot *.toc *.out *.aux *.bbl *.bcf *.blg 2>/dev/null; exit 0

release: all clean_lite
