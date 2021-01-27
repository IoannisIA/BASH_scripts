#!/bin/bash
cd Downloads/; 


if [ $# -eq 0 ]
  then
    echo "No argument supplied";
	dt=$(date -d "yesterday" '+%y%m%d');
  else
	echo "Arguments supplied";
	dt=$1;
fi


ecommerce=`cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/UNSOLICITED/il$dt | grep '420 795\|420 900' | wc -l`
euronet=`cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/UNSOLICITED/il$dt | grep '420 077' | wc -l`
mellon=`cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/UNSOLICITED/il$dt | grep '420 73' | wc -l`
printec=`cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/UNSOLICITED/il$dt | grep '420 78\|420 76' | wc -l`
mpos=`cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/UNSOLICITED/il$dt | grep '420 77' | wc -l`
hypercom=`cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/UNSOLICITED/il$dt | grep '420 723' | wc -l`

msg="UNSOLICITED REVERSALS FOR YESTERDAY\n\nE-Commerce $ecommerce\nEuronet $euronet\nMellon $mellon\nPrintec $printec\nMpos $mpos\nHypercom $hypercom\n\nThis is an automatically generated email, please do not reply.\n\n\nIoannis Atlamazoglou\n\n\n"
 

 
 
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


 

 
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/UNSOLICITED/il$dt | grep '420 7'[012345678] | mutt -s "UNSOLICITED REVERSALS_FILE" -- $email1 $email4 $email2 $email5 $email14 $email17

echo -e $msg | mutt -s "UNSOLICITED REVERSALS_REPORT" -- $email1 $email2 $email14 $email17 $email18
