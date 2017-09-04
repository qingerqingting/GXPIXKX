#sed -i -e 's|G2K2Pi4|lvxd|' newpacage.sh

#Make a new package.
#The example is from G2K2Pi2Alg to G2K2Pi4Alg.
#In use change G2K2Pi2 to former name, change G2K2Pi4 to latest name.
#Change requirements in TestRelease.
#Type 'sh bianyi.sh'.
#By Dong Chao, modified by Long Yunfei.
 
rm -rf G2K2Pi4Alg
cp  -r G2K2Pi2Alg G2K2Pi4Alg &&
cd G2K2Pi4Alg/ &&
rename G2K2Pi2 G2K2Pi4 * &&
cd G2K2Pi4Alg-00-00-*/  &&
rename G2K2Pi2 G2K2Pi4 * &&
cd src/  &&
rename G2K2Pi2 G2K2Pi4 *.cxx &&
sed -i 's/G2K2Pi2/G2K2Pi4/g' *.cxx &&
cd components/  &&
rename G2K2Pi2 G2K2Pi4 *.cxx &&
sed -i 's/G2K2Pi2/G2K2Pi4/g' *.cxx &&
cd ../../G2K2Pi4*/  &&
rename G2K2Pi2 G2K2Pi4 *.h &&
sed -i 's/G2K2Pi2/G2K2Pi4/g' *.h  &&
cd ../cmt &&
sed -i 's/G2K2Pi2/G2K2Pi4/g' requirements 
cd ../share &&
rename jobOptions_G2K2Pi2 jobOptions_G2K2Pi4 * &&
sed -i 's/G2K2Pi2/G2K2Pi4/g' jobOptions_Ppb.txt  &&
cd 

