#!/bin/bash


if [ $# -eq 0 ]
  then
    echo "No argument supplied";
	da=$(date -d "today" '+%d%m%Y');
	datesource=_$(date -d "1 days ago 13:00" '+%Y-%m-%d');
  else
	echo "Arguments supplied";
	da=$1;
	datesource=_$2;
fi

rm test*;
rm ./Videos/*;
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_DR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;

echo "--------------------DR--------------------" > ./test_dr.txt
echo "" >> ./test_dr.txt
for i in `ls | grep ^[BDPSE] | grep $datesource`; do cat $i | grep 'Deactivating' >> /home/linux/test_dr.txt;  done
cd;



rm ./Videos/*;
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_PR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;

echo "--------------------PR--------------------" > ./test_pr.txt
echo "" >> ./test_pr.txt
for i in `ls | grep ^[BDPSE] | grep $datesource`; do cat $i | grep 'Deactivating' >> /home/linux/test_pr.txt;  done
cd;





cat ./test_pr.txt > full_totals
echo "" >> full_totals
cat ./test_dr.txt >> full_totals





msg="This is the daily report for port problems from PowerZac for yesterday.\n\nThis is an automatically generated email, please do not reply.\n\n\nIoannis Atlamazoglou"
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
email15=giorgos.fanourakis@cardlink.gr
email16=dimitris.gerostathis@cardlink.gr
email17=diagoras.vougas@cardlink.gr
email18=nikos.protopapadakis@cardlink.gr



cat full_totals | mutt -s "PZAC Port Connections - Restarts" -- $email1 $email2 $email4 $email15 $email17 $email18 

rm test* full_totals ;
rm ./Videos/*;

