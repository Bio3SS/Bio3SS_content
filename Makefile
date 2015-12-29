# Bio3SS_content
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: outline.pdf 

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
