#! /bin/bash
#Script to restart scheduler peridically.
#Currently set to run every 15 minutes. Duration may be altered later

sudo service scheduler stop
sleep 5
sudo service scheduler start
echo "Scheduler service has been Restarted"


