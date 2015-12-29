# Bio3SS_content
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: notarget

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk

##################################################################

## Outline

outline.course.pdf: outline.dmu

######################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
-include $(ms)/lect.mk
