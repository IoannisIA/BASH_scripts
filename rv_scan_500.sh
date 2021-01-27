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





rm rv*
rm ./Videos/*;
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_DR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;

echo "*******DR*******" > /home/linux/rv500dr
echo "  " >> /home/linux/rv500dr
datedest=$(date -d "1 days ago 13:00" '+%d.%m.%Y');
for i in `ls $datesource*.log`; do cat $i | grep 'Finalize processing rv 500' >> /home/linux/rv500dr;  done

cd;

rm ./Videos/*;

####################################################################################################################

rm ./Videos/*;
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_PR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;

echo "*******PR*******" > /home/linux/rv500pr
echo "   " >> /home/linux/rv500pr
datedest=$(date -d "1 days ago 13:00" '+%d.%m.%Y');
for i in `ls $datesource*.log`; do cat $i | grep 'Finalize processing rv 500' >> /home/linux/rv500pr;  done

cd;

rm ./Videos/*;

echo "   " >> /home/linux/rv500pr

cat rv500dr >> rv500pr


msg="This is the daily report for offline transactions from PowerZac for yesterday.\n\nThis is an automatically generated email, please do not reply.\n\n\nIoannis Atlamazoglou"
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


cat rv500pr | mutt -s "RV 500 Scanner" -- $email1 $email2 $email3 $email4 $email10 $email16 $email18


rm rv*

