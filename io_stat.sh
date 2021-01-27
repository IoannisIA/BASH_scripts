#!/bin/bash



if [ $# -eq 0 ]
  then
    echo "No argument supplied";
	da=$(date -d "today" '+%d%m%Y');
	datesource=iostat_stats_$(date -d "1 days ago 13:00" '+%Y-%m-%d');
  else
	echo "Arguments supplied";
	da=$1;
	datesource=iostat_stats_$2;
fi



rm /home/linux/Videos/*;
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_DR/$da?logs.zip -d /home/linux/Videos/;
cd;


/usr/local/bin/iostat-cli --data /home/linux/Videos/$datesource* --fig-output pzapp2-iostat.png  plot


rm /home/linux/Videos/*;


unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_PR/$da?logs.zip -d /home/linux/Videos/;
cd;


/usr/local/bin/iostat-cli --data /home/linux/Videos/$datesource* --fig-output pzapp1-iostat.png  plot




rm /home/linux/Videos/*;


msg="This is the daily report for I/O Stats from PowerZac for yesterday.\n\nThis is an automatically generated email, please do not reply.\n\n\nIoannis Atlamazoglou"
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


echo -e $msg | mutt -s "I/O Stats" -a pzapp1-iostat.png -a pzapp2-iostat.png -- $email1 

rm pzapp1-iostat.png pzapp2-iostat.png

