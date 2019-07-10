#!/usr/bin/env bash
MMPSVER=$1
[ ${#MMPSVER} -eq 0 ] && echo "MMPS Version is invalid" && exit -1
padzero(){
  case ${#1} in
    1)
      echo "0$1"
      ;;
    *)
      echo "$1"
      ;;
  esac
}
date
echo "**********************************************"
echo "*Installing prerequisites                    *"
echo "**********************************************"
apt-get -qq update >/dev/null
apt-get install -qq --no-install-recommends apt-utils >/dev/null
apt-get -qq install tar aria2 libgomp1 perl-modules graphicsmagick-libmagick-dev-compat libxt-dev libxrandr2 libxcursor-dev libxinerama-dev libxft-dev libxmu-dev libxi-dev libglu1-mesa bc bzip2 dc file libsm6 tcsh unzip libx11-6 libxext6 libgomp1 libexpat1 libgl1-mesa-glx libxt6 jq curl libstdc++6 binutils lrzip dcmtk python3 python3-pip pigz >/dev/null
pip3 -q  --no-cache-dir install pydicom dicom pandas matplotlib scipy
echo "deb http://archive.debian.org/debian-archive/debian jessie main contrib non-free" > /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stretch main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian stretch main contrib non-free" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stretch-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian stretch-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stretch-backports main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian stretch-backports main contrib non-free" >> /etc/apt/sources.list
apt-get -qq update >/dev/null
apt-get -qq install libxp6 libxpm4 libpng12-0 >/dev/null
apt-get -qq install git build-essential cmake pkg-config >/dev/null
aria2c -q -d /tmp -o libg2c0_3.4.6-8ubuntu2_amd64.deb http://old-releases.ubuntu.com/ubuntu/pool/universe/g/gcc-3.4/libg2c0_3.4.6-8ubuntu2_amd64.deb
dpkg -x /tmp/libg2c0_3.4.6-8ubuntu2_amd64.deb /tmp/
mv /tmp/usr/lib/libg2c* /usr/lib/
rm -rf /tmp/usr
mkdir -p /usr/pubsw/packages/freesurfer
mkdir -p /usr/pubsw/packages/afni/AFNI_2010_10_19_1028
mkdir -p /usr/pubsw/packages/fsl
mkdir -p /usr/pubsw/packages/mcr
mkdir -p /usr/pubsw/packages/dtitk
mkdir -p /usr/pubsw/packages/MMPS/MMPS_$MMPSVER/bin

date
echo "**********************************************"
echo "*Installing Freesurfer centos4_x86_64-v5.3.0 *"
echo "**********************************************"
aria2c -q -x 10 -s 10 -d /tmp -o freesurfer-Linux-centos4_x86_64-stable-pub-v5.3.0.tar.gz ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/5.3.0/freesurfer-Linux-centos4_x86_64-stable-pub-v5.3.0.tar.gz
tar -xf /tmp/freesurfer-Linux-centos4_x86_64-stable-pub-v5.3.0.tar.gz -C /usr/pubsw/packages/freesurfer/
mv /usr/pubsw/packages/freesurfer/freesurfer /usr/pubsw/packages/freesurfer/RH4-x86_64-R530

date
echo "**********************************************"
echo "*Installing FSL 5.0.6-centos6_64             *"
echo "**********************************************"
aria2c -q -x 10 -s 10 -d /tmp -o fsl-5.0.6-centos6_64.tar.gz https://fsl.fmrib.ox.ac.uk/fsldownloads/oldversions/fsl-5.0.6-centos6_64.tar.gz
tar -xf /tmp/fsl-5.0.6-centos6_64.tar.gz -C /usr/pubsw/packages/fsl/
mv /usr/pubsw/packages/fsl/fsl /usr/pubsw/packages/fsl/fsl-5.0.6-centos6_64

date
echo "**********************************************"
echo "*Installing MATLAB run time v84 (R2014b)     *"
echo "**********************************************"
aria2c -q -x 10 -s 10 -d /tmp/mcr -o mcr.zip http://ssd.mathworks.com/supportfiles/downloads/R2014b/deployment_files/R2014b/installers/glnxa64/MCR_R2014b_glnxa64_installer.zip
unzip -qq /tmp/mcr/mcr.zip -d /tmp/mcr
/tmp/mcr/install -destinationFolder /usr/pubsw/packages/mcr/v84 -agreeToLicense yes -mode silent >/dev/null

date
echo "**********************************************"
echo "*Installing AFNI 2010_10_19_1028             *"
echo "**********************************************"
for ((i=0;i<=3;i++))
do
  aria2c -q -x 10 -s 10 -d /tmp/afni -o AFNI_2010_10_19_1028.tgz0$i https://github.com/xfgavin/abcd_docker/raw/master/packages/AFNI_2010_10_19_1028.tgz0$i
done
cat /tmp/afni/AFNI_2010_10_19_1028.tgz00 /tmp/afni/AFNI_2010_10_19_1028.tgz01 /tmp/afni/AFNI_2010_10_19_1028.tgz02 /tmp/afni/AFNI_2010_10_19_1028.tgz03 > /tmp/afni/AFNI_2010_10_19_1028.tgz
tar xf /tmp/afni/AFNI_2010_10_19_1028.tgz -C /usr/pubsw/packages/afni/AFNI_2010_10_19_1028

date
echo "**********************************************"
echo "*Installing MMPS 251                         *"
echo "**********************************************"
for ((i=0;i<=28;i++))
do
  aria2c -q -x 10 -s 10 -d /tmp/mmps_perpheral_mmps -o mmps_perpheral_mmps.tgz.lrz`padzero $i` https://github.com/xfgavin/abcd_docker/raw/master/packages/mmps_perpheral/mmps_perpheral_mmps.tgz.lrz`padzero $i`
done
cat /tmp/mmps_perpheral_mmps/mmps_perpheral_mmps.tgz.lrz* > /tmp/mmps_perpheral_mmps/mmps_perpheral_mmps.tgz.lrz
lrzip -d -q -O /tmp/mmps_perpheral_mmps/ /tmp/mmps_perpheral_mmps/mmps_perpheral_mmps.tgz.lrz
tar xf /tmp/mmps_perpheral_mmps/mmps_perpheral_mmps.tgz -C /usr/pubsw/packages

for ((i=0;i<=10;i++))
do
  aria2c -q -x 10 -s 10 -d /tmp/mmps_engine -o mmps_engine.lrz`padzero $i` https://github.com/xfgavin/abcd_docker/raw/master/mmps_engine/mmps_engine.lrz`padzero $i`
done
cat /tmp/mmps_engine/mmps_engine.lrz* > /tmp/mmps_engine/mmps_engine.lrz
lrzip -d -q -O /usr/pubsw/packages/MMPS/MMPS_$MMPSVER/bin/ /tmp/mmps_engine/mmps_engine.lrz
chmod +x /usr/pubsw/packages/MMPS/MMPS_$MMPSVER/bin/mmps_engine
for ((i=0;i<=1;i++))
do
  aria2c -q -x 10 -s 10 -d /tmp/mmps -o mmps_$MMPSVER.tgz`padzero $i` https://github.com/xfgavin/abcd_docker/raw/master/mmps/mmps_$MMPSVER.tgz`padzero $i`
done
cat /tmp/mmps/mmps_$MMPSVER.tgz* > /tmp/mmps/mmps_$MMPSVER.tgz
tar xf /tmp/mmps/mmps_$MMPSVER.tgz -C /usr/pubsw/packages/MMPS/MMPS_$MMPSVER/

aria2c -q -x 10 -s 10 -d /tmp -o mmps_perpheral_other.tgz https://github.com/xfgavin/abcd_docker/raw/master/packages/mmps_perpheral/mmps_perpheral_other.tgz
tar xf /tmp/mmps_perpheral_other.tgz -C /usr/pubsw/packages/

aria2c -q -x 10 -s 10 -d /tmp/ -o dtitk-2.3.1-Linux-x86_64.tar.gz https://github.com/xfgavin/abcd_docker/raw/master/packages/dtitk-2.3.1-Linux-x86_64.tar.gz
tar xf /tmp/dtitk-2.3.1-Linux-x86_64.tar.gz -C /usr/pubsw/packages/dtitk

date
echo "**********************************************"
echo "*Installing dcm2niix                         *"
echo "**********************************************"
aria2c -q -x 10 -s 10 -d /tmp/ -o dcm2niix.zip https://github.com/rordenlab/dcm2niix/archive/master.zip
(
cd /tmp
unzip /tmp/dcm2niix.zip >/dev/null
mkdir -p /tmp/dcm2niix-master/build
cd /tmp/dcm2niix-master/build
sed -e "s/opts->isFlipY = true/opts->isFlipY = false/g" -i ../console/nii_dicom_batch.cpp
cmake .. >/dev/null
make >/dev/null
mv bin/dcm2niix /usr/pubsw/packages/MMPS/MMPS_$MMPSVER/bin/dcm2niix_noflipY
ln -s dcm2niix_noflipY /usr/pubsw/packages/MMPS/MMPS_$MMPSVER/bin/dcm2niix
)

ln -s /usr/lib/x86_64-linux-gnu/libtiff.so.5 /usr/lib/x86_64-linux-gnu/libtiff.so.3
ln -s /usr/lib/libMagick.so /usr/lib/libMagick.so.6
sed -e "s#^root.*#root:*:0:0:root:/root:/bin/tcsh#g" -i /etc/passwd
date
echo "**********************************************"
echo "*Cleaning up                                 *"
echo "**********************************************"
apt-get -qq purge aria2 netbase manpages iputils-ping iproute2 gcc cpp cpp-6 gcc-6 git build-essential cmake pkg-config cmake-data tcpd>/dev/null
apt-get -qq autoremove >/dev/null
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
chmod -R 777 /tmp
