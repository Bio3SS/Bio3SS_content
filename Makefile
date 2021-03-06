# Bio3SS_content
### Deprecating this whole giant directory!
### Break into:
###### Lectures
###### Assignments (need to RENAME current Assignments, which is private material)
###### Tests
###### Anything else?

### Planning spreadsheet https://docs.google.com/spreadsheets/d/1v07n8Jfsu0tcqpulHUiQktoMq1uTmtuzGmW_FtAxyeI/edit#gid=0

## https://github.com/Bio3SS/Bio3SS_content/

current: target
-include target.mk

test: intro.draft.tex.deps
	$(MAKE) intro.draft.pdf.go

##################################################################

# This is a big, old messy directory. It seems to clone OK, though.
# But it doesn't track all dependencies; I must have cloned it into an environment with the gitroot stuff it needed, at least.

# Lecture formats are in lect/
##### Main is lect/lect.format
##### lect is in makestuff; make sure to sync

# Scripts seem to be in talk/ and make rules in $(ms). But it's not clear if those work

##### talk is in makestuff; make sure to sync
#### Names and places have somehow changed, and things don't work :-(

# make files

Sources += Makefile .ignore README.md sub.mk LICENSE.md notes.md
include sub.mk

-include $(ms)/perl.def

## Orphaned from 2016
## Great note, morpho! WTF does it mean? Maybe that I had to rescue them? 
## In which case, why bother with note once they are rescued.?
## Dunno, but the condition of the final exam is an absolute disaster!
## Better now (after 2017 is finished)
Sources += final.tmp scantron.jpg

## local
Sources += dushoff.mk
dl:
	$(LN) dushoff.mk local.mk

##################################################################

# General content

Sources += todo.mkd agenda.mkd

Sources += $(wildcard *.dmu) $(wildcard *.txt) $(wildcard *.poll)

##################################################################

## Lecture rules

lect/%.fmt: ;
%.lect.fmt: lect/lect.format lect/fmt.pl
	$(PUSHSTAR)

.PRECIOUS: lect/lect.format lect/fmt.pl

## Using separate rules here; there's a divergence between lect.format and txt.format.
## Now developing 1M using txt.format
## Are there also two copies of fmt.pl??
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
structure.complete.pdf: structure.txt

## Poll questions framework

## Obsoleted by polleverywhere!
## Trim up to the first period or question mark that is followed by words
## Should really rewrite to read paragraphs, replace \n with \s.
%.pq: %.txt pq.pl
	$(PUSH)

# New version
# Not tested for MC yet!
%.poll.csv: %.txt pollcsv.pl
	$(PUSH)

%.pollclean: %.txt
	perl -pi -e "s|POLL.*?everywhere.com/|POLL |" $<

## Script for cutting things off to make partial notes
structure_prelim.txt: structure.txt prelim.pl
	$(PUSH)

structure_prelim.complete.pdf: structure.txt

##################################################################

# Unit 4 (Life history)

life_history.final.pdf: life_history.txt
life_history.draft.pdf: life_history.txt
life_history.handouts.pdf: life_history.txt
life_history.complete.pdf: life_history.txt
life_history.pq: life_history.txt

######################################################################

# Unit 5 (Competition)

competition.final.pdf: competition.txt
competition.draft.pdf: competition.txt
competition.complete.pdf: competition.txt
competition.handouts.pdf: competition.txt
competition.large.pdf: competition.txt
competition.pq: competition.txt
competition.pollclean: competition.txt

##################################################################

# Unit 6 (Exploitation)

exploitation.final.pdf: exploitation.txt
exploitation.draft.pdf: exploitation.txt
exploitation.handouts.pdf: exploitation.txt
exploitation.large.pdf: exploitation.txt
exploitation.complete.pdf: exploitation.txt
exploitation.pq: exploitation.txt

##################################################################

# Unit 7 (Disease)

disease.outline.pdf: disease.txt
disease.final.pdf: disease.txt
disease.draft.pdf: disease.txt
disease.handouts.pdf: disease.txt
disease.large.pdf: disease.txt
disease.poll.csv: disease.txt pollcsv.pl
disease.complete.pdf: disease.txt pollcsv.pl

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

######################################################################

# Look at test banks one at a time (use unit names)
## Change this rule to say "unit" -- distinguish from "bank" which is at the scale of a test

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
midterm1.bank: midterm1.formulas assign/linear.bank assign/nonlinear.bank assign/structure.bank
	$(cat)

%.bank.test: %.bank null.tmp bank.select.fmt talk/lect.pl
	$(PUSH)

midterm2.bank.key.pdf:
midterm2.bank: midterm2.formulas assign/linear.bank assign/nonlinear.bank assign/structure.bank assign/life_history.bank assign/comp.bank
	$(cat)

