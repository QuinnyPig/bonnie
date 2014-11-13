#!/bin/bash
logdate=$(date +"%Y%m%d")
logfile="$logdate"_report.log
logpath="/test"
if [[ ! -d $logpath ]]; then
  echo "$logpath does not exist."
  exit 1
fi

while ps -e | grep bonnie++ > /dev/null
do
       free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
       df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
       top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}'
       sleep 10
done
       echo "bonnie++ is no longer running"

cat <<- EOF > $logpath/$logfile
       This report was generated while running bonnie++.
       It contains CPU, Memory, and Disk load while bonnie++ was running.
EOF
