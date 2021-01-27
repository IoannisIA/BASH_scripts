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



rm DATE TID test rev_*;
rm ./Videos/*;
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_DR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;



for i in `ls $datesource*.log`; do cat $i | grep 'Raw message \[bytes 0000-' >> /home/linux/test;  done

cd;


LC_ALL=C grep 'Raw message \[bytes 0000-0128.*.\ [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]FC.*' test | cut -d " " -f 2 | cut -d "]" -f 1 > DATE
LC_ALL=C grep 'Raw message \[bytes 0000-0128.*.\ [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]FC.*' test | cut -d " " -f 9 | cut -d "." -f 2 | cut -c 3-10 > TID
LC_ALL=C grep 'Raw message \[bytes 0000-0128.*.\ [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]FT.*' test | cut -d " " -f 2 | cut -d "]" -f 1 >> DATE
LC_ALL=C grep 'Raw message \[bytes 0000-0128.*.\ [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]FT.*' test | cut -d " " -f 9 | cut -d "." -f 2 | cut -c 3-10 >> TID

paste -d " " DATE TID > rev_dr.txt
rm DATE TID test





rm ./Videos/*;
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_PR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;


for i in `ls $datesource*.log`; do cat $i | grep 'Raw message \[bytes 0000-' >> /home/linux/test;  done

cd;


LC_ALL=C grep 'Raw message \[bytes 0000-0128.*.\ [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]FC.*' test | cut -d " " -f 2 | cut -d "]" -f 1 > DATE
LC_ALL=C grep 'Raw message \[bytes 0000-0128.*.\ [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]FC.*' test | cut -d " " -f 9 | cut -d "." -f 2 | cut -c 3-10 > TID
LC_ALL=C grep 'Raw message \[bytes 0000-0128.*.\ [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]FT.*' test | cut -d " " -f 2 | cut -d "]" -f 1 >> DATE
LC_ALL=C grep 'Raw message \[bytes 0000-0128.*.\ [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]FT.*' test | cut -d " " -f 9 | cut -d "." -f 2 | cut -c 3-10 >> TID
paste -d " " DATE TID > rev_pr.txt
rm DATE TID test




msg="This is the daily report for reversals from PowerZac for yesterday.\n\nThis is an automatically generated email, please do not reply.\n\n\nIoannis Atlamazoglou"
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



echo -e $msg | mutt -s "PZAC reversals" -a ./rev_dr.txt -a ./rev_pr.txt -- $email1 $email2 $email14 $email15 $email16 $email13 $email10 $email17 $email18


rm rev_dr.txt rev_pr.txt;
rm ./Videos/*;



