#!/bin/bash
#get services status
info_file=/home/pi/Desktop/infos/$(date).log

echo -e "\n\n" >> "$info_file"
echo "services:" >> "$info_file"
service --status-all >> "$info_file"

#memory
echo -e "\n memory:" >> "$info_file"
cat /proc/meminfo >> "$info_file"

#storage
echo -e "\n storage:" >> "$info_file"
df -h >> "$info_file"

#cpu temp
echo -e "\n cpu:" >> "$info_file"
vcgencmd measure_temp >> "$info_file"

#gpio state
echo -e "\n gpio state:" >> "$info_file"
gpio readall >> "$info_file"
