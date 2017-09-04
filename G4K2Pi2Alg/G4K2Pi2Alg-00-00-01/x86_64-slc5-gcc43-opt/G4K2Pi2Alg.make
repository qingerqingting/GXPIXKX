#-- start of make_header -----------------

#====================================
#  Library G4K2Pi2Alg
#
#   Generated Sat Apr 16 00:03:36 2016  by lvxd
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_G4K2Pi2Alg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_G4K2Pi2Alg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_G4K2Pi2Alg

G4K2Pi2Alg_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_G4K2Pi2Alg = /tmp/CMT_$(G4K2Pi2Alg_tag)_G4K2Pi2Alg.make$(cmt_lock_pid)
else
#cmt_local_tagfile_G4K2Pi2Alg = $(G4K2Pi2Alg_tag)_G4K2Pi2Alg.make
cmt_local_tagfile_G4K2Pi2Alg = $(bin)$(G4K2Pi2Alg_tag)_G4K2Pi2Alg.make
endif

else

tags      = $(tag),$(CMTEXTRATAGS)

G4K2Pi2Alg_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_G4K2Pi2Alg = /tmp/CMT_$(G4K2Pi2Alg_tag).make$(cmt_lock_pid)
else
#cmt_local_tagfile_G4K2Pi2Alg = $(G4K2Pi2Alg_tag).make
cmt_local_tagfile_G4K2Pi2Alg = $(bin)$(G4K2Pi2Alg_tag).make
endif

endif

-include $(cmt_local_tagfile_G4K2Pi2Alg)

ifdef cmt_G4K2Pi2Alg_has_target_tag

ifdef READONLY
cmt_final_setup_G4K2Pi2Alg = /tmp/CMT_G4K2Pi2Alg_G4K2Pi2Algsetup.make
cmt_local_G4K2Pi2Alg_makefile = /tmp/CMT_G4K2Pi2Alg$(cmt_lock_pid).make
else
cmt_final_setup_G4K2Pi2Alg = $(bin)G4K2Pi2Alg_G4K2Pi2Algsetup.make
cmt_local_G4K2Pi2Alg_makefile = $(bin)G4K2Pi2Alg.make
endif

else

ifdef READONLY
cmt_final_setup_G4K2Pi2Alg = /tmp/CMT_G4K2Pi2Algsetup.make
cmt_local_G4K2Pi2Alg_makefile = /tmp/CMT_G4K2Pi2Alg$(cmt_lock_pid).make
else
cmt_final_setup_G4K2Pi2Alg = $(bin)G4K2Pi2Algsetup.make
cmt_local_G4K2Pi2Alg_makefile = $(bin)G4K2Pi2Alg.make
endif

endif

ifdef READONLY
cmt_final_setup = /tmp/CMT_G4K2Pi2Algsetup.make
else
cmt_final_setup = $(bin)G4K2Pi2Algsetup.make
endif

G4K2Pi2Alg ::


ifdef READONLY
G4K2Pi2Alg ::
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
	$(echo) 'G4K2Pi2Alg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = G4K2Pi2Alg/
G4K2Pi2Alg::
	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

#-- end of make_header ------------------

#-- start of libary_header ---------------

G4K2Pi2Alglibname   = $(bin)$(library_prefix)G4K2Pi2Alg$(library_suffix)
G4K2Pi2Alglib       = $(G4K2Pi2Alglibname).a
G4K2Pi2Algstamp     = $(bin)G4K2Pi2Alg.stamp
G4K2Pi2Algshstamp   = $(bin)G4K2Pi2Alg.shstamp

G4K2Pi2Alg :: dirs  G4K2Pi2AlgLIB
	$(echo) "G4K2Pi2Alg ok"

#-- end of libary_header ----------------

G4K2Pi2AlgLIB :: $(G4K2Pi2Alglib) $(G4K2Pi2Algshstamp)
	@/bin/echo "------> G4K2Pi2Alg : library ok"

