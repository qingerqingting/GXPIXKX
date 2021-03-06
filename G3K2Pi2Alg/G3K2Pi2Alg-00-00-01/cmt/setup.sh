# echo "Setting G3K2Pi2Alg G3K2Pi2Alg-00-00-01 in /besfs/users/lvxd/workarea"

if test "${CMTROOT}" = ""; then
  CMTROOT=/afs/ihep.ac.cn/bes3/offline/ExternalLib/contrib/CMT/v1r20p20081118; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh

tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then tempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=G3K2Pi2Alg -version=G3K2Pi2Alg-00-00-01 -path=/besfs/users/lvxd/workarea  -no_cleanup $* >${tempfile}; . ${tempfile}
/bin/rm -f ${tempfile}

