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

rm totals* sum* test

rm ./Videos/* test;
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_DR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;


for i in `ls $datesource*.log`; do cat $i | grep 'Routing request to port EFG_CORTEX_.*.spdh-in\|Routing request to port EFG_CORTEX_.*.biciso-in' >> /home/linux/test;  done

cd;


grep 'EFG_CORTEX_1' test | wc -l >> sum_dr
grep 'EFG_CORTEX_2' test | wc -l >> sum_dr
grep 'EFG_CORTEX_3' test | wc -l >> sum_dr
grep 'EFG_CORTEX_4' test | wc -l >> sum_dr
grep 'EFG_CORTEX_5' test | wc -l >> sum_dr
grep 'EFG_CORTEX_6' test | wc -l >> sum_dr
grep 'EFG_CORTEX_7' test | wc -l >> sum_dr
grep 'EFG_CORTEX_8' test | wc -l >> sum_dr



echo 'EFG_CORTEX_1' >> sum1_dr
echo 'EFG_CORTEX_2' >> sum1_dr
echo 'EFG_CORTEX_3' >> sum1_dr
echo 'EFG_CORTEX_4' >> sum1_dr
echo 'EFG_CORTEX_5' >> sum1_dr
echo 'EFG_CORTEX_6' >> sum1_dr
echo 'EFG_CORTEX_7' >> sum1_dr
echo 'EFG_CORTEX_8' >> sum1_dr



echo "--------------------DR--------------------" > totals_dr.txt
echo "" >> totals_dr.txt
paste -d "|" sum1_dr sum_dr >> totals_dr.txt




rm ./Videos/* test;
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_PR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;


for i in `ls $datesource*.log`; do cat $i | grep 'Routing request to port EFG_CORTEX_.*.spdh-in\|Routing request to port EFG_CORTEX_.*.biciso-in' >> /home/linux/test;  done

cd;



grep 'EFG_CORTEX_1' test | wc -l >> sum_pr
grep 'EFG_CORTEX_2' test | wc -l >> sum_pr
grep 'EFG_CORTEX_3' test | wc -l >> sum_pr
grep 'EFG_CORTEX_4' test | wc -l >> sum_pr
grep 'EFG_CORTEX_5' test | wc -l >> sum_pr
grep 'EFG_CORTEX_6' test | wc -l >> sum_pr
grep 'EFG_CORTEX_7' test | wc -l >> sum_pr
grep 'EFG_CORTEX_8' test | wc -l >> sum_pr



echo 'EFG_CORTEX_1' >> sum1_pr
echo 'EFG_CORTEX_2' >> sum1_pr
echo 'EFG_CORTEX_3' >> sum1_pr
echo 'EFG_CORTEX_4' >> sum1_pr
echo 'EFG_CORTEX_5' >> sum1_pr
echo 'EFG_CORTEX_6' >> sum1_pr
echo 'EFG_CORTEX_7' >> sum1_pr
echo 'EFG_CORTEX_8' >> sum1_pr



echo "--------------------PR--------------------" > totals_pr.txt
echo "" >> totals_pr.txt
paste -d "|" sum1_pr sum_pr >> totals_pr.txt




msg="This is the daily report for Cortex totals trx per port from PowerZac for yesterday.\n\nThis is an automatically generated email, please do not reply.\n\n\nIoannis Atlamazoglou"
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

cat ./totals_pr.txt > full_totals
echo "" >> full_totals
cat ./totals_dr.txt >> full_totals


cat full_totals | mutt -s "PZAC Cortex totals trx per port" -- $email1 $email2 $email4 $email17 $email18


rm totals* sum* test full_totals
rm ./Videos/*;



