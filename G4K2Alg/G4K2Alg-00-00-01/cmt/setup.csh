# echo "Setting G4K2Alg G4K2Alg-00-00-01 in /besfs/users/longyf/workarea664p01"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /afs/ihep.ac.cn/bes3/offline/ExternalLib/contrib/CMT/v1r20p20081118
endif
source ${CMTROOT}/mgr/setup.csh

set tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set tempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=G4K2Alg -version=G4K2Alg-00-00-01 -path=/besfs/users/longyf/workarea664p01  -no_cleanup $* >${tempfile}; source ${tempfile}
/bin/rm -f ${tempfile}

