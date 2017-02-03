# Bio3SS_content

### Planning spreadsheet https://docs.google.com/spreadsheets/d/1v07n8Jfsu0tcqpulHUiQktoMq1uTmtuzGmW_FtAxyeI/edit#gid=0

current: target

target pngtarget pdftarget vtarget acrtarget pushtarget: structure.draft.pdf 

test: intro.draft.tex.deps
	$(MAKE) intro.draft.pdf.go

##################################################################

# This is a big, old messy directory. It seems to clone OK, though.

# Lecture formats are in lect/
##### Main is lect/lect.format. Probably

# Scripts seem to be in talk/ and make rules in $(ms). But it's not clear if those work

######################################################################


# make files

Sources += Makefile .gitignore README.md stuff.mk LICENSE.md notes.md
include stuff.mk
-include $(ms)/os.mk

-include $(ms)/perl.def

## Orphaned from 2016
Sources += exam.tmp final_texcover.tex scantron.jpg

## local
Sources += dushoff.mk
dl:
	$(LN) dushoff.mk local.mk

##################################################################

# General content

Sources += todo.mkd agenda.mkd

Sources += $(wildcard *.dmu) $(wildcard *.txt) $(wildcard *.poll)

##################################################################

## Outline
## Deprecated! Now part of the gh-pages

outline.pdf: outline.dmu
outline.tex: outline.dmu lect/course.tmp lect/course.fmt talk/lect.pl
	$(PUSH)
outline.pdf.push: outline.pdf
	cp $< ~/git/Bio3SS.github.io/materials/

######################################################################

## Lecture rules

lect/%.fmt: ;
%.lect.fmt: lect/lect.format lect/fmt.pl
	$(PUSHSTAR)

.PRECIOUS: lect/lect.format lect/fmt.pl

Sources += beamer.tmp
%.draft.tex: %.txt beamer.tmp draft.lect.fmt talk/lect.pl
	$(PUSH)

%.final.tex: %.txt beamer.tmp final.lect.fmt talk/lect.pl
	$(PUSH)

Sources += outline.tmp
%.outline.tex: %.txt outline.tmp lect/outline.fmt talk/lect.pl
	$(PUSH)

Sources += handouts.tmp
%.handouts.tex: %.txt handouts.tmp handouts.lect.fmt talk/lect.pl
	$(PUSH)

%.complete.tex: %.txt handouts.tmp complete.lect.fmt talk/lect.pl
	$(PUSH)

##################################################################

# Unit 0 (Intro)

intro.draft.pdf: intro.txt
intro.handouts.pdf: intro.txt

math.handouts.pdf: math.txt
math.complete.pdf: math.txt

Sources += weitz_full.pdf 

##################################################################

## Large-print development

## This kind of works, but has issues (e.g., with frac, fancy R)
## Could be useful for later if people demand editable
%.hh.tex: %.handouts.tex webhtml.pl
	$(PUSH)
linear.handouts.html: linear.hh.tex
	$(pandocs)

## extarticle seems good instead
## changed the tmp to extarticle because there seems no downside
%.large.tex: %.handouts.tex
	perl -pe 's/12pt/17pt/' $< > $@

##################################################################

# Unit 1 (Linear population growth)

linear.final.pdf: linear.txt
linear.draft.pdf: linear.txt
linear.handouts.pdf: linear.txt
linear.complete.pdf: linear.txt

# Unit 2 (Regulated population growth)

nonlinear.final.pdf: nonlinear.txt
nonlinear.draft.pdf: nonlinear.txt
nonlinear.handouts.pdf: nonlinear.txt

##################################################################

# Unit 3 (Structured populations growth)

structure.final.pdf: structure.txt
structure.draft.pdf: structure.txt
structure.handouts.pdf: structure.txt

structure.pq: structure.txt pq.pl
	$(PUSH)

##################################################################

# Unit 4 (Life history)

life_history.final.pdf: life_history.txt
life_history.draft.pdf: life_history.txt
life_history.handouts.pdf: life_history.txt

######################################################################

# Unit 5 (Competition)

competition.final.pdf: competition.txt
competition.draft.pdf: competition.txt
competition.complete.pdf: competition.txt
competition.handouts.pdf: competition.txt

##################################################################

# Unit 6 (Exploitation)

exploitation.final.pdf: exploitation.txt
exploitation.draft.pdf: exploitation.txt
exploitation.handouts.pdf: exploitation.txt
exploitation.complete.pdf: exploitation.txt

