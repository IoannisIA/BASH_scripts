#!/bin/bash


if [ $# -eq 0 ]
  then
    echo "No argument supplied";
	dt=$(date -d "today" '+%Y%m%d');
  else
	echo "Arguments supplied";
	dt=$1;
fi


msg="Unclosed batches analysis report FOR YESTERDAY\n\\nThis is an automatically generated email, please do not reply.\n\n\nIoannis Atlamazoglou\n\n\n"
 
cp /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_unclosed_batches.$dt.txt /home/linux/report_unclosed_batches.txt
  
python3.8 ./Downloads/Aging_report_unclosed_batches.py
 
 
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

echo -e $msg | mutt -s "Ageing report unclosed batches" -a /home/linux/Ageing_report_unclosed_batches.xlsx -- $email1 $email2 $email4 $email10 $email18


rm /home/linux/Ageing_report_unclosed_batches.xlsx /home/linux/report_unclosed_batches.txt