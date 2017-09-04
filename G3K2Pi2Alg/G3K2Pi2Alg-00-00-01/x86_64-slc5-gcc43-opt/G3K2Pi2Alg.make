#-- start of make_header -----------------

#====================================
#  Library G3K2Pi2Alg
#
#   Generated Sat Apr 16 00:03:05 2016  by lvxd
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_G3K2Pi2Alg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_G3K2Pi2Alg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_G3K2Pi2Alg

G3K2Pi2Alg_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_G3K2Pi2Alg = /tmp/CMT_$(G3K2Pi2Alg_tag)_G3K2Pi2Alg.make$(cmt_lock_pid)
else
#cmt_local_tagfile_G3K2Pi2Alg = $(G3K2Pi2Alg_tag)_G3K2Pi2Alg.make
cmt_local_tagfile_G3K2Pi2Alg = $(bin)$(G3K2Pi2Alg_tag)_G3K2Pi2Alg.make
endif

else

tags      = $(tag),$(CMTEXTRATAGS)

G3K2Pi2Alg_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_G3K2Pi2Alg = /tmp/CMT_$(G3K2Pi2Alg_tag).make$(cmt_lock_pid)
else
#cmt_local_tagfile_G3K2Pi2Alg = $(G3K2Pi2Alg_tag).make
cmt_local_tagfile_G3K2Pi2Alg = $(bin)$(G3K2Pi2Alg_tag).make
endif

endif

-include $(cmt_local_tagfile_G3K2Pi2Alg)

ifdef cmt_G3K2Pi2Alg_has_target_tag

ifdef READONLY
cmt_final_setup_G3K2Pi2Alg = /tmp/CMT_G3K2Pi2Alg_G3K2Pi2Algsetup.make
cmt_local_G3K2Pi2Alg_makefile = /tmp/CMT_G3K2Pi2Alg$(cmt_lock_pid).make
else
cmt_final_setup_G3K2Pi2Alg = $(bin)G3K2Pi2Alg_G3K2Pi2Algsetup.make
cmt_local_G3K2Pi2Alg_makefile = $(bin)G3K2Pi2Alg.make
endif

else

ifdef READONLY
cmt_final_setup_G3K2Pi2Alg = /tmp/CMT_G3K2Pi2Algsetup.make
cmt_local_G3K2Pi2Alg_makefile = /tmp/CMT_G3K2Pi2Alg$(cmt_lock_pid).make
else
cmt_final_setup_G3K2Pi2Alg = $(bin)G3K2Pi2Algsetup.make
cmt_local_G3K2Pi2Alg_makefile = $(bin)G3K2Pi2Alg.make
endif

endif

ifdef READONLY
cmt_final_setup = /tmp/CMT_G3K2Pi2Algsetup.make
else
cmt_final_setup = $(bin)G3K2Pi2Algsetup.make
endif

G3K2Pi2Alg ::


ifdef READONLY
G3K2Pi2Alg ::
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
	$(echo) 'G3K2Pi2Alg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = G3K2Pi2Alg/
G3K2Pi2Alg::
	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

#-- end of make_header ------------------

#-- start of libary_header ---------------

G3K2Pi2Alglibname   = $(bin)$(library_prefix)G3K2Pi2Alg$(library_suffix)
G3K2Pi2Alglib       = $(G3K2Pi2Alglibname).a
G3K2Pi2Algstamp     = $(bin)G3K2Pi2Alg.stamp
G3K2Pi2Algshstamp   = $(bin)G3K2Pi2Alg.shstamp

G3K2Pi2Alg :: dirs  G3K2Pi2AlgLIB
	$(echo) "G3K2Pi2Alg ok"

#-- end of libary_header ----------------

G3K2Pi2AlgLIB :: $(G3K2Pi2Alglib) $(G3K2Pi2Algshstamp)
	@/bin/echo "------> G3K2Pi2Alg : library ok"

