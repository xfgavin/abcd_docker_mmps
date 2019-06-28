# Create a base abcd docker container 
#
# Note: The resulting container is ~8GB. 
# 
# Example build:
#   docker build --no-cache -t abcd:251 .
#
# Example usage:
#   docker run -ti \
#       -v /input/directory:/input \
#       -v `/output/directory:/output \
#       abcd:251 \
#       mri_convert -at /input/inputvolume.m3z /output/outvolume.mgz
#

# Start with debian
FROM debian
MAINTAINER Feng Xue <xfgavin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ADD abcddocker_installer.sh /tmp

RUN /tmp/abcddocker_installer.sh
###########MCR
#?g-rw-r--r-- 1 root root  723673080 Jun 26 07:11 MCR_R2014b_glnxa64_installer.zip
#?g-rw-r--r-- 1 root root  814921298 Jun 26 07:12 MCR_R2015b_glnxa64_installer.zip
#?g-rw-r--r-- 1 root root 1495757900 Jun 26 07:13 MCR_R2017b_glnxa64_installer.zip
#?g-rw-r--r-- 1 root root 1882014063 Jun 26 07:10 MCR_R2018b_glnxa64_installer.zip


    #&& find /usr/pubsw/packages/MMPS/ \( -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.m' -o -name '*.asv' -o -name '*.def' -o -name '*.vcproj' -o -name '*.old' -o -name '*.bak' -o -name '*.swp' -o -name '*.notes' -o -name '*.m~' -o -name CONTENTS -o -name 'README*' -o -name .xdebug_tkmedit -o -name '*.java' -o -name '*.cc' \) -delete \
    #&& find /usr/pubsw/packages/MMPS/external/external.*/matlab/Projects \( -name '*.sh' -o -name '*.xml' \) -delete \
    #&& find /usr/pubsw/packages/MMPS/external/ -name '*.doc' -delete
# Configure license 
#COPY license /opt/freesurfer/.license

## Configure basic freesurfer ENV
#ENV OS Linux
#ENV FS_OVERRIDE 0
#ENV FIX_VERTEX_AREA= 
#ENV SUBJECTS_DIR /output
#ENV FSF_OUTPUT_FORMAT nii.gz
#ENV MNI_DIR /opt/freesurfer/mni
#ENV LOCAL_DIR /opt/freesurfer/local
#ENV FREESURFER_HOME /opt/freesurfer
#ENV FSFAST_HOME /opt/freesurfer/fsfast
#ENV MINC_BIN_DIR /opt/freesurfer/mni/bin
#ENV MINC_LIB_DIR /opt/freesurfer/mni/lib
#ENV MNI_DATAPATH /opt/freesurfer/mni/data
#ENV FMRI_ANALYSIS_DIR /opt/freesurfer/fsfast
#ENV PERL5LIB /opt/freesurfer/mni/lib/perl5/5.8.5
#ENV MNI_PERL5LIB /opt/freesurfer/mni/lib/perl5/5.8.5
#ENV PATH /opt/freesurfer/bin:/opt/freesurfer/fsfast/bin:/opt/freesurfer/tktools:/opt/freesurfer/mni/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#
## Configure bashrc to source FreeSurferEnv.sh
#RUN /bin/bash -c ' echo -e "source $FREESURFER_HOME/FreeSurferEnv.sh &>/dev/null" >> /root/.bashrc '


#COPY ./gosu /usr/local/bin/
#COPY ./mmps_engine /usr/pubsw/packages/MMPS/MMPS_251/bin
#COPY ./*.sh /usr/pubsw/packages/MMPS/MMPS_251/sh/

ENV NAME "ABCD Processing Pipeline based on MMPS V251"
ENV VER "251_20180827"
ENV USER "MMPS"
ENV HOME "/home/MMPS"
#############################################################################
#The entrypoint_gosu.sh will creat an MMPS user with uid equals current user
#So data should be mounted to /home/MMPS
#############################################################################

#ENTRYPOINT ["/usr/pubsw/packages/MMPS/MMPS_251/sh/entrypoint_gosu.sh"]
ENV DEBIAN_FRONTEND teletype
