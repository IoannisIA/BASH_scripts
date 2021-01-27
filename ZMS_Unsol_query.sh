#!/bin/bash


if [ $# -eq 0 ]
  then
    echo "No argument supplied";
	dt=$(date -d "today" '+%Y%m%d');
  else
	echo "Arguments supplied";
	dt=$1;
fi


msg="ZMS reversals before auth cases FOR YESTERDAY\n\\nThis is an automatically generated email, please do not reply.\n\n\nIoannis Atlamazoglou\n\n\n"
 

#naqname               				   | naqacqid
#--------------------------------------+----------
# Alpha Bank                           |        1
# Eurobank                             |        2
# PIRAEUS EURONET LINK                 |        4
# CUP-AlphaBank                        |        7
# CUP-Eurobank                         |        8
# National Bank of Greece              |        9
# Alpha Bank Bill Payment              |       13
# Eurobank Bill Payment                |       14
# National Bank of Greece Bill Payment |       15
# Piraeus Bill Payment                 |       16




cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep ' 1$' |  tr '|' ',' > Alpha_Bank.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep ' 2$' |  tr '|' ',' > Eurobank.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep ' 4$' |  tr '|' ',' > PIRAEUS_EURONET_LINK.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep ' 7$' |  tr '|' ',' > CUP-AlphaBank.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep ' 8$' |  tr '|' ',' > CUP-Eurobank.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep ' 9$' |  tr '|' ',' > National_Bank_of_Greece.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep ' 13$' |  tr '|' ',' > Alpha_Bank_Bill_Payment.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep ' 14$' |  tr '|' ',' > Eurobank_Bill_Payment.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep ' 15$' |  tr '|' ',' > National_Bank_of_Greece_Bill_Payment.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep ' 16$' |  tr '|' ',' > Piraeus_Bill_Payment.csv
 
 
 

cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'SKLAVENITIS' | grep ' 1$' |  tr '|' ',' > SKLAVENITIS_Alpha_Bank.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'SKLAVENITIS' | grep ' 2$' |  tr '|' ',' > SKLAVENITIS_Eurobank.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'SKLAVENITIS' | grep ' 4$' |  tr '|' ',' > SKLAVENITIS_PIRAEUS_EURONET_LINK.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'SKLAVENITIS' | grep ' 7$' |  tr '|' ',' > SKLAVENITIS_CUP-AlphaBank.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'SKLAVENITIS' | grep ' 8$' |  tr '|' ',' > SKLAVENITIS_CUP-Eurobank.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'SKLAVENITIS' | grep ' 9$' |  tr '|' ',' > SKLAVENITIS_National_Bank_of_Greece.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'SKLAVENITIS' | grep ' 13$' |  tr '|' ',' > SKLAVENITIS_Alpha_Bank_Bill_Payment.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'SKLAVENITIS' | grep ' 14$' |  tr '|' ',' > SKLAVENITIS_Eurobank_Bill_Payment.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'SKLAVENITIS' | grep ' 15$' |  tr '|' ',' > SKLAVENITIS_National_Bank_of_Greece_Bill_Payment.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'SKLAVENITIS' | grep ' 16$' |  tr '|' ',' > SKLAVENITIS_Piraeus_Bill_Payment.csv
 

 

cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'JUMBO' | grep ' 1$' |  tr '|' ',' > JUMBO_Alpha_Bank.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'JUMBO' | grep ' 2$' |  tr '|' ',' > JUMBO_Eurobank.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'JUMBO' | grep ' 4$' |  tr '|' ',' > JUMBO_PIRAEUS_EURONET_LINK.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'JUMBO' | grep ' 7$' |  tr '|' ',' > JUMBO_CUP-AlphaBank.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'JUMBO' | grep ' 8$' |  tr '|' ',' > JUMBO_CUP-Eurobank.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'JUMBO' | grep ' 9$' |  tr '|' ',' > JUMBO_National_Bank_of_Greece.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'JUMBO' | grep ' 13$' |  tr '|' ',' > JUMBO_Alpha_Bank_Bill_Payment.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'JUMBO' | grep ' 14$' |  tr '|' ',' > JUMBO_Eurobank_Bill_Payment.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'JUMBO' | grep ' 15$' |  tr '|' ',' > JUMBO_National_Bank_of_Greece_Bill_Payment.csv
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unsolicited_PZAC_reversals.$dt.txt | grep 'JUMBO' | grep ' 16$' |  tr '|' ',' > JUMBO_Piraeus_Bill_Payment.csv
  

 
 
email1=ioannis.atlamazoglou@cardlink.gr
email2=george.kokkinakis@cardlink.gr
email3=zeljko.zeravica@zmsinfo.hr
email4=iraklis.stratigis@cardlink.gr
email5=andreas.vlachiotis@cardlink.gr
email6=makis.malioris@cardlink.gr
email7=thanassis.mylonas@cardlink.gr
email8=konstantinos.koukoutsis@cardlink.gr
email9=yiota.marosi@cardlink.gr
email10=evi.kountemani@cardlink.gr
email11=andreas_vlachiotis@yahoo.gr
email12=giannis.tsigkos@cardlink.gr
email13=george.mousalis@cardlink.gr
email14=sotiria.michou@cardlink.gr
email15=niki.tzouanou@cardlink.gr
email16=magdalini.vlachomitrou@cardlink.gr
email17=stelios.aggelopoulos@cardlink.gr
email18=nikos.protopapadakis@cardlink.gr
Alpha=Authorisation.Center@firstdata.gr
nbg1=kek@nbg.gr
nbg2=ntheod@nbg.gr
pir1=AcquiringServices@piraeusbank.gr
pir2=PapagiannopoulosA@piraeusbank.gr 

echo -e $msg | mutt -s "ZMS_report_ALL_SKLAVENITIS_&_JUMBO_Rev_Before_Auth" -a ./SKLAVENITIS_Alpha_Bank.csv -a ./SKLAVENITIS_Eurobank.csv -a ./SKLAVENITIS_PIRAEUS_EURONET_LINK.csv -a ./SKLAVENITIS_CUP-AlphaBank.csv -a ./SKLAVENITIS_CUP-Eurobank.csv -a ./SKLAVENITIS_National_Bank_of_Greece.csv -a ./SKLAVENITIS_Alpha_Bank_Bill_Payment.csv -a ./SKLAVENITIS_Eurobank_Bill_Payment.csv -a ./SKLAVENITIS_National_Bank_of_Greece_Bill_Payment.csv -a ./SKLAVENITIS_Piraeus_Bill_Payment.csv -a ./JUMBO_Alpha_Bank.csv -a ./JUMBO_Eurobank.csv -a ./JUMBO_PIRAEUS_EURONET_LINK.csv -a ./JUMBO_CUP-AlphaBank.csv -a ./JUMBO_CUP-Eurobank.csv -a ./JUMBO_National_Bank_of_Greece.csv -a ./JUMBO_Alpha_Bank_Bill_Payment.csv -a ./JUMBO_Eurobank_Bill_Payment.csv -a ./JUMBO_National_Bank_of_Greece_Bill_Payment.csv -a ./JUMBO_Piraeus_Bill_Payment.csv -- $email1 $email2 $email14 $email15 $email16 $email18 $email9 $email10



echo -e $msg | mutt -s "CARDLINK_ΑΠΟΔΕΣΜΕΥΣΕΙΣ" -a ./SKLAVENITIS_Alpha_Bank.csv -a ./SKLAVENITIS_CUP-AlphaBank.csv -a ./SKLAVENITIS_Alpha_Bank_Bill_Payment.csv -a ./JUMBO_Alpha_Bank.csv -a ./JUMBO_CUP-AlphaBank.csv -a ./JUMBO_Alpha_Bank_Bill_Payment.csv -- $email1 $email2  $email14 $email15 $email16 $Alpha $email18 $email9 $email10



echo -e $msg | mutt -s "CARDLINK_ΑΠΟΔΕΣΜΕΥΣΕΙΣ" -a ./SKLAVENITIS_National_Bank_of_Greece.csv -a ./SKLAVENITIS_National_Bank_of_Greece_Bill_Payment.csv -- $email1 $email2  $email14 $email15 $email16 $nbg1 $nbg2 $email18 $email9 $email10



echo -e $msg | mutt -s "CARDLINK_ΑΠΟΔΕΣΜΕΥΣΕΙΣ" -a ./SKLAVENITIS_PIRAEUS_EURONET_LINK.csv -a ./SKLAVENITIS_Piraeus_Bill_Payment.csv -- $email1 $email2  $email14 $email15 $email16 $pir1 $pir2 $email18 $email9 $email10



echo -e $msg | mutt -s "ZMS_report_TOTAL__Rev_Before_Auth" -a ./Alpha_Bank.csv -a ./Eurobank.csv -a ./PIRAEUS_EURONET_LINK.csv -a ./CUP-AlphaBank.csv -a ./CUP-Eurobank.csv -a ./National_Bank_of_Greece.csv -a ./Alpha_Bank_Bill_Payment.csv -a ./Eurobank_Bill_Payment.csv -a ./National_Bank_of_Greece_Bill_Payment.csv -a ./Piraeus_Bill_Payment.csv -- $email1 $email2  $email14 $email15  $email16  $email17 $email18 $email9 $email10


rm *.csv