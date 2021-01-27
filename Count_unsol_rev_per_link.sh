#!/bin/bash


if [ $# -eq 0 ]
  then
    echo "No argument supplied";
	da=$(date -d "today" '+%d%m%Y');
	datesource=zaccore_$(date -d "1 days ago 13:00" '+%Y-%m-%d');
  else
	echo "Arguments supplied";
	da=$1;
	datesource=zaccore_$2;
fi


rm ./Videos/*;
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_DR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;

echo "--------------------DR--------------------" > ./dr.txt
echo "" >> ./dr.txt
for i in `ls $datesource*.log`; do cat $i | grep 'Unable to find reversal matching with key PIRAEUS_IN*' >> /home/linux/dr.txt;  done

cd;



rm ./Videos/* ;
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_PR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;

echo "--------------------PR--------------------" > ./pr.txt
echo "" >> ./pr.txt
for i in `ls $datesource*.log`; do cat $i | grep 'Unable to find reversal matching with key PIRAEUS_IN*' >> /home/linux/pr.txt;  done

cd;



echo "PR" > full_totals.txt
cat ./pr.txt >> full_totals.txt
echo "DR" >> full_totals.txt
cat ./dr.txt >> full_totals.txt







msg="This is the daily report for all Euronet unsol revs from PowerZac for yesterday.\n\nThis is an automatically generated email, please do not reply.\n\n\nIoannis Atlamazoglou"
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
email16=giorgos.panagiotou@cardlink.gr
email17=diagoras.vougas@cardlink.gr
email18=nikos.protopapadakis@cardlink.gr


echo -e $msg | mutt -s "PZAC Unsolicited Revs from Euronet" -a ./full_totals.txt -- $email1 $email2 $email4 $email17 $email18


rm dr.txt pr.txt full_totals.txt
rm ./Videos/*;