##################################################################

# Unit 6 (Disease)

disease.outline.pdf: disease.txt
disease.final.pdf: disease.txt
disease.draft.pdf: disease.txt
disease.handouts.pdf: disease.txt

##################################################################

### Tests

### Need to look at figure commands (FIG|PDF) and typically prefix assign/

Sources += test.tmp copy.tex mc.tmp
Sources += $(wildcard *.front.tex)

Sources += formulas1.tex formulas2.tex formulas3.tex
Sources += $(wildcard *.formulas)

### Formats

null.tmp:
	touch $@

%.test.fmt: lect/test.format lect/fmt.pl
	$(PUSHSTAR)

%.select.fmt: lect/select.format lect/fmt.pl
	$(PUSHSTAR)

# Look at test banks one at a time (use unit names)

%.bank: assign/%.bank
	$(copy)

linear.bank.key.pdf: assign/linear.bank
nonlinear.bank.key.pdf: assign/nonlinear.bank
structure.bank.key.pdf: assign/structure.bank
life_history.bank.key.pdf: assign/life_history.bank
comp.bank.key.pdf: assign/comp.bank
pred.bank.key.pdf: assign/pred.bank
disease.bank.key.pdf: assign/disease.bank

# Make combined banks for each test
midterm1.bank: midterm1.formulas assign/linear.bank assign/nonlinear.bank 
	$(cat)

%.bank.test: %.bank null.tmp bank.select.fmt talk/lect.pl
	$(PUSH)

midterm2.bank.key.pdf:
midterm2.bank: midterm2.formulas assign/linear.bank assign/nonlinear.bank assign/structure.bank assign/life_history.bank
	$(cat)

final.bank.key.pdf:
final.bank: final.formulas assign/linear.bank assign/nonlinear.bank assign/structure.bank assign/life_history.bank assign/comp.bank assign/pred.bank assign/disease.bank
	$(cat)

# Select the multiple choice part of a test
.PRECIOUS: %.mc
%.mc: %.bank null.tmp %.select.fmt talk/lect.pl
	$(PUSH)

# Look at short lists one at a time
%.short.tex: assign/%.bank test.tmp bank.test.fmt talk/lect.pl
	$(PUSH)

# Make combined short lists for each test
midterm1.short.test: assign/linear.short assign/nonlinear.short 
	$(cat)

midterm2.short.test: assign/linear.short assign/nonlinear.short assign/structure.short assign/life_history.short
	$(cat)

# Select the short-answer part of a test
.PRECIOUS: %.sa
%.sa: %.short.test null.tmp %.select.fmt talk/lect.pl
	$(PUSH)

### Separator for MC and SA on the same test
Sources += end.dmu

### Combine mc and sa to make the real test
%.test: %.mc end.dmu %.sa
	$(cat)

final.key.pdf:
final.test: final.mc
	$(copy)

##### Versioning

## Now 5 versions: four for the main test, and one for others (SAS, late finals, ...)

Sources += $(wildcard *.pl) $(wildcard *.R)

## Printing
midterm1.zip: midterm1.1.exam.pdf midterm1.2.exam.pdf midterm1.3.exam.pdf midterm1.4.exam.pdf
	$(ZIP)

## Printing
midterm2.zip: midterm2.1.exam.pdf midterm2.2.exam.pdf midterm2.3.exam.pdf midterm2.4.exam.pdf midterm2.5.exam.pdf
	$(ZIP)

final.zip: final.1.final.pdf final.2.final.pdf final.3.final.pdf final.4.final.pdf final.5.final.pdf
	$(ZIP)

## Pushing
midterm2.tests: midterm2.1.test.pdf.push midterm2.2.test.pdf.push midterm2.3.test.pdf.push midterm2.4.test.pdf.push

midterm2.keys: midterm2.1.key.pdf.push midterm2.2.key.pdf.push midterm2.3.key.pdf.push midterm2.4.key.pdf.push midterm2.5.key.pdf.push

# These rules need to be explicit, because of conflict with bank rules. A pain, but no easy fix.
midterm1.%.mc: midterm1.mc scramble.pl
	$(PUSHSTAR)

midterm1.%.sa: midterm1.sa testselect.pl
	$(PUSHSTAR)

midterm1.%.exam.pdf: midterm.front.pdf midterm1.%.test.pdf
	$(pdfcat)

midterm2.%.exam.pdf: midterm.front.pdf midterm2.%.test.pdf
	$(pdfcat)

