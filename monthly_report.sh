#!/bin/bash


# ----file example----
#   tlgsdev    | count
#--------------+-------
# SPDH_IN_3    |   386
# PIRAEUS_IN   | 12137
# SPDH_IN_2    | 38319
# BICISO_FDH   |   182
# BICISO_IN    | 22076
# SPDH_IN      | 39317
# BASE24_HCE_D |   311


rm totals* SPDH_IN* PIRA* final* BIC* BASE* days all_month_total

if [ $# -eq 0 ]
  then
    echo "No argument supplied";
	dt=$(date -d "today" '+%Y%m');
	dd=$(date -d "today" '+%m');	
  else
	echo "Arguments supplied";
	dt=$1;
	dd=$2;
fi

for i in 0{1..9} {10..31} ; 
do 
	cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt$i.txt | grep 'SPDH_IN_3' | cut -d "|" -f 2 | tail -9 | head -7 >> totals_SPDH_IN_3;
done
sed '1d' totals_SPDH_IN_3 > SPDH_IN_3;



for i in 0{1..9} {10..31} ; 
do 
	cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt$i.txt | grep 'PIRAEUS_IN' | cut -d "|" -f 2 | tail -9 | head -7 >> totals_PIRAEUS_IN;
done
sed '1d' totals_PIRAEUS_IN > PIRAEUS_IN
num_lines=`cat PIRAEUS_IN | wc -l`;
for i in $(seq 1 $num_lines); do echo $i/$dd >> days; done
paste days SPDH_IN_3 > final_SPDH_IN_3
paste days PIRAEUS_IN > final_PIRAEUS_IN


for i in 0{1..9} {10..31} ; 
do 
	cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt$i.txt | grep 'SPDH_IN_2' | cut -d "|" -f 2 | tail -9 | head -7 >> totals_SPDH_IN_2;
done
sed '1d' totals_SPDH_IN_2 > SPDH_IN_2
paste days SPDH_IN_2 > final_SPDH_IN_2


for i in 0{1..9} {10..31} ; 
do 
	cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt$i.txt | grep 'BICISO_FDH' | cut -d "|" -f 2 | tail -9 | head -7 >> totals_BICISO_FDH;
done
sed '1d' totals_BICISO_FDH > BICISO_FDH
paste days BICISO_FDH > final_BICISO_FDH

for i in 0{1..9} {10..31} ; 
do 
	cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt$i.txt | grep 'BICISO_IN' | cut -d "|" -f 2 | tail -9 | head -7 >> totals_BICISO_IN;
done
sed '1d' totals_BICISO_IN > BICISO_IN
paste days BICISO_IN > final_BICISO_IN

for i in 0{1..9} {10..31} ; 
do 
	cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt$i.txt | grep 'SPDH_IN[ ]' | cut -d "|" -f 2 | tail -9 | head -7 >> totals_SPDH_IN;
done
sed '1d' totals_SPDH_IN > SPDH_IN
paste days SPDH_IN > final_SPDH_IN

for i in 0{1..9} {10..31} ; 
do 
	cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt$i.txt | grep 'BASE24_HCE_D' | cut -d "|" -f 2 | tail -9 | head -7 >> totals_BASE24_HCE_D;
done
sed '1d' totals_BASE24_HCE_D > BASE24_HCE_D
paste days BASE24_HCE_D > final_BASE24_HCE_D


echo "SPDH_IN `cat SPDH_IN  | awk '{ sum += $1 } END { print sum }'`" >> all_month_total
echo "SPDH_IN_2 `cat SPDH_IN_2  | awk '{ sum += $1 } END { print sum }'`" >> all_month_total
echo "SPDH_IN_3 `cat SPDH_IN_3  | awk '{ sum += $1 } END { print sum }'`" >> all_month_total
echo "PIRAEUS_IN `cat PIRAEUS_IN  | awk '{ sum += $1 } END { print sum }'`" >> all_month_total
echo "BICISO_FDH `cat BICISO_FDH  | awk '{ sum += $1 } END { print sum }'`" >> all_month_total
echo "BICISO_IN `cat BICISO_IN  | awk '{ sum += $1 } END { print sum }'`" >> all_month_total
echo "BASE24_HCE_D `cat BASE24_HCE_D  | awk '{ sum += $1 } END { print sum }'`" >> all_month_total


gnuplot << EOF

set size 1,1
set terminal pdf
set term pdf size 13 , 5 


set output strftime('Monthly_TRX_Totals_Report_%d-%m-%y.pdf', time(0))

unset timefmt
unset xdata
unset format x
set boxwidth 0.5
set style fill solid
set format y "%'.0f";
plot "all_month_total" using 2: xtic(1) title "TOTAL TRXS PER CHANNEL OF THE MONTH" with boxes lc rgb 'orange'
unset yrange
unset format y
plot "final_SPDH_IN" using 2: xtic(1) title "SPDH_IN CHANNEL TRXS" with boxes lc rgb 'orange'
plot "final_SPDH_IN_2" using 2: xtic(1) title "SPDH_IN_2 CHANNEL TRXS" with boxes lc rgb 'orange'
plot "final_SPDH_IN_3" using 2: xtic(1) title "SPDH_IN_3 CHANNEL TRXS" with boxes lc rgb 'orange'
plot "final_PIRAEUS_IN" using 2: xtic(1) title "PIRAEUS_IN CHANNEL TRXS" with boxes lc rgb 'orange'
plot "final_BICISO_FDH" using 2: xtic(1) title "BICISO_FDH CHANNEL TRXS" with boxes lc rgb 'orange'
plot "final_BICISO_IN" using 2: xtic(1) title "BICISO_IN CHANNEL TRXS" with boxes lc rgb 'orange'
plot "final_BASE24_HCE_D" using 2: xtic(1) title "BASE24_HCE_D CHANNEL TRXS" with boxes lc rgb 'orange'

unset output

EOF


mv Monthly*.pdf ./pzac_reports/PZAC_Monthly_TRX_Totals_Report_$dt.pdf



msg="This is the monthly transactions totals per channel report from PowerZac for yesterday.\n\nThis is an automatically generated email, please do not reply.\n\nIoannis Atlamazoglou"
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


echo -e $msg | mail -s "PZAC_Monthly_TRX_Totals_Report_$dt" $email1 -A ./pzac_reports/PZAC_Monthly_TRX_Totals_Report_$dt.pdf

rm totals* SPDH_IN* PIRA* final* BIC* BASE* days all_month_total
