#!/bin/bash

da=$(date -d "1 days ago" '+%Y-%m-%d');
dt=$(date -d "7 days ago" '+%Y-%m-%d');


python3.8 ./Downloads/pzac_statistics_visualization.py


msg="This is the statistics report from PowerZac last 7 days.\n\nThis is an automatically generated email, please do not reply.\n\n\nIoannis Atlamazoglou"
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


mv /home/linux/pzac_statistics.pdf /home/linux/pzac_reports/pzac_statistics_from_$dt'_to_'$da.pdf

echo -e $msg | mutt -s "PZAC Statistics from $dt to $da" -a /home/linux/pzac_reports/pzac_statistics_from_$dt'_to_'$da.pdf -- $email1 $email2 $email4 $email5 $email18 $email10 $email3
