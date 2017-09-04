#-- start of make_header -----------------

#====================================
#  Document G4K2Pi2Alg_check_install_runtime
#
#   Generated Sat Apr 16 00:03:48 2016  by lvxd
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_G4K2Pi2Alg_check_install_runtime_has_target_tag = 1

#--------------------------------------------------------

ifdef cmt_G4K2Pi2Alg_check_install_runtime_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_G4K2Pi2Alg_check_install_runtime

G4K2Pi2Alg_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_G4K2Pi2Alg_check_install_runtime = /tmp/CMT_$(G4K2Pi2Alg_tag)_G4K2Pi2Alg_check_install_runtime.make$(cmt_lock_pid)
else
#cmt_local_tagfile_G4K2Pi2Alg_check_install_runtime = $(G4K2Pi2Alg_tag)_G4K2Pi2Alg_check_install_runtime.make
cmt_local_tagfile_G4K2Pi2Alg_check_install_runtime = $(bin)$(G4K2Pi2Alg_tag)_G4K2Pi2Alg_check_install_runtime.make
endif

else

tags      = $(tag),$(CMTEXTRATAGS)

G4K2Pi2Alg_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_G4K2Pi2Alg_check_install_runtime = /tmp/CMT_$(G4K2Pi2Alg_tag).make$(cmt_lock_pid)
else
#cmt_local_tagfile_G4K2Pi2Alg_check_install_runtime = $(G4K2Pi2Alg_tag).make
cmt_local_tagfile_G4K2Pi2Alg_check_install_runtime = $(bin)$(G4K2Pi2Alg_tag).make
endif

endif

-include $(cmt_local_tagfile_G4K2Pi2Alg_check_install_runtime)

ifdef cmt_G4K2Pi2Alg_check_install_runtime_has_target_tag

ifdef READONLY
cmt_final_setup_G4K2Pi2Alg_check_install_runtime = /tmp/CMT_G4K2Pi2Alg_G4K2Pi2Alg_check_install_runtimesetup.make
cmt_local_G4K2Pi2Alg_check_install_runtime_makefile = /tmp/CMT_G4K2Pi2Alg_check_install_runtime$(cmt_lock_pid).make
else
cmt_final_setup_G4K2Pi2Alg_check_install_runtime = $(bin)G4K2Pi2Alg_G4K2Pi2Alg_check_install_runtimesetup.make
cmt_local_G4K2Pi2Alg_check_install_runtime_makefile = $(bin)G4K2Pi2Alg_check_install_runtime.make
endif

else

ifdef READONLY
cmt_final_setup_G4K2Pi2Alg_check_install_runtime = /tmp/CMT_G4K2Pi2Algsetup.make
cmt_local_G4K2Pi2Alg_check_install_runtime_makefile = /tmp/CMT_G4K2Pi2Alg_check_install_runtime$(cmt_lock_pid).make
else
cmt_final_setup_G4K2Pi2Alg_check_install_runtime = $(bin)G4K2Pi2Algsetup.make
cmt_local_G4K2Pi2Alg_check_install_runtime_makefile = $(bin)G4K2Pi2Alg_check_install_runtime.make
endif

endif

ifdef READONLY
cmt_final_setup = /tmp/CMT_G4K2Pi2Algsetup.make
else
cmt_final_setup = $(bin)G4K2Pi2Algsetup.make
endif

G4K2Pi2Alg_check_install_runtime ::


ifdef READONLY
G4K2Pi2Alg_check_install_runtime ::
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
	$(echo) 'G4K2Pi2Alg_check_install_runtime'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = G4K2Pi2Alg_check_install_runtime/
G4K2Pi2Alg_check_install_runtime::
	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

#-- end of make_header ------------------

#-- start of cmt_action_runner_header ---------------

ifdef ONCE
G4K2Pi2Alg_check_install_runtime_once = 1
endif

ifdef G4K2Pi2Alg_check_install_runtime_once

G4K2Pi2Alg_check_install_runtimeactionstamp = G4K2Pi2Alg_check_install_runtime.actionstamp

G4K2Pi2Alg_check_install_runtime :: $(G4K2Pi2Alg_check_install_runtimeactionstamp)
	@echo G4K2Pi2Alg_check_install_runtime ok

$(G4K2Pi2Alg_check_install_runtimeactionstamp) :: $(G4K2Pi2Alg_check_install_runtime_dependencies)
	$(silent) /afs/ihep.ac.cn/bes3/offline/Boss/6.6.4/BesPolicy/BesPolicy-01-05-03/cmt/bes_check_installations.sh -files= -s=../share *.txt   -installdir=/besfs/users/lvxd/workarea/InstallArea/share
	@echo ok > $(G4K2Pi2Alg_check_install_runtimeactionstamp)

G4K2Pi2Alg_check_install_runtimeclean ::
	@/bin/rm -f $(G4K2Pi2Alg_check_install_runtimeactionstamp)

else

G4K2Pi2Alg_check_install_runtime :: $(G4K2Pi2Alg_check_install_runtime_dependencies)
	$(silent) /afs/ihep.ac.cn/bes3/offline/Boss/6.6.4/BesPolicy/BesPolicy-01-05-03/cmt/bes_check_installations.sh -files= -s=../share *.txt   -installdir=/besfs/users/lvxd/workarea/InstallArea/share

endif

install ::
uninstall ::

#-- end of cmt_action_runner_header -----------------
#-- start of cleanup_header --------------

clean :: G4K2Pi2Alg_check_install_runtimeclean
	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(G4K2Pi2Alg_check_install_runtime.make) $@: No rule for such target" >&2
#	@echo "#CMT> Warning: $@: No rule for such target" >&2; exit
else
.DEFAULT::
	$(echo) "(G4K2Pi2Alg_check_install_runtime.make) PEDANTIC: $@: No rule for such target" >&2
	if test $@ = "$(cmt_final_setup)" -o\
	 $@ = "$(cmt_final_setup_G4K2Pi2Alg_check_install_runtime)" ; then\
	 found=n; for s in 1 2 3 4 5; do\
	 sleep $$s; test ! -f $@ || { found=y; break; }\
	 done; if test $$found = n; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(G4K2Pi2Alg_check_install_runtime.make) PEDANTIC: $@: Seems to be missing. Ignore it for now" >&2; exit 0 ; fi;\
	 elif test `expr index $@ '/'` -ne 0 ; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(G4K2Pi2Alg_check_install_runtime.make) PEDANTIC: $@: Seems to be a missing file. Please check" >&2; exit 2 ; \
	 else\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(G4K2Pi2Alg_check_install_runtime.make) PEDANTIC: $@: Seems to be a fake target due to some pattern. Just ignore it" >&2 ; exit 0; fi
endif

G4K2Pi2Alg_check_install_runtimeclean ::
#-- end of cleanup_header ---------------
