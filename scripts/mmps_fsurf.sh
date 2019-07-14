#!/usr/bin/env bash
#####################################
#MMPS freesurfer scripts parser
#By Feng Xue (xfgavin at gmail.com)
# in UCSD 2018
#####################################
MCRROOT=/usr/pubsw/packages/mcr/v81
jobdir=$1
[ ${#jobdir} -eq 0 ] && echo "Usage: `basename $0` jobdir" && exit 0
[ ! -d ~/batchdirs/$jobdir ] && echo "jobdir $jobdir does not exist." && exit 0
[ ! -f ~/batchdirs/$jobdir/scriptlist.txt ] && echo "Missing scriptlist.txt in jobdir $jobdir." && exit 0
[ ! -s ~/batchdirs/$jobdir/scriptlist.txt ] && echo "Empty scriptlist.txt in jobdir $jobdir." && exit 0
#for job in `cat ~/batchdirs/$jobdir/scriptlist.txt|grep job_`
for job in `grep job_ ~/batchdirs/$jobdir/scriptlist.txt`
do
  [ ! -f ~/batchdirs/$jobdir/$job.csh ] && echo "Missing jobfile: ~/batchdirs/$jobdir/$job.csh." && continue
  [ ! -s ~/batchdirs/$jobdir/$job.csh ] && echo "Empty jobfile ~/batchdirs/$jobdir/$job.csh." && continue
  hasmatlabjob=`grep matlab ~/batchdirs/$jobdir/$job.csh|wc -l`
  if [ $hasmatlabjob -gt 0 ]
  then
    matlabcmd=`grep matlab ~/batchdirs/$jobdir/$job.csh|cut -d" " -f6|sed -e "s/^/parms=[];/g"`
    sed /matlab/d -i ~/batchdirs/$jobdir/$job.csh
  fi
  chmod +x ~/batchdirs/$jobdir/$job.csh
  echo "Running: ~/batchdirs/$jobdir/$job.csh"
  #~/batchdirs/$jobdir/$job.csh
  [ $hasmatlabjob -gt 0 ] && run_mmps_engine.sh $MCRROOT "$matlabcmd"
done
