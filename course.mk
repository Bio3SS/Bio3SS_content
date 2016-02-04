user = Bio3SS
repo = git@github.com
ms = makestuff/

clone:
	git clone $(repo):$(user)/$(target).git

Bio3SS = Bio3SS.github.io Bio3SS_content Population_time_series Lecture_images Exponential_figures Grading_scripts Assignments Birth_death_models Compensation_models Life_tables Age_distributions Structured_models

course: $(Bio3SS)

update_course: $(Bio3SS:%=%.sync)

$(Bio3SS):
	$(MAKE) target=$@ user=Bio3SS clone

$(Bio3SS:%=%.ssh): %.ssh:
	$(MAKE) name=$* user=Bio3SS ssh_set

theobio_group = Serodiscordance_Champredon_2013 DHS_downloads Condom_awareness generation_interval_moments Disease_data HIV_treatment_Africa Awareness_TMB

$(theobio_group):
	$(MAKE) target=$@ user=mac-theobio clone

outbreak_analysis = WA_Ebola_Outbreak OA_Planning Zika

$(outbreak_analysis):
	$(MAKE) target=$@ user=Outbreak-analysis clone

mli_github = Survival rdc
$(mli_github):
	$(MAKE) target=$@ user=mli2830 clone

worden_github = github-pages-sandbox 
$(worden_github):
	$(MAKE) target=$@ user=worden-lee clone

dushoff_bitbucket = talks nserc tutorial Vaccination_analysis TZ_pediatric_HIV zebra_movement Academic_CV Correspondence HIV_Project
$(dushoff_bitbucket):
	$(MAKE) repo=git@bitbucket.org target=$@ clone

walker_bitbucket = goaheadandrarefymicrobiomedata
$(walker_bitbucket):
	$(MAKE) repo=git@bitbucket.org user=scwalker target=$@ clone

bolker_github = microbiome_stats
$(bolker_github):
	$(MAKE) target=$@ user=bbolker clone

woodstkp_github = Woodstock-thesis
$(woodstkp_github):
	$(MAKE) target=$@ user=woodstkp clone

bellan_github = IDI-cumulative-VL-project
$(bellan_github):
	$(MAKE) target=$@ user=sbellan61 clone

fishforwish = fgc
$(fishforwish): 
	$(MAKE) target=$@ user=fishforwish clone

ici3d_github = Malaria ICI3D.github.io DAIDD2015 DAIDDparticipants
$(ici3d_github):
	$(MAKE) target=$@ user=ICI3D clone

elia_github = Sequels
$(elia_github):
	$(MAKE) target=$@ user=artofelia clone

######################################################################

# Syncing

%.push:
	cd $* && $(MAKE) push

%.pull: %
	cd $* && $(MAKE) pull

%.sync: %
	cd $* && $(MAKE) sync

%.testdir: %
	cd $* && $(MAKE) testdir

%/local.mk:
	touch $@
	-cp local/local.mk $@

%/stuff.mk:
	-cp $(ms)/stuff.mk $@

%/Makefile:
	echo "# $*" > $@
	cat $(ms)/hooks.mk >> $@
	cat $(ms)/makefile.mk >> $@
	cd $* && $(MAKE) Makefile

%.newpush:
	cd $* && $(MAKE) newpush
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

