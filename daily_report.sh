#!/bin/bash

rm ionix* total* trx* unsol_rev* approvals* reversals* batch_uploads* batch_closes* handshakes* declines* sessions* xa* [0-9][0-9].[0-9][0-9].*

rm ./Videos/*;
da=$(date -d "today" '+%d%m%Y');
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_DR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;


datesource=zaccore_$(date -d "1 days ago 13:00" '+%Y-%m-%d');
datedest=$(date -d "1 days ago 13:00" '+%d.%m.%Y');
for i in `ls $datesource*.log`; do cat $i | LC_ALL=C grep 'Raw message \[bytes 0000-\|Unable to find reversal matching with key' >> /home/linux/$datedest;  done

cd;

dt=$(date -d "yesterday 13:00" '+%Y%m%d');
grep ^[[] ./Videos/memoryDiagnostics_$dt.log | cut -d " " -f 2 | cut -d "]" -f 1 | cut -d ":" -f 1-2 > dates.txt




while IFS='' read -r line || [[ -n "$line" ]]; 
do 
	if [[ $line == count\ of\ active\ zacnd\ processes* ]]; 
	then 
		flag1=1; 
		continue; 
	fi; 
	
	if [[ $flag1 -eq 1 ]]; 
	then  
		echo "$line" >> counts1.txt; 
		flag1=0; 
	fi; 
	
	if [[ $line == count\ of\ active\ zaccd\ processes* ]]; 
	then 
		flag2=1; 
		continue; 
	fi; 
	
	if [[ $flag2 -eq 1 ]]; 
	then  
		echo "$line" >> counts2.txt; 
		flag2=0; 
	fi; 
	
	if [[ $line == count\ of\ active\ postgres\ processes* ]]; 
	then 
		flag3=1; 
		continue; 
	fi; 
	
	if [[ $flag3 -eq 1 ]]; 
	then  
		echo "$line" >> counts3.txt; 
		flag3=0; 
	fi; 
		
	if [[ $line == count\ of\ active\ cache\ DB\ postgres\ connection\ processes* ]]; 
	then 
		flag4=1; 
		continue; 
	fi; 
	
	if [[ $flag4 -eq 1 ]]; 
	then  
		echo "$line" >> counts4.txt; 
		flag4=0; 
	fi; 
	
	if [[ $line == count\ of\ active\ shadow\ DB\ postgres\ connection\ processes* ]]; 
	then 
		flag5=1; 
		continue; 
	fi; 
	
	if [[ $flag5 -eq 1 ]]; 
	then  
		echo "$line" >> counts5.txt; 
		flag5=0; 
	fi; 
	
	if [[ $line == count\ of\ active\ shadow\ DB\ postgres\ connection\ for\ syscenter\ processes* ]]; 
	then 
		flag6=1; 
		continue; 
	fi; 
	
	if [[ $flag6 -eq 1 ]]; 
	then  
		echo "$line" >> counts6.txt; 
		flag6=0; 
	fi; 
done < ./Videos/memoryDiagnostics_$dt.log


paste -d" " dates.txt counts1.txt > datescounts1.txt
sort  -n -k 1 datescounts1.txt > sessions_dr1.txt


paste -d" " dates.txt counts2.txt > datescounts2.txt
sort  -n -k 1 datescounts2.txt > sessions_dr2.txt


paste -d" " dates.txt counts3.txt > datescounts3.txt
sort  -n -k 1 datescounts3.txt > sessions_dr3.txt


paste -d" " dates.txt counts4.txt > datescounts4.txt
sort  -n -k 1 datescounts4.txt > sessions_dr4.txt


paste -d" " dates.txt counts5.txt > datescounts5.txt
sort  -n -k 1 datescounts5.txt > sessions_dr5.txt


paste -d" " dates.txt counts6.txt > datescounts6.txt
sort  -n -k 1 datescounts6.txt > sessions_dr6.txt



grep ^Mem ./Videos/memoryDiagnostics_$dt.log | cut -d " " -f 13 > mem.txt
sed -e 's/$/ \/ 263579444 * 100/' -i mem.txt
while IFS='' read -r line || [[ -n "$line" ]]; 
do 
	echo "$line" | bc -l >> memo1; 
done < mem.txt
paste -d" " dates.txt memo1 > datesmem.txt
sort  -n -k 1 datesmem.txt > memory_dr.txt

rm dates* counts* mem.txt memo1 datesmem*




dt=$(date -d "today" '+%Y%m%d');

cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt.txt | grep SPDH* | cut -d "|" -f 1 | cut -d "|" -f 2 > tmp1.txt
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt.txt | grep BA* | cut -d "|" -f 1 | cut -d "|" -f 2 >> tmp1.txt
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt.txt | grep PIRAEUS_IN | cut -d "|" -f 1 | cut -d "|" -f 2 >> tmp1.txt
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt.txt | grep VIVA_IN | cut -d "|" -f 1 | cut -d "|" -f 2 >> tmp1.txt
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt.txt | grep STIP_IN | cut -d "|" -f 1 | cut -d "|" -f 2 >> tmp1.txt
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt.txt | grep SPDH* | cut -d "|" -f 2 | cut -d "|" -f 2 > tmp2.txt
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt.txt | grep BA* | cut -d "|" -f 2 | cut -d "|" -f 2 >> tmp2.txt
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt.txt | grep PIRAEUS_IN | cut -d "|" -f 2 | cut -d "|" -f 2 >> tmp2.txt
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt.txt | grep VIVA_IN | cut -d "|" -f 2 | cut -d "|" -f 2 >> tmp2.txt
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_port.$dt.txt | grep STIP_IN | cut -d "|" -f 2 | cut -d "|" -f 2 >> tmp2.txt

paste tmp1.txt tmp2.txt > total.txt
rm tmp1.txt tmp2.txt 


li=$(($(cat $datedest | wc -l) / 4 ));
split -l $li $datedest;


stamp1=`head -n 1 xaa | cut -d " " -f 2 |  cut -d "]" -f 1 | cut -d ":" -f 1-2 | tr -d ':';`;
stamp2=`head -n 1 xab | cut -d " " -f 2 |  cut -d "]" -f 1 | cut -d ":" -f 1-2 | tr -d ':';`;
stamp3=`head -n 1 xac | cut -d " " -f 2 |  cut -d "]" -f 1 | cut -d ":" -f 1-2 | tr -d ':';`;
stamp4=`head -n 1 xad | cut -d " " -f 2 |  cut -d "]" -f 1 | cut -d ":" -f 1-2 | tr -d ':';`;


i=j=0;
dt=$(date -d "yesterday 13:00" '+%d.%m.%Y');
for j in 0{0..9} {10..23} ; 
do 
	for i in 0{0..9} {10..59}
	do 
	
	
		if [ $stamp1 -le $j$i -a $stamp2 -gt $j$i ]; 
		then  
			path=xaa;
		fi
		if [ $stamp2 -le $j$i -a $stamp3 -gt $j$i ]; 
		then  
			path=xab; 
		fi
		if [ $stamp3 -le $j$i -a $stamp4 -gt $j$i ]; 
		then  
			path=xac; 
		fi
		if [ $stamp4 -le $j$i ]; 
		then  
			path=xad; 
		fi
	
	

	
		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Unable to find reversal matching with key' | wc -l;`;
		echo "$j:$i $c" >> unsol_rev_dr.txt

	
	
		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Raw message \[bytes 0000-.*.AO60' | wc -l;`;
		c=$(($c/2));
		echo "$j:$i $c" >> batch_closes_dr.txt
	


		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Raw message \[bytes 0000-.*.gUPLOAD REQUESTED' | wc -l;`;
		echo "$j:$i $c" >> batch_uploads_dr.txt




		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Raw message \[bytes 0000-.*.ISO[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]0420' | wc -l;`;
		echo "$j:$i $c" >> reversals_dr.txt
		
		
		
		
		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Raw message \[bytes 0000-.*.gDECLINED' | wc -l;`;
		echo "$j:$i $c" >> declines_dr.txt
		
		
		
		
		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Raw message \[bytes 0000-.*.gAPPROVED' | wc -l;`;
		echo "$j:$i $c" >> approvals_dr.txt
		
		

		
		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Raw message \[bytes 0000-.*.AO95' | wc -l;`;
		c=$(($c/2));
		echo "$j:$i $c" >> handshakes_dr.txt
		
		
	done
done


syscenter=`cut -d " " -f 2 sessions_dr6.txt | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'`

echo "BATCH-CLOSES `cut -d " " -f 2 batch_closes_dr.txt | awk '{ sum += $1 } END { print sum }'`" > total2_dr.txt ;
echo "BATCH-UPLOADS `cut -d " " -f 2 batch_uploads_dr.txt | awk '{ sum += $1 } END { print sum }'`" >> total2_dr.txt ; 
echo "SOLICITED-REVERSALS `cut -d " " -f 2 reversals_dr.txt | awk '{ sum += $1 } END { print sum }'`" >> total2_dr.txt ;
echo "UNSOLICITED-REVERSALS `cut -d " " -f 2 unsol_rev_dr.txt | awk '{ sum += $1 } END { print sum }'`" >> total2_dr.txt ;
echo "APPROVALS `cut -d " " -f 2 approvals_dr.txt | awk '{ sum += $1 } END { print sum }'`" >> total2_dr.txt ;
echo "DECLINES `cut -d " " -f 2 declines_dr.txt | awk '{ sum += $1 } END { print sum }'`" >> total2_dr.txt ;
echo "HANDSHAKES `cut -d " " -f 2 handshakes_dr.txt | awk '{ sum += $1 } END { print sum }'`" >> total2_dr.txt ;
echo "MAX-SESSIONS-zacnd `cut -d " " -f 2 sessions_dr1.txt | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'`" >> total2_dr.txt ;
echo "MAX-SESSIONS-zaccd `cut -d " " -f 2 sessions_dr2.txt | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'`" >> total2_dr.txt ;
echo "MAX-SESSIONS-DB-cache `cut -d " " -f 2 sessions_dr4.txt | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'`" >> total2_dr.txt ;
echo "MAX-SESSIONS-DB-shadow `cut -d " " -f 2 sessions_dr5.txt | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'` (sc=$syscenter)" >> total2_dr.txt ;
echo "MAX-BATCHES `cut -d " " -f 2 batch_closes_dr.txt | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'`" >> total2_dr.txt ;


msg_new_dr=$(cat total2_dr.txt);


rm  xa* [0-9][0-9].[0-9][0-9].*


rm ./Videos/*;
da=$(date -d "today" '+%d%m%Y');
unzip /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/LOGS/NEW_PR/$da?logs.zip -d ./Videos/;
cd;
cd ./Videos/;


datesource=zaccore_$(date -d "1 days ago 13:00" '+%Y-%m-%d');
datedest=$(date -d "1 days ago 13:00" '+%d.%m.%Y');
for i in `ls $datesource*.log`; do cat $i | LC_ALL=C grep 'Raw message \[bytes 0000-\|Unable to find reversal matching with key' >> /home/linux/$datedest;  done

cd;

dt=$(date -d "yesterday 13:00" '+%Y%m%d');
grep ^[[] ./Videos/memoryDiagnostics_$dt.log | cut -d " " -f 2 | cut -d "]" -f 1 | cut -d ":" -f 1-2 > dates.txt


while IFS='' read -r line || [[ -n "$line" ]]; 
do 
	if [[ $line == count\ of\ active\ zacnd\ processes* ]]; 
	then 
		flag1=1; 
		continue; 
	fi; 
	
	if [[ $flag1 -eq 1 ]]; 
	then  
		echo "$line" >> counts1.txt; 
		flag1=0; 
	fi; 
	
	if [[ $line == count\ of\ active\ zaccd\ processes* ]]; 
	then 
		flag2=1; 
		continue; 
	fi; 
	
	if [[ $flag2 -eq 1 ]]; 
	then  
		echo "$line" >> counts2.txt; 
		flag2=0; 
	fi; 
	
	if [[ $line == count\ of\ active\ postgres\ processes* ]]; 
	then 
		flag3=1; 
		continue; 
	fi; 
	
	if [[ $flag3 -eq 1 ]]; 
	then  
		echo "$line" >> counts3.txt; 
		flag3=0; 
	fi; 
		
	if [[ $line == count\ of\ active\ cache\ DB\ postgres\ connection\ processes* ]]; 
	then 
		flag4=1; 
		continue; 
	fi; 
	
	if [[ $flag4 -eq 1 ]]; 
	then  
		echo "$line" >> counts4.txt; 
		flag4=0; 
	fi; 
	
	if [[ $line == count\ of\ active\ shadow\ DB\ postgres\ connection\ processes* ]]; 
	then 
		flag5=1; 
		continue; 
	fi; 
	
	if [[ $flag5 -eq 1 ]]; 
	then  
		echo "$line" >> counts5.txt; 
		flag5=0; 
	fi; 
	
	if [[ $line == count\ of\ active\ shadow\ DB\ postgres\ connection\ for\ syscenter\ processes* ]]; 
	then 
		flag6=1; 
		continue; 
	fi; 
	
	if [[ $flag6 -eq 1 ]]; 
	then  
		echo "$line" >> counts6.txt; 
		flag6=0; 
	fi; 
done < ./Videos/memoryDiagnostics_$dt.log


paste -d" " dates.txt counts1.txt > datescounts1.txt
sort  -n -k 1 datescounts1.txt > sessions_pr1.txt


paste -d" " dates.txt counts2.txt > datescounts2.txt
sort  -n -k 1 datescounts2.txt > sessions_pr2.txt


paste -d" " dates.txt counts3.txt > datescounts3.txt
sort  -n -k 1 datescounts3.txt > sessions_pr3.txt


paste -d" " dates.txt counts4.txt > datescounts4.txt
sort  -n -k 1 datescounts4.txt > sessions_pr4.txt


paste -d" " dates.txt counts5.txt > datescounts5.txt
sort  -n -k 1 datescounts5.txt > sessions_pr5.txt


paste -d" " dates.txt counts6.txt > datescounts6.txt
sort  -n -k 1 datescounts6.txt > sessions_pr6.txt




grep ^Mem ./Videos/memoryDiagnostics_$dt.log | cut -d " " -f 13 > mem.txt
sed -e 's/$/ \/ 263579444 * 100/' -i mem.txt
while IFS='' read -r line || [[ -n "$line" ]]; 
do 
	echo "$line" | bc -l >> memo2; 
done < mem.txt
paste -d" " dates.txt memo2 > datesmem.txt
sort  -n -k 1 datesmem.txt > memory_pr.txt

rm dates* counts* mem.txt memo2 datesmem*



li=$(($(cat $datedest | wc -l) / 4 ));
split -l $li $datedest;


stamp1=`head -n 1 xaa | cut -d " " -f 2 |  cut -d "]" -f 1 | cut -d ":" -f 1-2 | tr -d ':';`;
stamp2=`head -n 1 xab | cut -d " " -f 2 |  cut -d "]" -f 1 | cut -d ":" -f 1-2 | tr -d ':';`;
stamp3=`head -n 1 xac | cut -d " " -f 2 |  cut -d "]" -f 1 | cut -d ":" -f 1-2 | tr -d ':';`;
stamp4=`head -n 1 xad | cut -d " " -f 2 |  cut -d "]" -f 1 | cut -d ":" -f 1-2 | tr -d ':';`;


i=j=0;
dt=$(date -d "yesterday 13:00" '+%d.%m.%Y');
for j in 0{0..9} {10..23} ; 
do 
	for i in 0{0..9} {10..59}
	do 
	
	
		if [ $stamp1 -le $j$i -a $stamp2 -gt $j$i ]; 
		then  
			path=xaa;
		fi
		if [ $stamp2 -le $j$i -a $stamp3 -gt $j$i ]; 
		then  
			path=xab; 
		fi
		if [ $stamp3 -le $j$i -a $stamp4 -gt $j$i ]; 
		then  
			path=xac; 
		fi
		if [ $stamp4 -le $j$i ]; 
		then  
			path=xad; 
		fi
	
	
		
	
		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Unable to find reversal matching with key' | wc -l;`;
		echo "$j:$i $c" >> unsol_rev_pr.txt

	
	
		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Raw message \[bytes 0000-.*.AO60' | wc -l;`;
		c=$(($c/2));
		echo "$j:$i $c" >> batch_closes_pr.txt
	


		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Raw message \[bytes 0000-.*.gUPLOAD REQUESTED' | wc -l;`;
		echo "$j:$i $c" >> batch_uploads_pr.txt




		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Raw message \[bytes 0000-.*.ISO[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]0420' | wc -l;`;
		echo "$j:$i $c" >> reversals_pr.txt
		
		
		
		
		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Raw message \[bytes 0000-.*.gDECLINED' | wc -l;`;
		echo "$j:$i $c" >> declines_pr.txt
		
		
		
		
		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Raw message \[bytes 0000-.*.gAPPROVED' | wc -l;`;
		echo "$j:$i $c" >> approvals_pr.txt
		
		

		
		c=`LC_ALL=C fgrep ''$dt' '$j':'$i'' $path | LC_ALL=C grep 'Raw message \[bytes 0000-.*.AO95' | wc -l;`;
		c=$(($c/2));
		echo "$j:$i $c" >> handshakes_pr.txt
		
		
	done
done


syscenter=`cut -d " " -f 2 sessions_pr6.txt | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'`

echo "BATCH-CLOSES `cut -d " " -f 2 batch_closes_pr.txt | awk '{ sum += $1 } END { print sum }'`" > total2_pr.txt ;
echo "BATCH-UPLOADS `cut -d " " -f 2 batch_uploads_pr.txt | awk '{ sum += $1 } END { print sum }'`" >> total2_pr.txt ; 
echo "SOLICITED-REVERSALS `cut -d " " -f 2 reversals_pr.txt | awk '{ sum += $1 } END { print sum }'`" >> total2_pr.txt ;
echo "UNSOLICITED-REVERSALS `cut -d " " -f 2 unsol_rev_pr.txt | awk '{ sum += $1 } END { print sum }'`" >> total2_pr.txt ;
echo "APPROVALS `cut -d " " -f 2 approvals_pr.txt | awk '{ sum += $1 } END { print sum }'`" >> total2_pr.txt ;
echo "DECLINES `cut -d " " -f 2 declines_pr.txt | awk '{ sum += $1 } END { print sum }'`" >> total2_pr.txt ;
echo "HANDSHAKES `cut -d " " -f 2 handshakes_pr.txt | awk '{ sum += $1 } END { print sum }'`" >> total2_pr.txt ;
echo "MAX-SESSIONS-zacnd `cut -d " " -f 2 sessions_pr1.txt | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'`" >> total2_pr.txt ;
echo "MAX-SESSIONS-zaccd `cut -d " " -f 2 sessions_pr2.txt | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'`" >> total2_pr.txt ;
echo "MAX-SESSIONS-DB-cache `cut -d " " -f 2 sessions_pr4.txt | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'`" >> total2_pr.txt ;
echo "MAX-SESSIONS-DB-shadow `cut -d " " -f 2 sessions_pr5.txt | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'` (sc=$syscenter)" >> total2_pr.txt ;
echo "MAX-BATCHES `cut -d " " -f 2 batch_closes_pr.txt | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {print max}'`" >> total2_pr.txt ;



msg_new_pr=$(cat total2_pr.txt);

gnuplot << EOF

set size 1,1
set terminal pdf
set term pdf size 10 , 4 


set output strftime('Daily_Report_%d-%m-%y.pdf', time(0))

unset timefmt
unset xdata
unset format x
set boxwidth 0.5
set style fill solid
plot "total.txt" using 2: xtic(1) title "CHANNEL TRXS" with boxes lc rgb 'orange'
plot "total2_pr.txt" using 2: xtic(1) title "ALL DAY REPORT - PRODUCTION" with boxes lc rgb 'blue'

set timefmt "%H:%M"
set xdata time
set format x "%H:%M"

set xtics "00:00",3500,"23:59"
unset yrange 

set yrange [0:1024]

plot "sessions_pr1.txt" using 1:2 title "SESSIONS ZACND- PRODUCTION" with lines lc rgb 'blue'

unset yrange 

set yrange [0:512]

plot "sessions_pr2.txt" using 1:2 title "SESSIONS ZACCD- PRODUCTION" with lines lc rgb 'blue'

plot "sessions_pr4.txt" using 1:2 title "SESSIONS DB cache- PRODUCTION" with lines lc rgb 'blue'

plot "sessions_pr5.txt" using 1:2 title "SESSIONS DB shadow- PRODUCTION" with lines lc rgb 'blue'

unset yrange 

plot "batch_closes_pr.txt" using 1:2 title "BATCH CLOSES - PRODUCTION" with lines lc rgb 'blue'


plot "handshakes_pr.txt" using 1:2 title "HANDSHAKES - PRODUCTION" with lines lc rgb 'blue'


plot "batch_uploads_pr.txt" using 1:2 title "BATCH UPLOADS - PRODUCTION" with lines lc rgb 'blue'


plot "unsol_rev_pr.txt" using 1:2 title "UNSOLICITED REVERSALS - PRODUCTION" with lines lc rgb 'blue'


plot "reversals_pr.txt" using 1:2 title "SOLICITED REVERSALS - PRODUCTION" with lines lc rgb 'blue'


plot "approvals_pr.txt" using 1:2 title "APPROVALS - PRODUCTION" with lines lc rgb 'blue'


plot "declines_pr.txt" using 1:2 title "DECLINES - PRODUCTION" with lines lc rgb 'blue'


unset timefmt
unset xdata
unset format x
set boxwidth 0.5
set style fill solid
plot "total2_dr.txt" using 2: xtic(1) title "ALL DAY REPORT - DISASTER" with boxes lc rgb 'red'

set timefmt "%H:%M"
set xdata time
set format x "%H:%M"

set xtics "00:00",3500,"23:59"
unset yrange 

set yrange [0:1024]

plot "sessions_dr1.txt" using 1:2 title "SESSIONS ZACND- DISASTER" with lines lc rgb 'red'

unset yrange 

set yrange [0:512]

plot "sessions_dr2.txt" using 1:2 title "SESSIONS ZACCD- DISASTER" with lines lc rgb 'red'

plot "sessions_dr4.txt" using 1:2 title "SESSIONS DB cache- DISASTER" with lines lc rgb 'red'

plot "sessions_dr5.txt" using 1:2 title "SESSIONS DB shadow- DISASTER" with lines lc rgb 'red'

unset yrange 

plot "batch_closes_dr.txt" using 1:2 title "BATCH CLOSES - DISASTER" with lines lc rgb 'red'


plot "handshakes_dr.txt" using 1:2 title "HANDSHAKES - DISASTER" with lines lc rgb 'red'


plot "batch_uploads_dr.txt" using 1:2 title "BATCH UPLOADS - DISASTER" with lines lc rgb 'red'


plot "unsol_rev_dr.txt" using 1:2 title "UNSOLICITED REVERSALS - DISASTER" with lines lc rgb 'red'


plot "reversals_dr.txt" using 1:2 title "SOLICITED REVERSALS - DISASTER" with lines lc rgb 'red'


plot "approvals_dr.txt" using 1:2 title "APPROVALS - DISASTER" with lines lc rgb 'red'


plot "declines_dr.txt" using 1:2 title "DECLINES - DISASTER" with lines lc rgb 'red'



unset output

EOF


mv Daily*.pdf ./pzac_reports/PZAC_Daily_Report_$dt.pdf
msg_rep=$(cat total.txt);

rm memory* xa* [0-9][0-9].[0-9][0-9].*
rm ./Videos/*;



msg="Good Morning,\n\nThis is the daily report from PowerZac for all day yesterday.Details below:\n\n***PZAPP1***\n$msg_new_pr\n\n***PZAPP2***\n$msg_new_dr\n\n***AUTHORIZATION STATISTICS PER PORT***\n$msg_rep\n\nThis is an automatically generated email, please do not reply.\n\nPowered by Ioannis Atlamazoglou"
email1=ioannis.atlamazoglou@cardlink.gr
email2=george.kokkinakis@cardlink.gr
email3=zeljko.zeravica@zmsinfo.hr
email4=iraklis.stratigis@cardlink.gr
email5=andreas.vlachiotis@cardlink.gr
email6=george.mousalis@cardlink.gr
email7=giorgos.panagiotou@cardlink.gr
email8=diagoras.vougas@cardlink.gr
email9=nikos.protopapadakis@cardlink.gr
email10=antonis.floros@cardlink.gr

echo -e "$msg" | mutt -s "PZAC Daily Report for $dt" -a ./pzac_reports/PZAC_Daily_Report_$dt.pdf -- $email1 $email2 $email3 $email4 $email5 $email6 $email7 $email8 $email9 $email10 



paste sessions_pr1.txt sessions_pr2.txt sessions_pr3.txt sessions_pr4.txt sessions_pr5.txt sessions_pr6.txt sessions_dr1.txt sessions_dr2.txt sessions_dr3.txt sessions_dr4.txt sessions_dr5.txt sessions_dr6.txt batch_closes_pr.txt batch_closes_dr.txt handshakes_pr.txt handshakes_dr.txt batch_uploads_pr.txt batch_uploads_dr.txt unsol_rev_pr.txt unsol_rev_dr.txt reversals_pr.txt reversals_dr.txt approvals_pr.txt approvals_dr.txt declines_pr.txt declines_dr.txt -d ";" > trx_stats

dt=$(date -d "today" '+%Y%m%d');
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_sec.$dt.txt | head -n 3 | tail -n 1 > trx_per
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_min.$dt.txt | head -n 3 | tail -n 1 >> trx_per
cat /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/report_trx_per_hour.$dt.txt | head -n 3 | tail -n 1 >> trx_per


python3.8 ./Downloads/daily_report_feed.py
python3.8 ./Downloads/ionix_parser_\&_db_feed.py

rm ionix* total* trx* unsol_rev* approvals* reversals* batch_uploads* batch_closes* handshakes* declines* sessions* xa* [0-9][0-9].[0-9][0-9].*


./Downloads/get_pzac_report.sh