%.makestuff:
	-cd $(dir $(ms)) && mv -f $(notdir $(ms)) .$(notdir $(ms))
	cd $(dir $(ms)) && git clone $(msrepo)/$(notdir $(ms)).git
	-cd $(dir $(ms)) && rm -rf .$(notdir $(ms))
	touch $@

msrepo = https://github.com/dushoff
gitroot = ./
Drop = ~/Dropbox/courses
export ms = $(gitroot)/makestuff
web = $(gitroot)/Bio3SS.github.io/materials/

-include local.mk
-include $(gitroot)/local.mk
export ms = $(gitroot)/makestuff

Makefile: $(ms)
$(ms):
	cd $(dir $(ms)) && git clone $(msrepo)/$(notdir $(ms)).git
images = $(Drop)/Lecture_images
