# Bio3SS_content
### Hooks for the editor to set the default target

current: target

target pngtarget pdftarget vtarget acrtarget pushtarget: structure.draft.pdf 

test: intro.draft.tex.deps
	$(MAKE) intro.draft.pdf.go

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md course.mk
include stuff.mk
-include $(ms)/os.mk

-include $(ms)/perl.def

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
%.lect.fmt: lect/lect.format lect/fmt.pl
	$(PUSHSTAR)

Sources += beamer.tmp
%.draft.tex: %.txt beamer.tmp draft.lect.fmt talk/lect.pl
	$(PUSH)

%.final.tex: %.txt beamer.tmp final.lect.fmt talk/lect.pl
	$(PUSH)

Sources += outline.tmp
%.outline.tex: %.txt outline.tmp outline.lect.fmt talk/lect.pl
	$(PUSH)

Sources += handouts.tmp
%.handouts.tex: %.txt handouts.tmp handouts.lect.fmt talk/lect.pl
	$(PUSH)

%.complete.tex: %.txt handouts.tmp complete.lect.fmt talk/lect.pl
	$(PUSH)

##################################################################

Outputs += $(wildcard *.final.pdf *.asn.pdf)

# Unit 0 (Intro)

intro.draft.pdf: intro.txt
intro.handouts.pdf: intro.txt

math.handouts.pdf: math.txt
math.complete.pdf: math.txt

Sources += weitz_full.pdf filledCircle.R

##################################################################

# Unit 1 (Linear population growth)

linear.final.pdf: linear.txt
linear.draft.pdf: linear.txt
linear.handouts.pdf: linear.txt

##################################################################

# Unit 2 (Regulated population growth)

nonlinear.final.pdf: nonlinear.txt
nonlinear.draft.pdf: nonlinear.txt
nonlinear.handouts.pdf: nonlinear.txt

##################################################################

# Unit 3 (Structured populations growth)

structure.final.pdf: structure.txt
structure.draft.pdf: structure.txt
structure.handouts.pdf: structure.txt

##################################################################

### Tests

### Need to look at figure commands (FIG|PDF) and typically prefix assign/

# HOOKS

midterm1.front.pdf: midterm1.front.tex
midterm1.1.exam.pdf: testselect.pl

Sources += test.tmp copy.tex mc.tmp
Sources += $(wildcard *.front.tex)

Sources += formulas1.tex formulas2.tex formulas3.tex
Sources += $(wildcard *.formulas)

null.tmp:
	touch $@

%.test.fmt: lect/test.format lect/fmt.pl
	$(PUSHSTAR)

%.select.fmt: lect/select.format lect/fmt.pl
	$(PUSHSTAR)

# Look at test banks one at a time (use unit names)

# Make combined banks for each test
midterm1.bank.test: midterm1.formulas assign/linear.bank assign/nonlinear.bank 
	$(cat)

# Select the multiple choice part of a test
%.mc: %.bank.test null.tmp %.select.fmt talk/lect.pl
	$(PUSH)

# Look at short lists one at a time
%.short.tex: assign/%.bank test.tmp bank.test.fmt talk/lect.pl
	$(PUSH)

# Make combined short lists for each test
midterm1.short.test: assign/linear.short assign/nonlinear.short 
	$(cat)

# Select the short-answer part of a test
%.sa: %.short.test null.tmp %.select.fmt talk/lect.pl
	$(PUSH)

Sources += end.dmu

### Combine mc and sa to make the real test
%.test: %.mc end.dmu %.sa
	$(cat)

##### Versioning

Sources += scramble.pl testselect.pl

midterm1.zip: midterm1.1.exam.pdf midterm1.2.exam.pdf midterm1.3.exam.pdf midterm1.4.exam.pdf
	$(ZIP)

midterm1.%.mc: midterm1.mc scramble.pl
	$(PUSHSTAR)

midterm1.%.sa: midterm1.sa testselect.pl
	$(PUSHSTAR)

midterm1.%.exam.pdf: midterm1.front.pdf midterm1.%.test.pdf
	$(pdfcat)

### Process a test into different outputs
%.test.tex: %.test test.tmp test.test.fmt talk/lect.pl
	$(PUSH)

##################################################################


# Project directories

# Assignments directory (on a private repo)
assign/%: assign
	cd $< && $(MAKE) $*
	touch $@

assign:
	cd $(gitroot) && $(MAKE) Assignments
	/bin/ln -s $(gitroot)/Assignments $@

# Time series plots
ts/%: ts
	cd $< && $(MAKE) $*
	touch $@

ts: 
	cd $(gitroot) && $(MAKE) Population_time_series $@
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

## Life tables
life/%: life
	cd $< && $(MAKE) $*
	touch $@
life: 
	/bin/ln -s $(gitroot)/Life_tables $@

## Age distributions
age/%: age
	cd $< && $(MAKE) $*
	touch $@
age: 
	/bin/ln -s $(gitroot)/Age_distributions $@

## Linear models with structure
structure/%: structure
	cd $< && $(MAKE) $*
	touch $@
structure: 
	/bin/ln -s $(gitroot)/Structured_models $@

##################################################################

## Assignments

Sources += asn.tmp

%.ques.fmt: lect/ques.format lect/fmt.pl
	$(PUSHSTAR)

%.asn.tex: assign/%.ques asn.tmp asn.ques.fmt talk/lect.pl
	$(PUSH)

%.key.tex: assign/%.ques asn.tmp key.ques.fmt talk/lect.pl
	$(PUSH)

%.rub.tex: assign/%.ques asn.tmp rub.ques.fmt talk/lect.pl
	$(PUSH)

##################################################################

## Push to web

# Notes
%.handouts.pdf.push: %.handouts.pdf
	$(CP) $< $(web)

%.complete.pdf.push: %.complete.pdf
	$(CP) $< $(web)

# Assignments
%.asn.pdf.push: %.asn.pdf
	$(CP) $< $(web)

%.key.pdf.push: %.key.pdf
	$(CP) $< $(web)

# Slides
%.final.pdf.push: %.final.pdf
	$(CP) $< $(Drop)/3SS

## Push to private repo

%.private: %
	$(CP) $< assign

## Outputs branch; not worth it!

outputs.new: commit.time
	git checkout -b outputs
	git rm $(Sources)
	git commit -a -m "clearSources"
	git push -u origin outputs
	git checkout master

pushOut: $(Outputs) commit.time
	git checkout outputs
	git add $(Outputs)
	git commit -m "pushOut"
	git push -u origin outputs
	git checkout master

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
-include $(ms)/newlatex.mk
-include $(ms)/lect.mk
