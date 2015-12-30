# Bio3SS_content
### Hooks for the editor to set the default target

current: target

target pngtarget pdftarget vtarget acrtarget: test 

test: intro.draft.tex.deps
	$(MAKE) intro.draft.pdf.go

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk

include $(ms)/perl.def

##################################################################

# General content

Sources += todo.mkd

Sources += $(wildcard *.dmu) $(wildcard *.txt)

##################################################################

## Outline

outline.pdf: outline.dmu
outline.tex: outline.dmu lect/course.tmp lect/course.fmt talk/lect.pl
	$(PUSH)

######################################################################

# HOOK
draft.fmt: lect/lect.format lect/fmt.pl

## Lecture rules

%.fmt: lect/lect.format lect/fmt.pl
	$(PUSHSTAR)

Sources += beamer.tmp
%.draft.tex: %.txt beamer.tmp draft.fmt talk/lect.pl
	$(PUSH)

%.final.tex: %.txt beamer.tmp final.fmt talk/lect.pl
	$(PUSH)


##################################################################

# Unit 1 (Intro)

intro.draft.pdf: intro.txt

##################################################################

# Project directories

# Time series plots
ts/%: ts
	cd ts && $(MAKE) $*

ts: 
	/bin/ln -s $(gitroot)/Population_time_series $@

# Lecture images
images/%: images ;
images: $(images)
	$(link)

##################################################################

## Push to web

%.push: %
	$(CP) $< $(web)

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
-include $(ms)/newlatex.mk
include $(ms)/lect.mk
