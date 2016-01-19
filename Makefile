# Bio3SS_content
### Hooks for the editor to set the default target

current: target

target pngtarget pdftarget vtarget acrtarget: nonlinear.draft.pdf 

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

Sources += $(wildcard *.dmu) $(wildcard *.txt) $(wildcard *.poll)

##################################################################

## Outline

outline.pdf: outline.dmu
outline.tex: outline.dmu lect/course.tmp lect/course.fmt talk/lect.pl
	$(PUSH)

######################################################################

## Lecture rules

lect/%.fmt: ;
%.fmt: lect/lect.format lect/fmt.pl
	$(PUSHSTAR)

Sources += beamer.tmp
%.draft.tex: %.txt beamer.tmp draft.fmt talk/lect.pl
	$(PUSH)

%.final.tex: %.txt beamer.tmp final.fmt talk/lect.pl
	$(PUSH)

Sources += outline.tmp
%.outline.tex: %.txt outline.tmp outline.fmt talk/lect.pl
	$(PUSH)

Sources += handouts.tmp
%.handouts.tex: %.txt handouts.tmp handouts.fmt talk/lect.pl
	$(PUSH)

%.complete.tex: %.txt handouts.tmp complete.fmt talk/lect.pl
	$(PUSH)

##################################################################

# Unit 1 (Intro)

intro.draft.pdf: intro.txt
intro.handouts.pdf: intro.txt

math.handouts.pdf: math.txt
math.complete.pdf: math.txt

Sources += weitz_full.pdf filledCircle.R

##################################################################

# Unit 2 (Linear population growth)

linear.final.pdf: linear.txt
linear.draft.pdf: linear.txt
linear.handouts.pdf: linear.txt

##################################################################

# Conversion notes (temporary for 2016)

##################################################################

# Unit 2 (Regulated population growth)

nonlinear.final.pdf: nonlinear.txt
nonlinear.draft.pdf: nonlinear.txt
nonlinear.handouts.pdf: nonlinear.txt

##################################################################

# Project directories

# Time series plots
ts/%: ts
	cd $< && $(MAKE) $*
	touch $@

ts: 
	/bin/ln -s $(gitroot)/Population_time_series $@

# Exponential plots
exponential/%: exponential
	cd $< && $(MAKE) $*
	touch $@
exponential: 
	/bin/ln -s $(gitroot)/Exponential_figures $@

# Lecture images
images/%: images ;
images: 
	/bin/ln -s $(images) $@
	$(link)

## Birth-death models (including time-delay models)
bd_models/%: bd_models
	cd $< && $(MAKE) $*
	touch $@
bd_models: 
	/bin/ln -s $(gitroot)/Birth_death_models $@

## Discrete-time population models with compensation
compensation/%: compensation
	cd $< && $(MAKE) $*
	touch $@
compensation: 
	/bin/ln -s $(gitroot)/Compensation_models $@

##################################################################

## Push to web

%.handouts.pdf.push: %.handouts.pdf
	$(CP) $< $(web)

%.complete.pdf.push: %.complete.pdf
	$(CP) $< $(web)

%.final.pdf.push: %.final.pdf
	$(CP) $< $(Drop)/3SS

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
-include $(ms)/newlatex.mk
include $(ms)/lect.mk
