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



rm dr.txt pr.txt full_totals.txt
rm ./Videos/*;


unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_DR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;


for i in `ls $datesource*.log`; do cat $i | grep 'Unable to find reversal matching with key SPDH_IN*' >> /home/linux/dr.txt;  done
echo "DR" >> /home/linux/full_totals.txt
cat /home/linux/dr.txt | egrep SPDH_IN.?.?\\$\7[1247] | cut -d '$' -f 2 >> /home/linux/full_totals.txt

cd;



rm ./Videos/* ;
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_PR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;


for i in `ls $datesource*.log`; do cat $i | grep 'Unable to find reversal matching with key SPDH_IN*' >> /home/linux/pr.txt;  done
echo "PR" >> /home/linux/full_totals.txt
cat /home/linux/pr.txt | egrep SPDH_IN.?.?\\$\7[1247] | cut -d '$' -f 2 >> /home/linux/full_totals.txt

cd;


msg="This is the daily report for Android POS unsolicited reversals from PowerZac for yesterday.\n\nThis is an automatically generated email, please do not reply.\n\n\nIoannis Atlamazoglou"
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
email19=yiota.marosi@cardlink.gr
email20=ioanna.kamasia@cardlink.gr
email21=michalis.koutalis@cardlink.gr
email22=anatoli.michailidou@cardlink.gr
email23=magdalini.vlachomitrou@cardlink.gr
email24=vassilis.hardalias@cardlink.gr
email25=eftichia.gorgosoglou@cardlink.gr
email26=evi.kountemani@cardlink.gr
email27=moisis.papadopoulos@cardlink.gr

echo -e $msg | mutt -s "PZAC Android Unsolicited Reversals" -a ./full_totals.txt -- $email1 $email6 $email2 $email4 $email14 $email17 $email18 $email19 $email20 $email9 $email21 $email22 $email23 $email24 $email25 $email26 $email27


rm dr.txt pr.txt full_totals.txt
rm ./Videos/*;



