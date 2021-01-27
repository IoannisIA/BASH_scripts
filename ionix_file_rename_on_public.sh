#!/bin/bash

#this must be executed via root crontab
mv /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/IONIX/Cardlink\ PZac\ Detailed.csv /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/IONIX/ionix.$(date -d "today" '+%Y%m%d').csv

cp /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/IONIX/ionix.$(date -d "today" '+%Y%m%d').csv /home/linux/ionix.csv
