#!/usr/bin/env bash
echo "*************************************"
echo "*Installing prerequisites           *"
echo "*************************************"
apt-get -qq update
apt-get install -qq --no-install-recommends apt-utils >/dev/null
apt-get -qq install tar aria2 libgomp1 perl-modules graphicsmagick-libmagick-dev-compat libxt-dev libxrandr2 libxcursor-dev libxinerama-dev libxft-dev libxmu-dev libxi-dev libglu1-mesa bc bzip2 dc file libsm6 tcsh unzip libx11-6 libxext6 libgomp1 libexpat1 libgl1-mesa-glx libxt6 jq curl libstdc++6 binutils lrzip dcmtk >/dev/null
echo "deb http://archive.debian.org/debian-archive/debian jessie main contrib non-free" > /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stretch main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian stretch main contrib non-free" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stretch-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian stretch-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stretch-backports main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian stretch-backports main contrib non-free" >> /etc/apt/sources.list
apt-get -qq update
apt-get -qq install libxp6 libxpm4 libpng12-0 >/dev/null
aria2c -q -d /tmp -o libg2c0_3.4.6-8ubuntu2_amd64.deb http://old-releases.ubuntu.com/ubuntu/pool/universe/g/gcc-3.4/libg2c0_3.4.6-8ubuntu2_amd64.deb
dpkg -x /tmp/libg2c0_3.4.6-8ubuntu2_amd64.deb /tmp/
mv /tmp/usr/lib/libg2c* /usr/lib/
rm -rf /tmp/usr
echo "*************************************"
echo "*Installing FSL/Freesurfer/AFNI/MCR *"
echo "*Freesurfer: centos4_x86_64-v5.3.0  *"
echo "*FSL: ver 5.0.6-centos6_64          *"
echo "*AFNI: ver 2010_10_19_1028          *"
echo "*MCR: ver v84 (R2014b)              *"
echo "*************************************"
mkdir -p /usr/pubsw/packages/freesurfer
mkdir -p /usr/pubsw/packages/afni/AFNI_2010_10_19_1028
mkdir -p /usr/pubsw/packages/fsl
mkdir -p /usr/pubsw/packages/mcr
aria2c -q -x 10 -s 10 -d /tmp -o freesurfer-Linux-centos4_x86_64-stable-pub-v5.3.0.tar.gz ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/5.3.0/freesurfer-Linux-centos4_x86_64-stable-pub-v5.3.0.tar.gz
tar -xf /tmp/freesurfer-Linux-centos4_x86_64-stable-pub-v5.3.0.tar.gz -C /usr/pubsw/packages/freesurfer/
aria2c -q -x 10 -s 10 -d /tmp -o fsl-5.0.6-centos6_64.tar.gz https://fsl.fmrib.ox.ac.uk/fsldownloads/oldversions/fsl-5.0.6-centos6_64.tar.gz
tar -xf /tmp/fsl-5.0.6-centos6_64.tar.gz -C /usr/pubsw/packages/fsl/
aria2c -q -x 10 -s 10 -d /tmp/mcr -o mcr.zip http://ssd.mathworks.com/supportfiles/downloads/R2014b/deployment_files/R2014b/installers/glnxa64/MCR_R2014b_glnxa64_installer.zip
unzip -qq /tmp/mcr/mcr.zip -d /tmp/mcr
/tmp/mcr/install -destinationFolder /usr/pubsw/packages/mcr/v84 -agreeToLicense yes -mode silent
for ((i=0;i<=3;i++))
do
  aria2c -q -x 10 -s 10 -d /tmp/afni -o AFNI_2010_10_19_1028.tgz0$i https://github.com/xfgavin/abcd_docker/raw/master/packages/AFNI_2010_10_19_1028.tgz0$i
done
#aria2c -q -x 10 -s 10 -d /tmp/afni -o AFNI_2010_10_19_1028.tgz01 https://github.com/xfgavin/abcd_docker/raw/master/packages/AFNI_2010_10_19_1028.tgz01
#aria2c -q -x 10 -s 10 -d /tmp/afni -o AFNI_2010_10_19_1028.tgz02 https://github.com/xfgavin/abcd_docker/raw/master/packages/AFNI_2010_10_19_1028.tgz02
#aria2c -q -x 10 -s 10 -d /tmp/afni -o AFNI_2010_10_19_1028.tgz03 https://github.com/xfgavin/abcd_docker/raw/master/packages/AFNI_2010_10_19_1028.tgz03
cat /tmp/afni/AFNI_2010_10_19_1028.tgz00 /tmp/afni/AFNI_2010_10_19_1028.tgz01 /tmp/afni/AFNI_2010_10_19_1028.tgz02 /tmp/afni/AFNI_2010_10_19_1028.tgz03 > /tmp/afni/AFNI_2010_10_19_1028.tgz
tar xf /tmp/afni/AFNI_2010_10_19_1028.tgz -C /usr/pubsw/packages/afni/AFNI_2010_10_19_1028
mv /usr/pubsw/packages/fsl/fsl /usr/pubsw/packages/fsl/fsl-5.0.6-centos6_64
mv /usr/pubsw/packages/freesurfer/freesurfer /usr/pubsw/packages/freesurfer/RH4-x86_64-R530
ln -s /usr/lib/x86_64-linux-gnu/libtiff.so.5 /usr/lib/x86_64-linux-gnu/libtiff.so.3
ln -s /usr/lib/libMagick.so /usr/lib/libMagick.so.6
sed -e "s#^root.*#root:*:0:0:root:/root:/bin/tcsh#g" -i /etc/passwd
echo "*************************************"
echo "*Cleaning up                        *"
echo "*************************************"
apt-get -qq purge aria2 netbase manpages iputils-ping iproute2 gcc cpp cpp-6 gcc-6 >/dev/null
apt-get -qq autoremove >/dev/null
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