final.%.exam.pdf: final.front.pdf final.%.pdf
	$(pdfcat)

midterm2.%.mc: midterm2.mc scramble.pl
	$(PUSHSTAR)

final.%.test: final.mc scramble.pl
	$(PUSHSTAR)

midterm2.%.sa: midterm2.sa testselect.pl
	$(PUSHSTAR)

midterm2.%.exam.pdf: midterm2.front.pdf midterm2.%.test.pdf
	$(pdfcat)

### Process a test into different outputs
%.test.tex: %.test test.tmp test.test.fmt talk/lect.pl
	$(PUSH)

final.1.final.pdf: exam.tmp 
%.final.tex: %.test exam.tmp test.test.fmt talk/lect.pl
	$(PUSH)

%.key.tex: %.test test.tmp key.test.fmt talk/lect.pl
	$(PUSH)

%.rub.tex: %.sa test.tmp rub.test.fmt talk/lect.pl
	$(PUSH)

midterm2.rub.tgz: midterm2.1.rub.pdf midterm2.2.rub.pdf midterm2.3.rub.pdf midterm2.4.rub.pdf midterm2.5.rub.pdf
	$(TGZ)

######################################################################

# Substance (belongs elsewhere)

ebola_time = steps.R gamHist.R # Copied from academicWW

######################################################################

#### Marking

## Hooks

# Make a plain answer key (ssv)
midterm2.1.ssv: midterm2.1.test key.pl
%.ssv: %.test key.pl
	$(PUSH)

final.ssv:

# Make a special answer key for scantron processing
%.sc.csv: %.ssv scantron.pl
	$(PUSH)

# Combine a bunch of scantron keys into a file for the processors
final.scantron.csv midterm1.scantron.csv midterm2.scantron.csv: %.scantron.csv: %.1.sc.csv %.2.sc.csv %.3.sc.csv %.4.sc.csv %.5.sc.csv
	$(cat)

#### Marking and analyzing

# Make a skeleton to track how questions are scrambled
%.skeleton: %.test skeleton.pl
	$(PUSH)

# Make files showing the order for versions of a test
midterm1.%.order: midterm2.skeleton scramble.pl
	$(PUSHSTAR)

midterm2.%.order: midterm2.skeleton scramble.pl
	$(PUSHSTAR)

midterm1.orders:
midterm%.orders: midterm%.1.order midterm%.2.order midterm%.3.order midterm%.4.order midterm%.5.order orders.pl
	$(PUSH)

## Student responses from scantron
%.responses.csv: assign/%.responses.csv
	perl -ne 'print if /^[0-9]{3}/' $< > $@

## Archive
assign/midterm2.scores.orig.csv:
	/bin/cp midterm2.scores.Rout.csv $@

## Recorded version
midterm2.pv.Rout: grades/ta.csv midterm2.pv.R

## Compile scores
midterm2.scores.Rout.csv:
midterm2.scores.Rout: scores.R
%.scores.Rout: %.pv.Rout %.responses.csv %.orders %.ssv scores.R
	$(run-R)

# newscores.R is not working yet; tries to merge in manually entered version numbers

######### Error correction
## Bonus files
midterm2.mortfix.bonus.Rout: midterm2.responses.csv midterm2.orders mortfix.ssv scores.R
midterm2.%.bonus.Rout: midterm2.responses.csv midterm2.orders %.ssv scores.R
	$(run-R)

## Combining
midterm2.fixed.Rout: midterm2.scores.Rout.csv midterm2.mortfix.bonus.Rout.csv midterm2.nonsense.bonus.Rout.csv addscores.R
	$(run-R)

### A bunch of pipeline problems due to my addressing the bubbling problems too late. Did not manually check versions for these people, and did not figure out what's going on with the scores.R

# Sources += midterm2.hand.csv
midterm2.hand.csv: assign/midterm2.hand.csv
	$(copy)

midterm2.curved.Rout.csv: 
midterm2.curved.Rout: midterm2.hand.csv curve.R
	$(run-R)

## Compare our calculated scores with scores calculated by the Media folks
%.media.csv: assign/%.media.csv
	perl -ne 'print if /^[a-z]{3}/' $< > $@

midterm2.scorecheck.Rout: scorecheck.R
%.scorecheck.Rout: %.scores.Rout %.media.csv scorecheck.R
	$(run-R)

## Descramble and evaluate questions

