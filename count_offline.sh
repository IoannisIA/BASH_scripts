#!/bin/bash

rm ./Videos/*;
da=$(date -d "today" '+%d%m%Y');
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_DR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;


datesource=zaccore_$(date -d "1 days ago 13:00" '+%Y-%m-%d');
datedest=$(date -d "1 days ago 13:00" '+%d.%m.%Y');
for i in `ls $datesource*.log`; do cat $i | grep 'Raw message \[bytes 0000-' >> /home/linux/test;  done

cd;

rm date tid dat tim type amount svc;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d " " -f 1-2 > date;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d "." -f 5 | cut -d " " -f 15 | cut -c 1-6 > dat;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d "." -f 5 | cut -d " " -f 15 | cut -c 7-12 > tim;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d "." -f 5 | cut -d " " -f 15 | cut -c 13-16 > type;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d " " -f 9 | cut -d "." -f 2 | cut -c 3-10 > tid;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d " " -f 23 | cut -d "B" -f 2 | cut -d "]" -f 2 | cut -d "D" -f 1 > amount;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d " " -f 23 | cut -d "B" -f 2 | cut -d "]" -f 5 > svc;
paste -d "|" date tid dat tim type amount svc > dr_offline.txt;
rm date tid dat tim type amount svc test;
rm ./Videos/*;

####################################################################################################################

rm ./Videos/*;
da=$(date -d "today" '+%d%m%Y');
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_PR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;


datesource=zaccore_$(date -d "1 days ago 13:00" '+%Y-%m-%d');
datedest=$(date -d "1 days ago 13:00" '+%d.%m.%Y');
for i in `ls $datesource*.log`; do cat $i | grep 'Raw message \[bytes 0000-' >> /home/linux/test;  done

cd;


rm date tid dat tim type amount svc;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d " " -f 1-2 > date;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d "." -f 5 | cut -d " " -f 15 | cut -c 1-6 > dat;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d "." -f 5 | cut -d " " -f 15 | cut -c 7-12 > tim;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d "." -f 5 | cut -d " " -f 15 | cut -c 13-16 > type;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d " " -f 9 | cut -d "." -f 2 | cut -c 3-10 > tid;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d " " -f 23 | cut -d "B" -f 2 | cut -d "]" -f 2 | cut -d "D" -f 1 > amount;
grep Raw.*message.*[bytes.*0000-0128].*[LF]F[0-9][0-9].*SVC test | cut -d " " -f 23 | cut -d "B" -f 2 | cut -d "]" -f 5 > svc;
paste -d "|" date tid dat tim type amount svc > pr_offline.txt;
rm date tid dat tim type amount svc test;
rm ./Videos/*;





msg="This is the daily report for offline transactions from PowerZac for yesterday. This is an automatically generated email, please do not reply. Ioannis Atlamazoglou"
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
email17=stelios.aggelopoulos@cardlink.gr
email18=nikos.protopapadakis@cardlink.gr


echo -e $msg | mutt -s "PZAC Offline Transactions" -a ./pr_offline.txt -a ./dr_offline.txt -- $email1 $email2 $email14 $email15 $email16 $email13 $email10 $email17 $email18


rm ./pr_offline.txt ./dr_offline.txt;