$(G4K2Pi2Alglib) :: $(bin)G4K2Pi2.o $(bin)G4K2Pi2_load.o $(bin)G4K2Pi2_entries.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(G4K2Pi2Alglib) $?
	$(lib_silent) $(ranlib) $(G4K2Pi2Alglib)
	$(lib_silent) cat /dev/null >$(G4K2Pi2Algstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(G4K2Pi2Alglibname).$(shlibsuffix) :: $(G4K2Pi2Alglib) $(G4K2Pi2Algstamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" G4K2Pi2Alg $(G4K2Pi2Alg_shlibflags)

$(G4K2Pi2Algshstamp) :: $(G4K2Pi2Alglibname).$(shlibsuffix)
	@if test -f $(G4K2Pi2Alglibname).$(shlibsuffix) ; then cat /dev/null >$(G4K2Pi2Algshstamp) ; fi

G4K2Pi2Algclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)G4K2Pi2.o $(bin)G4K2Pi2_load.o $(bin)G4K2Pi2_entries.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

ifeq ($(INSTALLAREA),)
installarea = $(CMTINSTALLAREA)
else
ifeq ($(findstring `,$(INSTALLAREA)),`)
installarea = $(shell $(subst `,, $(INSTALLAREA)))
else
installarea = $(INSTALLAREA)
endif
endif

install_dir = ${installarea}/${CMTCONFIG}/lib
G4K2Pi2Alginstallname = $(library_prefix)G4K2Pi2Alg$(library_suffix).$(shlibsuffix)

G4K2Pi2Alg :: G4K2Pi2Alginstall

install :: G4K2Pi2Alginstall

G4K2Pi2Alginstall :: $(install_dir)/$(G4K2Pi2Alginstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(G4K2Pi2Alginstallname) :: $(bin)$(G4K2Pi2Alginstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(G4K2Pi2Alginstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(G4K2Pi2Alginstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(G4K2Pi2Alginstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(G4K2Pi2Alginstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(G4K2Pi2Alginstallname) $(install_dir)/$(G4K2Pi2Alginstallname); \
	      echo `pwd`/$(G4K2Pi2Alginstallname) >$(install_dir)/$(G4K2Pi2Alginstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(G4K2Pi2Alginstallname), no installation directory specified"; \
	  fi; \
	fi

G4K2Pi2Algclean :: G4K2Pi2Alguninstall

uninstall :: G4K2Pi2Alguninstall

G4K2Pi2Alguninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(G4K2Pi2Alginstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(G4K2Pi2Alginstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(G4K2Pi2Alginstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(G4K2Pi2Alginstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),G4K2Pi2Algclean)

#$(bin)G4K2Pi2Alg_dependencies.make :: dirs

ifndef QUICK
$(bin)G4K2Pi2Alg_dependencies.make : ../src/G4K2Pi2.cxx ../src/components/G4K2Pi2_load.cxx ../src/components/G4K2Pi2_entries.cxx $(use_requirements) $(cmt_final_setup_G4K2Pi2Alg)
	$(echo) "(G4K2Pi2Alg.make) Rebuilding $@"; \
	  $(build_dependencies) G4K2Pi2Alg -all_sources -out=$@ ../src/G4K2Pi2.cxx ../src/components/G4K2Pi2_load.cxx ../src/components/G4K2Pi2_entries.cxx
endif

#$(G4K2Pi2Alg_dependencies)

-include $(bin)G4K2Pi2Alg_dependencies.make

endif
#-- end of dependency -------------------
#-- start of cpp_library -----------------

$(bin)G4K2Pi2Alg_dependencies.make : $(G4K2Pi2_cxx_dependencies)

$(bin)$(binobj)G4K2Pi2.o : $(G4K2Pi2_cxx_dependencies)
	$(cpp_echo) $(src)G4K2Pi2.cxx
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(G4K2Pi2Alg_pp_cppflags) $(lib_G4K2Pi2Alg_pp_cppflags) $(G4K2Pi2_pp_cppflags) $(use_cppflags) $(G4K2Pi2Alg_cppflags) $(lib_G4K2Pi2Alg_cppflags) $(G4K2Pi2_cppflags) $(G4K2Pi2_cxx_cppflags)  $(src)G4K2Pi2.cxx

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

$(bin)G4K2Pi2Alg_dependencies.make : $(G4K2Pi2_load_cxx_dependencies)

$(bin)$(binobj)G4K2Pi2_load.o : $(G4K2Pi2_load_cxx_dependencies)
	$(cpp_echo) $(src)components/G4K2Pi2_load.cxx
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(G4K2Pi2Alg_pp_cppflags) $(lib_G4K2Pi2Alg_pp_cppflags) $(G4K2Pi2_load_pp_cppflags) $(use_cppflags) $(G4K2Pi2Alg_cppflags) $(lib_G4K2Pi2Alg_cppflags) $(G4K2Pi2_load_cppflags) $(G4K2Pi2_load_cxx_cppflags) -I../src/components $(src)components/G4K2Pi2_load.cxx

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

$(bin)G4K2Pi2Alg_dependencies.make : $(G4K2Pi2_entries_cxx_dependencies)

$(bin)$(binobj)G4K2Pi2_entries.o : $(G4K2Pi2_entries_cxx_dependencies)
	$(cpp_echo) $(src)components/G4K2Pi2_entries.cxx
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(G4K2Pi2Alg_pp_cppflags) $(lib_G4K2Pi2Alg_pp_cppflags) $(G4K2Pi2_entries_pp_cppflags) $(use_cppflags) $(G4K2Pi2Alg_cppflags) $(lib_G4K2Pi2Alg_cppflags) $(G4K2Pi2_entries_cppflags) $(G4K2Pi2_entries_cxx_cppflags) -I../src/components $(src)components/G4K2Pi2_entries.cxx

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: G4K2Pi2Algclean
	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(G4K2Pi2Alg.make) $@: No rule for such target" >&2
#	@echo "#CMT> Warning: $@: No rule for such target" >&2; exit
else
.DEFAULT::
	$(echo) "(G4K2Pi2Alg.make) PEDANTIC: $@: No rule for such target" >&2
	if test $@ = "$(cmt_final_setup)" -o\
	 $@ = "$(cmt_final_setup_G4K2Pi2Alg)" ; then\
	 found=n; for s in 1 2 3 4 5; do\
	 sleep $$s; test ! -f $@ || { found=y; break; }\
	 done; if test $$found = n; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(G4K2Pi2Alg.make) PEDANTIC: $@: Seems to be missing. Ignore it for now" >&2; exit 0 ; fi;\
	 elif test `expr index $@ '/'` -ne 0 ; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(G4K2Pi2Alg.make) PEDANTIC: $@: Seems to be a missing file. Please check" >&2; exit 2 ; \
	 else\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(G4K2Pi2Alg.make) PEDANTIC: $@: Seems to be a fake target due to some pattern. Just ignore it" >&2 ; exit 0; fi
endif

G4K2Pi2Algclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(binobj)$(library_prefix)G4K2Pi2Alg$(library_suffix).a $(binobj)$(library_prefix)G4K2Pi2Alg$(library_suffix).s? $(binobj)G4K2Pi2Alg.stamp $(binobj)G4K2Pi2Alg.shstamp
#-- end of cleanup_library ---------------

