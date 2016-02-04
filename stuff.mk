
msrepo = https://github.com/dushoff
courserepo = https://github.com/Bio3SS

gitroot = ./gitroot
Drop = $(gitroot)/Drop
export ms = $(gitroot)/makestuff

web = $(gitroot)/Bio3SS.github.io/materials/

-include local.mk
-include $(gitroot)/local.mk

export ms = $(gitroot)/makestuff
images = $(Drop)/Lecture_images

Makefile: $(ms) $(images) $(dirs)
$(ms):
	$(MAKE) -f stuff.mk $(gitroot)
	cd $(gitroot) && git clone $(msrepo)/$(notdir $(ms)).git

$(dirs): 
	$(MAKE) -f stuff.mk $(gitroot)
	cd $(gitroot) && git clone $(courserepo)/$(notdir $@).git

$(images): 
	$(MAKE) -f stuff.mk $(gitroot)
	-mkdir $(dir $(images))
	mkdir $@

$(gitroot):
	mkdir $@

