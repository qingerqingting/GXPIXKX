if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /afs/ihep.ac.cn/bes3/offline/ExternalLib/contrib/CMT/v1r20p20081118
endif
source ${CMTROOT}/mgr/setup.csh
set tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set tempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=G2K2Pi4Alg -version=G2K2Pi4Alg-00-00-01 -path=/besfs/users/lvxd/workarea $* >${tempfile}; source ${tempfile}
/bin/rm -f ${tempfile}

