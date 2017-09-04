#-- start of make_header -----------------

#====================================
#  Library G2K2Pi4Alg
#
#   Generated Thu Jul 27 03:51:37 2017  by lvxd
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_G2K2Pi4Alg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_G2K2Pi4Alg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_G2K2Pi4Alg

G2K2Pi4Alg_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_G2K2Pi4Alg = /tmp/CMT_$(G2K2Pi4Alg_tag)_G2K2Pi4Alg.make$(cmt_lock_pid)
else
#cmt_local_tagfile_G2K2Pi4Alg = $(G2K2Pi4Alg_tag)_G2K2Pi4Alg.make
cmt_local_tagfile_G2K2Pi4Alg = $(bin)$(G2K2Pi4Alg_tag)_G2K2Pi4Alg.make
endif

else

tags      = $(tag),$(CMTEXTRATAGS)

G2K2Pi4Alg_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_G2K2Pi4Alg = /tmp/CMT_$(G2K2Pi4Alg_tag).make$(cmt_lock_pid)
else
#cmt_local_tagfile_G2K2Pi4Alg = $(G2K2Pi4Alg_tag).make
cmt_local_tagfile_G2K2Pi4Alg = $(bin)$(G2K2Pi4Alg_tag).make
endif

endif

-include $(cmt_local_tagfile_G2K2Pi4Alg)

ifdef cmt_G2K2Pi4Alg_has_target_tag

ifdef READONLY
cmt_final_setup_G2K2Pi4Alg = /tmp/CMT_G2K2Pi4Alg_G2K2Pi4Algsetup.make
cmt_local_G2K2Pi4Alg_makefile = /tmp/CMT_G2K2Pi4Alg$(cmt_lock_pid).make
else
cmt_final_setup_G2K2Pi4Alg = $(bin)G2K2Pi4Alg_G2K2Pi4Algsetup.make
cmt_local_G2K2Pi4Alg_makefile = $(bin)G2K2Pi4Alg.make
endif

else

ifdef READONLY
cmt_final_setup_G2K2Pi4Alg = /tmp/CMT_G2K2Pi4Algsetup.make
cmt_local_G2K2Pi4Alg_makefile = /tmp/CMT_G2K2Pi4Alg$(cmt_lock_pid).make
else
cmt_final_setup_G2K2Pi4Alg = $(bin)G2K2Pi4Algsetup.make
cmt_local_G2K2Pi4Alg_makefile = $(bin)G2K2Pi4Alg.make
endif

endif

ifdef READONLY
cmt_final_setup = /tmp/CMT_G2K2Pi4Algsetup.make
else
cmt_final_setup = $(bin)G2K2Pi4Algsetup.make
endif

G2K2Pi4Alg ::


ifdef READONLY
G2K2Pi4Alg ::
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
	$(echo) 'G2K2Pi4Alg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = G2K2Pi4Alg/
G2K2Pi4Alg::
	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

#-- end of make_header ------------------

#-- start of libary_header ---------------

G2K2Pi4Alglibname   = $(bin)$(library_prefix)G2K2Pi4Alg$(library_suffix)
G2K2Pi4Alglib       = $(G2K2Pi4Alglibname).a
G2K2Pi4Algstamp     = $(bin)G2K2Pi4Alg.stamp
G2K2Pi4Algshstamp   = $(bin)G2K2Pi4Alg.shstamp

G2K2Pi4Alg :: dirs  G2K2Pi4AlgLIB
	$(echo) "G2K2Pi4Alg ok"

#-- end of libary_header ----------------

G2K2Pi4AlgLIB :: $(G2K2Pi4Alglib) $(G2K2Pi4Algshstamp)
	@/bin/echo "------> G2K2Pi4Alg : library ok"