final.bank.key.pdf:
final.bank: final.formulas assign/linear.bank assign/nonlinear.bank assign/structure.bank assign/life_history.bank assign/comp.bank assign/pred.bank assign/disease.bank
	$(cat)

######################################################################

## Developing a test

final.test.pdf:

final.1.exam.pdf:

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

######################################################################

# Generic test; hasn't worked well for a while
# Don't try to view it
# In theory, it could be better to change some of these rules to avoid unnecessary rule clashes

# Select the short-answer part of a test
.PRECIOUS: %.sa
%.sa: %.short.test null.tmp %.select.fmt talk/lect.pl
	$(PUSH)

### Separator for MC and SA on the same test
Sources += end.dmu

### Combine mc and sa to make the real test
midterm2.6.test: midterm2.6.mc
	$(cat)

%.test: %.mc end.dmu %.ksa
	$(cat)

final.key.pdf:
final.test: final.mc
	$(copy)

######################################################################

midterm2.1.key.pdf: assign/structure.short

##### Versioning

## Now 5 versions: four for the main test, and one for others (SAS, late finals, ...)

Sources += $(wildcard *.pl) $(wildcard *.R)
# These rules need to be explicit, because of conflict with bank rules. A pain, but no easy fix.
midterm1.%.mc: midterm1.mc scramble.pl
	$(PUSHSTAR)

## Split SA questions by versions (based on slash-separated numbers)
## Do not scramble. This allows hacking at the clearpage stuff (kludge)
midterm1.%.sa: midterm1.sa testselect.pl
	$(PUSHSTAR)

midterm2.%.vsa: midterm2.sa testselect.pl
	$(PUSHSTAR)

## Convert versioned sa to rmd style
%.rsa: %.vsa lect/knit.fmt talk/lect.pl
	$(PUSH)

## and finally knit
%.ksa: %.rsa
	$(knit)

## http://printpal.mcmaster.ca/
## account # 206000301032330000

## Add cover pages and such
midterm1.%.exam.pdf: midterm.front.pdf midterm1.%.test.pdf
	$(pdfcat)

midterm2.%.exam.pdf: midterm.front.pdf midterm2.%.test.pdf
	$(pdfcat)

final.%.exam.pdf: final.front.pdf final.%.final.pdf
	$(pdfcat)

midterm2.1.mc: midterm2.mc scramble.pl

midterm2.%.mc: midterm2.mc scramble.pl
	$(PUSHSTAR)

midterm2.%.exam.pdf: midterm2.front.pdf midterm2.%.test.pdf
	$(pdfcat)

final.%.test: final.mc scramble.pl
	$(PUSHSTAR)

### Process a test into different outputs
%.test.tex: %.test test.tmp test.test.fmt talk/lect.pl
	$(PUSH)

final.2.final.pdf: final.tmp 

final.%.tmp: final.tmp examno.pl
	$(PUSHSTAR)

%.final.tex: %.test %.tmp test.test.fmt talk/lect.pl
	$(PUSH)

%.key.tex: %.test test.tmp key.test.fmt talk/lect.pl
	$(PUSH)

%.rub.tex: %.ksa test.tmp rub.test.fmt talk/lect.pl
	$(PUSH)

## Partial set of rubrics because of coding disaster
midterm1.prb.tgz: midterm1.1.rub.pdf midterm1.2.rub.pdf midterm1.3.rub.pdf midterm1.4.rub.pdf
	$(TGZ)

######################################################################

### Export rules

##### Test 1

## Printing
midterm1.zip: midterm1.1.exam.pdf midterm1.2.exam.pdf midterm1.3.exam.pdf midterm1.4.exam.pdf midterm1.5.exam.pdf
	$(ZIP)

## Pushing
midterm1.tests: midterm1.1.test.pdf.push midterm1.2.test.pdf.push midterm1.3.test.pdf.push midterm1.4.test.pdf.push midterm1.5.test.pdf.push 

midterm1.keys: midterm1.1.key.pdf.push midterm1.2.key.pdf.push midterm1.3.key.pdf.push midterm1.4.key.pdf.push midterm1.5.key.pdf.push

##### Test 2

midterm2.1.rub.pdf:

## Printing
midterm2.zip: midterm2.1.exam.pdf midterm2.2.exam.pdf midterm2.3.exam.pdf midterm2.4.exam.pdf midterm2.5.exam.pdf
	$(ZIP)

## Pushing (new style (below) is better for gx-ing)
midterm2.tests: midterm2.1.test.pdf.push midterm2.2.test.pdf.push midterm2.3.test.pdf.push midterm2.4.test.pdf.push midterm2.5.test.pdf.push

midterm2_keys = midterm2.1.key.pdf midterm2.2.key.pdf midterm2.3.key.pdf midterm2.4.key.pdf midterm2.5.key.pdf
midterm2.keys: $(midterm2_keys:%=%.push)

