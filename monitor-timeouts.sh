#!/bin/bash
# I created this script to monitor network timeouts using ping to serveral hosts.
# It will display ping statistics if packet loss is 100.0%, results will also be written to network-timeouts.log file.
#
# Usage: ./monitor-timeouts.sh [duration] [targets]
# Example: ./monitor-timeouts.sh 60 192.168.0.188 google.be microsoft.com
#
# Default ping configuration:
# TTL (Time-To-Live) = 64
# interval (seconds between pings) = 0.1
# timeout (seconds untill ping times out) = 1
# count (number of pings to each host) = 2
# minutes (duration of the network timeout test in minutes) = 60
# targets (default list of hosts if not specified) = ( "192.168.0.1" "telenet.be" "facebook.com" "tweakers.net" "google.be" )
# This will ping every host twice with an interval of 0.1 seconds & display statistics if packet loss to a host is 100.0%, these results will also be written to network-timeouts.log file.
#
# Default input arguments (if not specified):
minutes=60
targets=( "192.168.0.1" "telenet.be" "facebook.com" "tweakers.net" "google.be" )

# Ping configuration:
ttl=64
interval=0.1
timeout=1
count=2

# Script start
c='\033[0m'; Red='\033[1;31m'; White='\033[0;37m'; Purple='\033[0;35m'   # Color codes
rm -f network-timeouts.log    # Delete old network-timeouts.log file
clear
if [ "$#" -lt 2 ]; then
  echo -e "${Red}Missing input argument(s)!${c}"
  echo -e "Usage: ${Red}./monitor-timeouts.sh [duration] [targets]${c}"
  echo -e "Example: ${Red}./monitor-timeouts.sh 60 google.be 192.168.0.1 apple.com\n${c}"
fi
if [ "$#" -eq 1 ]; then
  minutes=$1
elif [ "$#" -gt 1 ]; then
  minutes=$1
  targets=( "${@:2}" )
fi
pings=$((60 * $minutes))
system=`uname`
if [[ $system == *"Linux"* ]]; then
    extraflag="-O"
fi

echo "Target hosts: ${targets[@] | tr ' ' ','}" >> network-timeouts.log
echo -e "Target hosts: ${Purple}${targets[@] | tr ' ' ,}${c}"
echo -e "Network timeouts monitoring started at `date +"%d/%m/%y"` `date +"%T"` for $minutes minute(s)\n" >> network-timeouts.log
echo -e "Network timeouts monitoring started at ${Red}`date +"%d/%m/%y"` ${White}`date +"%T"`${c} for ${Purple}$minutes minute(s)${c}\n"
while [ $pings -gt ${SECONDS} ]; do
  for i in "${targets[@]}"; do
    timeouts=$(ping "$i" -m "$ttl" -i "$interval" -t "$timeout" -c "$count" $extraflag | grep -i "100.0%" \
   -1)
    if [ -n "$timeouts" ]; then
      echo -ne '\007'   # Beep sound
      echo -e "`date +"%d/%m/%y"` `date +"%T"` Network timeout:" >> network-timeouts.log
      echo -e "${Red}`date +"%d/%m/%y"` ${White}`date +"%T"` ${Purple}Network timeout:${c}"
      echo -e "${timeouts}\n" >> network-timeouts.log
      echo -e "${White}${timeouts}${c}\n"
    fi
  done
done
echo -e "Network timeouts ended at `date +"%d/%m/%y"` `date +"%T"`" >> network-timeouts.log
echo -e "Network timeouts ended at ${Red}`date +"%d/%m/%y"` ${White}`date +"%T"`${c}"
