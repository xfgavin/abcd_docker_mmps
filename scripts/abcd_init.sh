#!/bin/bash
# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback
# Modified from https://denibertovic.com/posts/handling-permissions-with-docker-volumes/

USER_ID=${LOCAL_USER_ID:-1000}

#echo "Starting with UID : $USER_ID"
useradd --shell /bin/tcsh -u $USER_ID -o -c "" -m MMPS >/dev/null 2>&1
export HOME=/home/MMPS
#possibly will need to link a cshrc in /home/MMPS

exec /usr/local/bin/gosu MMPS "$@"
