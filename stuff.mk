
newdir:

msrepo = https://github.com/dushoff
gitroot = ./
Drop = ~/Dropbox/courses
export ms = $(gitroot)/makestuff

$(ms):
	cd $(dir $(ms)) && git clone $(msrepo)/$(notdir $(ms)).git

web = $(gitroot)/Bio3SS.github.io/materials/

-include local.mk
-include $(gitroot)/local.mk
export ms = $(gitroot)/makestuff

Makefile: $(ms)
$(ms):
	cd $(dir $(ms)) && git clone $(msrepo)/$(notdir $(ms)).git
images = $(Drop)/Lecture_images
