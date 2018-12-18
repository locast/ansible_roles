#!/bin/bash
cd /home/pi/Desktop/infos/
git add *
git commit -m "$(date) commit"
git push