$(G2K2Pi4Alglib) :: $(bin)G2K2Pi4.o $(bin)G2K2Pi4_entries.o $(bin)G2K2Pi4_load.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(G2K2Pi4Alglib) $?
	$(lib_silent) $(ranlib) $(G2K2Pi4Alglib)
	$(lib_silent) cat /dev/null >$(G2K2Pi4Algstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(G2K2Pi4Alglibname).$(shlibsuffix) :: $(G2K2Pi4Alglib) $(G2K2Pi4Algstamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" G2K2Pi4Alg $(G2K2Pi4Alg_shlibflags)

$(G2K2Pi4Algshstamp) :: $(G2K2Pi4Alglibname).$(shlibsuffix)
	@if test -f $(G2K2Pi4Alglibname).$(shlibsuffix) ; then cat /dev/null >$(G2K2Pi4Algshstamp) ; fi

G2K2Pi4Algclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)G2K2Pi4.o $(bin)G2K2Pi4_entries.o $(bin)G2K2Pi4_load.o

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
G2K2Pi4Alginstallname = $(library_prefix)G2K2Pi4Alg$(library_suffix).$(shlibsuffix)

G2K2Pi4Alg :: G2K2Pi4Alginstall

install :: G2K2Pi4Alginstall

G2K2Pi4Alginstall :: $(install_dir)/$(G2K2Pi4Alginstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(G2K2Pi4Alginstallname) :: $(bin)$(G2K2Pi4Alginstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(G2K2Pi4Alginstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(G2K2Pi4Alginstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(G2K2Pi4Alginstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(G2K2Pi4Alginstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(G2K2Pi4Alginstallname) $(install_dir)/$(G2K2Pi4Alginstallname); \
	      echo `pwd`/$(G2K2Pi4Alginstallname) >$(install_dir)/$(G2K2Pi4Alginstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(G2K2Pi4Alginstallname), no installation directory specified"; \
	  fi; \
	fi

G2K2Pi4Algclean :: G2K2Pi4Alguninstall

uninstall :: G2K2Pi4Alguninstall

G2K2Pi4Alguninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(G2K2Pi4Alginstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(G2K2Pi4Alginstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(G2K2Pi4Alginstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(G2K2Pi4Alginstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),G2K2Pi4Algclean)

#$(bin)G2K2Pi4Alg_dependencies.make :: dirs

ifndef QUICK
$(bin)G2K2Pi4Alg_dependencies.make : ../src/G2K2Pi4.cxx ../src/components/G2K2Pi4_entries.cxx ../src/components/G2K2Pi4_load.cxx $(use_requirements) $(cmt_final_setup_G2K2Pi4Alg)
	$(echo) "(G2K2Pi4Alg.make) Rebuilding $@"; \
	  $(build_dependencies) G2K2Pi4Alg -all_sources -out=$@ ../src/G2K2Pi4.cxx ../src/components/G2K2Pi4_entries.cxx ../src/components/G2K2Pi4_load.cxx
endif

#$(G2K2Pi4Alg_dependencies)

-include $(bin)G2K2Pi4Alg_dependencies.make

endif
#-- end of dependency -------------------
#-- start of cpp_library -----------------

$(bin)G2K2Pi4Alg_dependencies.make : $(G2K2Pi4_cxx_dependencies)

$(bin)$(binobj)G2K2Pi4.o : $(G2K2Pi4_cxx_dependencies)
	$(cpp_echo) $(src)G2K2Pi4.cxx
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(G2K2Pi4Alg_pp_cppflags) $(lib_G2K2Pi4Alg_pp_cppflags) $(G2K2Pi4_pp_cppflags) $(use_cppflags) $(G2K2Pi4Alg_cppflags) $(lib_G2K2Pi4Alg_cppflags) $(G2K2Pi4_cppflags) $(G2K2Pi4_cxx_cppflags)  $(src)G2K2Pi4.cxx

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

$(bin)G2K2Pi4Alg_dependencies.make : $(G2K2Pi4_entries_cxx_dependencies)

$(bin)$(binobj)G2K2Pi4_entries.o : $(G2K2Pi4_entries_cxx_dependencies)
	$(cpp_echo) $(src)components/G2K2Pi4_entries.cxx
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(G2K2Pi4Alg_pp_cppflags) $(lib_G2K2Pi4Alg_pp_cppflags) $(G2K2Pi4_entries_pp_cppflags) $(use_cppflags) $(G2K2Pi4Alg_cppflags) $(lib_G2K2Pi4Alg_cppflags) $(G2K2Pi4_entries_cppflags) $(G2K2Pi4_entries_cxx_cppflags) -I../src/components $(src)components/G2K2Pi4_entries.cxx

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

$(bin)G2K2Pi4Alg_dependencies.make : $(G2K2Pi4_load_cxx_dependencies)

$(bin)$(binobj)G2K2Pi4_load.o : $(G2K2Pi4_load_cxx_dependencies)
	$(cpp_echo) $(src)components/G2K2Pi4_load.cxx
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(G2K2Pi4Alg_pp_cppflags) $(lib_G2K2Pi4Alg_pp_cppflags) $(G2K2Pi4_load_pp_cppflags) $(use_cppflags) $(G2K2Pi4Alg_cppflags) $(lib_G2K2Pi4Alg_cppflags) $(G2K2Pi4_load_cppflags) $(G2K2Pi4_load_cxx_cppflags) -I../src/components $(src)components/G2K2Pi4_load.cxx

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: G2K2Pi4Algclean
	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(G2K2Pi4Alg.make) $@: No rule for such target" >&2
#	@echo "#CMT> Warning: $@: No rule for such target" >&2; exit
else
.DEFAULT::
	$(echo) "(G2K2Pi4Alg.make) PEDANTIC: $@: No rule for such target" >&2
	if test $@ = "$(cmt_final_setup)" -o\
	 $@ = "$(cmt_final_setup_G2K2Pi4Alg)" ; then\
	 found=n; for s in 1 2 3 4 5; do\
	 sleep $$s; test ! -f $@ || { found=y; break; }\
	 done; if test $$found = n; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(G2K2Pi4Alg.make) PEDANTIC: $@: Seems to be missing. Ignore it for now" >&2; exit 0 ; fi;\
	 elif test `expr index $@ '/'` -ne 0 ; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(G2K2Pi4Alg.make) PEDANTIC: $@: Seems to be a missing file. Please check" >&2; exit 2 ; \
	 else\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(G2K2Pi4Alg.make) PEDANTIC: $@: Seems to be a fake target due to some pattern. Just ignore it" >&2 ; exit 0; fi
endif

G2K2Pi4Algclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(binobj)$(library_prefix)G2K2Pi4Alg$(library_suffix).a $(binobj)$(library_prefix)G2K2Pi4Alg$(library_suffix).s? $(binobj)G2K2Pi4Alg.stamp $(binobj)G2K2Pi4Alg.shstamp
#-- end of cleanup_library ---------------

