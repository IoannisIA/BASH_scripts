#!/bin/bash

da=$(date -d "today" '+%d%m%Y');
datesource=zacsync_$(date -d "1 days ago 13:00" '+%Y%m%d');
dt=$(date -d "yesterday 13:00" '+%Y-%m-%d');


unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_PR/$da?logs.zip -d /home/linux/Videos/;
cd;


cp /home/linux/Videos/$datesource.csv /home/linux/zacsync.csv ;


python3.8 /home/linux/Downloads/zac_sync_parse_\&_db_feed.py >> logs.txt

python3.8 /home/linux/Downloads/zac_sync_visualization.py >> logs.txt




msg="This is the daily report for synchronization process from PowerZac for yesterday.\n\nThis is an automatically generated email, please do not reply.\n\n\nIoannis Atlamazoglou"
email1=ioannis.atlamazoglou@cardlink.gr
email2=george.kokkinakis@cardlink.gr
email3=zeljko.zeravica@zmsinfo.hr
email4=iraklis.stratigis@cardlink.gr
email5=andreas.vlachiotis@cardlink.gr
email6=makis.malioris@cardlink.gr
email7=thanassis.mylonas@cardlink.gr
email8=konstantinos.koukoutsis@cardlink.gr
email9=antonis.moschou@cardlink.gr
email10=diagoras.vougas@cardlink.gr
email11=andreas_vlachiotis@yahoo.gr
email12=giannis.tsigkos@cardlink.gr
email13=george.mousalis@cardlink.gr
email14=sotiria.michou@cardlink.gr
email15=niki.tzouanou@cardlink.gr
email16=marko.benjak@zmsinfo.hr
email17=stelios.aggelopoulos@cardlink.gr
email18=nikos.protopapadakis@cardlink.gr


echo -e $msg >> msg

echo -"" >> msg

cat logs.txt >> msg

mv /home/linux/zac_sync_daily_report.pdf /home/linux/pzac_reports/zac_sync_daily_report_$dt.pdf

cat msg | mutt -s "PZAC Synchronization Daily Report for $dt" -a /home/linux/pzac_reports/zac_sync_daily_report_$dt.pdf -- $email1 $email2 $email4 $email5 $email16 $email18 $email10

rm /home/linux/Videos/* ;

rm /home/linux/zacsync.csv;

rm logs.txt msg
