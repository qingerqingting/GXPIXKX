#-- start of make_header -----------------

#====================================
#  Document config
#
#   Generated Sat Apr 16 00:03:34 2016  by lvxd
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_config_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_config_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_config

G4K2Pi2Alg_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_config = /tmp/CMT_$(G4K2Pi2Alg_tag)_config.make$(cmt_lock_pid)
else
#cmt_local_tagfile_config = $(G4K2Pi2Alg_tag)_config.make
cmt_local_tagfile_config = $(bin)$(G4K2Pi2Alg_tag)_config.make
endif

else

tags      = $(tag),$(CMTEXTRATAGS)

G4K2Pi2Alg_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_config = /tmp/CMT_$(G4K2Pi2Alg_tag).make$(cmt_lock_pid)
else
#cmt_local_tagfile_config = $(G4K2Pi2Alg_tag).make
cmt_local_tagfile_config = $(bin)$(G4K2Pi2Alg_tag).make
endif

endif

-include $(cmt_local_tagfile_config)

ifdef cmt_config_has_target_tag

ifdef READONLY
cmt_final_setup_config = /tmp/CMT_G4K2Pi2Alg_configsetup.make
cmt_local_config_makefile = /tmp/CMT_config$(cmt_lock_pid).make
else
cmt_final_setup_config = $(bin)G4K2Pi2Alg_configsetup.make
cmt_local_config_makefile = $(bin)config.make
endif

else

ifdef READONLY
cmt_final_setup_config = /tmp/CMT_G4K2Pi2Algsetup.make
cmt_local_config_makefile = /tmp/CMT_config$(cmt_lock_pid).make
else
cmt_final_setup_config = $(bin)G4K2Pi2Algsetup.make
cmt_local_config_makefile = $(bin)config.make
endif

endif

ifdef READONLY
cmt_final_setup = /tmp/CMT_G4K2Pi2Algsetup.make
else
cmt_final_setup = $(bin)G4K2Pi2Algsetup.make
endif

config ::


ifdef READONLY
config ::
	@echo tags=$(tags)
	@echo cmt_local_tagfile=$(cmt_local_tagfile)
endif


dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'config'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = config/
config::
	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

#-- end of make_header ------------------


config :: ../G4K2Pi2Alg/config.h
	@/bin/echo "------> config.h ok"

../G4K2Pi2Alg/config.h :: ../G4K2Pi2Alg/config.h.in
	@if test -f ../G4K2Pi2Alg/config.h.in; then \
	  cd ../G4K2Pi2Alg; \
	  $(config_command) config.h.in config.h; \
        fi


#-- start of cleanup_header --------------

clean :: configclean
	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(config.make) $@: No rule for such target" >&2
#	@echo "#CMT> Warning: $@: No rule for such target" >&2; exit
else
.DEFAULT::
	$(echo) "(config.make) PEDANTIC: $@: No rule for such target" >&2
	if test $@ = "$(cmt_final_setup)" -o\
	 $@ = "$(cmt_final_setup_config)" ; then\
	 found=n; for s in 1 2 3 4 5; do\
	 sleep $$s; test ! -f $@ || { found=y; break; }\
	 done; if test $$found = n; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(config.make) PEDANTIC: $@: Seems to be missing. Ignore it for now" >&2; exit 0 ; fi;\
	 elif test `expr index $@ '/'` -ne 0 ; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(config.make) PEDANTIC: $@: Seems to be a missing file. Please check" >&2; exit 2 ; \
	 else\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(config.make) PEDANTIC: $@: Seems to be a fake target due to some pattern. Just ignore it" >&2 ; exit 0; fi
endif

configclean ::
#-- end of cleanup_header ---------------
