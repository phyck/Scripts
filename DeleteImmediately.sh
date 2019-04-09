#!/bin/sh
# ---------------------------------------------------------------------------------------------------
# Recursive deletes all files/folders that you pass as arguments to this script without confirmation!
# Logs date, time & which files/folders where deleted to /Users/"username"/Logs/DeleteImmediately.log
# Author: Stephen Hermans
# 
# Usage: DeleteImmediately.sh file/foldername file/foldername ...
# ---------------------------------------------------------------------------------------------------

username=$(whoami)
log="/Users/"$username"/Logs/DeleteImmediately.log"

# Logs date, time & which files/folders where deleted.
echo -e `date +%d/%m/%y`" "`date +%H:%M`"\tDeleted following files/folders:" >> $log
for args in "$@"; do
    echo $args >> $log
    rm -R "$args"
done
echo "" >> $log