$(G3K2Pi2Alglib) :: $(bin)G3K2Pi2.o $(bin)G3K2Pi2_entries.o $(bin)G3K2Pi2_load.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(G3K2Pi2Alglib) $?
	$(lib_silent) $(ranlib) $(G3K2Pi2Alglib)
	$(lib_silent) cat /dev/null >$(G3K2Pi2Algstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(G3K2Pi2Alglibname).$(shlibsuffix) :: $(G3K2Pi2Alglib) $(G3K2Pi2Algstamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" G3K2Pi2Alg $(G3K2Pi2Alg_shlibflags)

$(G3K2Pi2Algshstamp) :: $(G3K2Pi2Alglibname).$(shlibsuffix)
	@if test -f $(G3K2Pi2Alglibname).$(shlibsuffix) ; then cat /dev/null >$(G3K2Pi2Algshstamp) ; fi

G3K2Pi2Algclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)G3K2Pi2.o $(bin)G3K2Pi2_entries.o $(bin)G3K2Pi2_load.o

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
G3K2Pi2Alginstallname = $(library_prefix)G3K2Pi2Alg$(library_suffix).$(shlibsuffix)

G3K2Pi2Alg :: G3K2Pi2Alginstall

install :: G3K2Pi2Alginstall

G3K2Pi2Alginstall :: $(install_dir)/$(G3K2Pi2Alginstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(G3K2Pi2Alginstallname) :: $(bin)$(G3K2Pi2Alginstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(G3K2Pi2Alginstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(G3K2Pi2Alginstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(G3K2Pi2Alginstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(G3K2Pi2Alginstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(G3K2Pi2Alginstallname) $(install_dir)/$(G3K2Pi2Alginstallname); \
	      echo `pwd`/$(G3K2Pi2Alginstallname) >$(install_dir)/$(G3K2Pi2Alginstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(G3K2Pi2Alginstallname), no installation directory specified"; \
	  fi; \
	fi

G3K2Pi2Algclean :: G3K2Pi2Alguninstall

uninstall :: G3K2Pi2Alguninstall

G3K2Pi2Alguninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(G3K2Pi2Alginstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(G3K2Pi2Alginstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(G3K2Pi2Alginstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(G3K2Pi2Alginstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),G3K2Pi2Algclean)

#$(bin)G3K2Pi2Alg_dependencies.make :: dirs

ifndef QUICK
$(bin)G3K2Pi2Alg_dependencies.make : ../src/G3K2Pi2.cxx ../src/components/G3K2Pi2_entries.cxx ../src/components/G3K2Pi2_load.cxx $(use_requirements) $(cmt_final_setup_G3K2Pi2Alg)
	$(echo) "(G3K2Pi2Alg.make) Rebuilding $@"; \
	  $(build_dependencies) G3K2Pi2Alg -all_sources -out=$@ ../src/G3K2Pi2.cxx ../src/components/G3K2Pi2_entries.cxx ../src/components/G3K2Pi2_load.cxx
endif

#$(G3K2Pi2Alg_dependencies)

-include $(bin)G3K2Pi2Alg_dependencies.make

endif
#-- end of dependency -------------------
#-- start of cpp_library -----------------

$(bin)G3K2Pi2Alg_dependencies.make : $(G3K2Pi2_cxx_dependencies)

$(bin)$(binobj)G3K2Pi2.o : $(G3K2Pi2_cxx_dependencies)
	$(cpp_echo) $(src)G3K2Pi2.cxx
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(G3K2Pi2Alg_pp_cppflags) $(lib_G3K2Pi2Alg_pp_cppflags) $(G3K2Pi2_pp_cppflags) $(use_cppflags) $(G3K2Pi2Alg_cppflags) $(lib_G3K2Pi2Alg_cppflags) $(G3K2Pi2_cppflags) $(G3K2Pi2_cxx_cppflags)  $(src)G3K2Pi2.cxx

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

$(bin)G3K2Pi2Alg_dependencies.make : $(G3K2Pi2_entries_cxx_dependencies)

$(bin)$(binobj)G3K2Pi2_entries.o : $(G3K2Pi2_entries_cxx_dependencies)
	$(cpp_echo) $(src)components/G3K2Pi2_entries.cxx
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(G3K2Pi2Alg_pp_cppflags) $(lib_G3K2Pi2Alg_pp_cppflags) $(G3K2Pi2_entries_pp_cppflags) $(use_cppflags) $(G3K2Pi2Alg_cppflags) $(lib_G3K2Pi2Alg_cppflags) $(G3K2Pi2_entries_cppflags) $(G3K2Pi2_entries_cxx_cppflags) -I../src/components $(src)components/G3K2Pi2_entries.cxx

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

$(bin)G3K2Pi2Alg_dependencies.make : $(G3K2Pi2_load_cxx_dependencies)

$(bin)$(binobj)G3K2Pi2_load.o : $(G3K2Pi2_load_cxx_dependencies)
	$(cpp_echo) $(src)components/G3K2Pi2_load.cxx
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(G3K2Pi2Alg_pp_cppflags) $(lib_G3K2Pi2Alg_pp_cppflags) $(G3K2Pi2_load_pp_cppflags) $(use_cppflags) $(G3K2Pi2Alg_cppflags) $(lib_G3K2Pi2Alg_cppflags) $(G3K2Pi2_load_cppflags) $(G3K2Pi2_load_cxx_cppflags) -I../src/components $(src)components/G3K2Pi2_load.cxx

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: G3K2Pi2Algclean
	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(G3K2Pi2Alg.make) $@: No rule for such target" >&2
#	@echo "#CMT> Warning: $@: No rule for such target" >&2; exit
else
.DEFAULT::
	$(echo) "(G3K2Pi2Alg.make) PEDANTIC: $@: No rule for such target" >&2
	if test $@ = "$(cmt_final_setup)" -o\
	 $@ = "$(cmt_final_setup_G3K2Pi2Alg)" ; then\
	 found=n; for s in 1 2 3 4 5; do\
	 sleep $$s; test ! -f $@ || { found=y; break; }\
	 done; if test $$found = n; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(G3K2Pi2Alg.make) PEDANTIC: $@: Seems to be missing. Ignore it for now" >&2; exit 0 ; fi;\
	 elif test `expr index $@ '/'` -ne 0 ; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(G3K2Pi2Alg.make) PEDANTIC: $@: Seems to be a missing file. Please check" >&2; exit 2 ; \
	 else\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(G3K2Pi2Alg.make) PEDANTIC: $@: Seems to be a fake target due to some pattern. Just ignore it" >&2 ; exit 0; fi
endif

G3K2Pi2Algclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(binobj)$(library_prefix)G3K2Pi2Alg$(library_suffix).a $(binobj)$(library_prefix)G3K2Pi2Alg$(library_suffix).s? $(binobj)G3K2Pi2Alg.stamp $(binobj)G3K2Pi2Alg.shstamp
#-- end of cleanup_library ---------------