midterm2_rubs = midterm2.1.rub.pdf midterm2.2.rub.pdf midterm2.3.rub.pdf midterm2.4.rub.pdf midterm2.5.rub.pdf
midterm2.rub.zip: $(midterm2_rubs)
	$(ZIP)

final.zip: final.1.final.pdf final.2.final.pdf final.3.final.pdf final.4.final.pdf final.5.final.pdf
	$(ZIP)
	$(MAKE) final_dir
	-$(RM) final_dir/*.*
	$(CP) $@ final_dir
	cd final_dir && unzip $@
	cd final_dir && rename "s/final./Bio_3SS3_C01_V/; s/final.//" final*.pdf
	$(MAKE) final_dir.go

midterm2.rub.tgz: midterm2.1.rub.pdf midterm2.2.rub.pdf midterm2.3.rub.pdf midterm2.4.rub.pdf midterm2.5.rub.pdf
	$(TGZ)

final_dir:
	$(mkdir)

final_dir.update: final.zip final_dir 

######################################################################

# Substance (belongs elsewhere)

ebola_time = steps.R gamHist.R # Copied from academicWW

## This has absolutely nothing to do with nothing; it's about varying generation interval _shapes_!
gamHist.Rout: gamHist.R

generationTime.Rout: generationTime.R

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

## Brasero disk burner
midterm1.scantron.csv:
midterm2.scantron.csv:
final.scantron.csv:

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

final.%.order: final.skeleton scramble.pl
	$(PUSHSTAR)

midterm1.orders:
%.orders: %.1.order %.2.order %.3.order %.4.order %.5.order orders.pl
	$(PUSH)

## Student responses from scantron
%.responses.csv: assign/%.responses.csv
	perl -ne 'print if /^[0-9]{3}/' $< > $@

## Archive
assign/midterm2.scores.orig.csv:
	/bin/cp midterm2.scores.Rout.csv $@

## Compile scores
midterm2.scores.Rout.csv:
midterm2.scores.Rout: scores.R

# scores.R used to also merge with some TA grading sheet.
# Dysfunctional now, maybe refactor later
%.scores.Rout: %.responses.csv %.orders %.ssv scores.R
	$(run-R)

final.scores.Rout.csv: 
final.scores.Rout: scores.R



# newscores.R is not working yet; tries to merge in manually entered version numbers

######### Error correction
## Bonus files
midterm2.mortfix.bonus.Rout: midterm2.responses.csv midterm2.orders mortfix.ssv scores.R
midterm2.%.bonus.Rout: midterm2.responses.csv midterm2.orders %.ssv scores.R
	$(run-R)

## Combining
midterm2.fixed.Rout: midterm2.scores.Rout.csv midterm2.mortfix.bonus.Rout.csv midterm2.nonsense.bonus.Rout.csv addscores.R
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

## Intro (NFC)
intro.asn.pdf: assign/intro.ques

## Population growth
pg.asn.pdf: assign/pg.ques

## Intro R (NFC, lives on wiki)

## Regulation (uses some R, lives here, points to wiki)
regulation.asn.pdf: assign/regulation.ques
regulation.key.pdf: assign/regulation.ques
regulation.rub.pdf: assign/regulation.ques

## An allee question that has fallen between the cracks. Could be added to the previous or following assignment
## Previous assignment currently has a detailed Allee question, though.
allee.asn.pdf: assign/allee.ques

## Structure assignment
## Often given for credit
structure.asn.pdf: assign/structure.ques
structure.key.pdf: assign/structure.ques
structure.rub.pdf: assign/structure.ques

## Interaction is an old assignment, now broken up into a very short (life history) assignment and a slightly longer (competition) assignment
interaction.asn.pdf: assign/interaction.ques

competition.asn.pdf: assign/competition.ques
competition.key.pdf: assign/competition.ques

expl.asn.pdf: assign/expl.ques

######################################################################

## Transitioning to having knitr in the pipeline

## Pre-knit markup
%.ques: assign/%.ques lect/knit.fmt talk/lect.pl
	$(PUSH)

## Knit
knit = echo 'knitr::knit("$<", "$@")' | R --vanilla
%.qq: %.ques
	$(knit)

## Markup for different products
Sources += asn.tmp

%.ques.fmt: lect/ques.format lect/fmt.pl
	$(PUSHSTAR)

%.asn.tex: %.qq asn.tmp asn.ques.fmt talk/lect.pl
	$(PUSH)

%.old.asn.tex: assign/%.ques asn.tmp asn.ques.fmt talk/lect.pl
	$(PUSH)

%.key.tex: %.qq asn.tmp key.ques.fmt talk/lect.pl
	$(PUSH)

%.rub.tex: %.qq asn.tmp rub.ques.fmt talk/lect.pl
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

## Patching

talkdir = makestuff/newtalk/
talk:
	$(LN) $(talkdir) $@

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
-include $(ms)/newlatex.mk
-include $(ms)/lect.mk

