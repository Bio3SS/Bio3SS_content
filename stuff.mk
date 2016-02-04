
msrepo = https://github.com/dushoff
courserepo = https://github.com/Bio3SS

gitroot = ./gitroot
Drop = ~/Dropbox/courses
export ms = $(gitroot)/makestuff

web = $(gitroot)/Bio3SS.github.io/materials/

-include local.mk
-include $(gitroot)/local.mk
export ms = $(gitroot)/makestuff
images = $(Drop)/Lecture_images
dirs = $(gitroot)/Population_time_series $(gitroot)/Exponential_figures $(gitroot)/Birth_death_models $(gitroot)/Compensation_models $(gitroot)/Life_tables $(gitroot)/Age_distributions $(gitroot)/Structured_models

Makefile: $(ms) $(images) $(dirs)
$(ms): $(dir $(ms))
	cd $(dir $(ms)) && git clone $(msrepo)/$(notdir $(ms)).git
$(dir $(ms)):
	mkdir $@

$(images): $(dir $(images))
	mkdir $@
$(dir $(images)):
	mkdir $@