midterm2.descramble.Rout: descramble.R
%.descramble.Rout: %.scores.Rout descramble.R
	$(run-R)

##################################################################

# Project directories
# These touch commands sometimes lead to endless remaking; 
#    wonder if I added them for some reason.

# Assignments directory (on a private repo)
assign/%: assign
	cd $< && $(MAKE) $*

# touch $@

assign:
	cd $(gitroot) && $(MAKE) Assignments
	/bin/ln -s $(gitroot)/Assignments $@

# Grades directory 
grades/%: grades
	cd $< && $(MAKE) $*

# touch $@

grades:
	/bin/ln -s $(gitroot)/Grading_scripts $@

# Time series plots
ts/%: ts
	cd $< && $(MAKE) $*

# touch $@

ts: 
	cd $(gitroot) && $(MAKE) Population_time_series
	/bin/ln -s $(gitroot)/Population_time_series $@

# Exponential plots
exponential/%: exponential
	cd $< && $(MAKE) $*

# touch $@
exponential: 
	/bin/ln -s $(gitroot)/Exponential_figures $@

# Lecture images
images/%: images ;
images: 
	/bin/ln -s $(images) $@

# touch $@

## Birth-death models (including time-delay models)
bd_models/%: bd_models
	cd $< && $(MAKE) $*

# touch $@
bd_models: 
	/bin/ln -s $(gitroot)/Birth_death_models $@

## Discrete-time population models with compensation
compensation/%: compensation
	cd $< && $(MAKE) $*

# touch $@
compensation: 
	/bin/ln -s $(gitroot)/Compensation_models $@

## Life tables
life_tables/%: life_tables
	cd $< && $(MAKE) $*

# touch $@
life_tables: 
	/bin/ln -s $(gitroot)/Life_tables $@

## Life history
life_history/%: life_history
	cd $< && $(MAKE) $*

# touch $@
life_history: 
	/bin/ln -s $(gitroot)/Life_history $@

## Age distributions
age/%: age
	cd $< && $(MAKE) $*

# touch $@
age: 
	/bin/ln -s $(gitroot)/Age_distributions $@

## Linear models with structure
structure/%: structure
	cd $< && $(MAKE) $*

# touch $@
structure: 
	/bin/ln -s $(gitroot)/Structured_models $@

## Competition models
competition/%: competition
	cd $< && $(MAKE) $*

# touch $@
competition: 
	/bin/ln -s $(gitroot)/Competition_models $@

## Exploitation models
exploitation/%: exploitation
	cd $< && $(MAKE) $*

# touch $@

exploitation: 
	/bin/ln -s $(gitroot)/Exploitation_models $@

### Disease stuff (hard to organize)
boxes/%: boxes
	cd $< && $(MAKE) $*

# touch $@

boxes: 
	/bin/ln -s $(gitroot)/SIR_model_family $@

dd/%: dd
	cd $< && $(MAKE) $*

# touch $@

dd: 
	/bin/ln -s $(gitroot)/Disease_data $@

sims/%: sims
	cd $< && $(MAKE) $*

# touch $@

sims: 
	/bin/ln -s $(gitroot)/SIR_simulations $@

ebola/%: ebola
	cd $< && $(MAKE) $*

# touch $@

ebola: 
	/bin/ln -s $(gitroot)/WA_Ebola_Outbreak $@

##################################################################

## Assignments

##
intro.asn.pdf: assign/intro.ques

pg.asn.pdf: assign/pg.ques

regulation.key.pdf: assign/regulation.ques

## Interaction is an old assignment, now broken up into a very short (life history) assignment and a slightly longer (competition) assignment
interaction.asn.pdf: assign/interaction.ques
competition.key.pdf: assign/competition.ques

expl.asn.pdf: assign/expl.ques

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

# Notes
%.large.pdf.push: %.large.pdf
	$(CP) $< $(web)

%.complete.pdf.push: %.complete.pdf
	$(CP) $< $(web)

# Assignments
%.asn.pdf.push: %.asn.pdf
	$(CP) $< $(web)

%.key.pdf.push: %.key.pdf
	$(CP) $< $(web)

%.test.pdf.push: %.test.pdf
	$(CP) $< $(web)

# Slides
%.final.pdf.push: %.final.gp ;
%.draft.pdf.push: %.draft.gp ;

## Push to private repo
%.private: %
	$(CP) $< assign

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
-include $(ms)/newlatex.mk
-include $(ms)/lect.mk

