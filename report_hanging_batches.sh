#!/bin/bash
cd Downloads/;


if [ $# -eq 0 ]
  then
    echo "No argument supplied";
	dt=$(date -d "today" '+%Y%m%d');
  else
	echo "Arguments supplied";
	dt=$1;
fi





email1=ioannis.atlamazoglou@cardlink.gr
email2=george.kokkinakis@cardlink.gr
email3=zeljko.zeravica@zmsinfo.hr
email4=iraklis.stratigis@cardlink.gr
email5=andreas.vlachiotis@cardlink.gr
email6=makis.malioris@cardlink.gr
email7=thanassis.mylonas@cardlink.gr
email8=konstantinos.koukoutsis@cardlink.gr
email9=antonis.moschou@cardlink.gr
email10=Theodoros.karamanlis@cardlink.gr
email11=andreas_vlachiotis@yahoo.gr
email12=giannis.tsigkos@cardlink.gr
email13=george.mousalis@cardlink.gr
email14=sotiria.michou@cardlink.gr
email15=niki.tzouanou@cardlink.gr
email16=pinelopi.zachari@cardlink.gr
email17=diagoras.vougas@cardlink.gr
email18=nikos.protopapadakis@cardlink.gr

 

cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_hanging_batches.$dt.txt | mutt -s "Report hanging batches" -- $email1 $email4 $email2 $email14 $email17 $email18


cd;


