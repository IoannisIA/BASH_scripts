#!/bin/bash








zacrep_file=report.$(date -d "today" '+%Y%m%d').txt

cp /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/ZAC_REP/$zacrep_file ./tid_map_file_import.txt;

echo  "[`date`] Starting Tid_Mid Mapping importing ..." >> logs

python3.6 ./Downloads/tid_map_importer.py >> logs

rm -f tid_map_file_import.txt


echo  "[`date`] Finished Tid_Mid Mapping importing ..." >> logs











nbg_file=CARDLINK_SETLF01_$(date -d "today" '+%y%m%d')_??????.TXT

cp /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/Settlement\ Files/NBG/$nbg_file ./settlement_type_nbg.txt;

echo  "[`date`] Starting NBG settlement importing ..." >> logs

python3.6 ./Downloads/settlement_type_nbg_importer.py >> logs

rm -f settlement_type_nbg.txt

echo  "[`date`] Finished NBG settlement importing ..." >> logs










pir_file=Cardlink_$(date -d "yesterday" '+%y%m%d').txt

cp /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/Settlement\ Files/Piraeus/$pir_file ./settlement_type_piraeus.txt;

echo  "[`date`] Starting Piraeus settlement importing ..." >> logs

python3.6 ./Downloads/settlement_type_piraeus_importer.py >> logs

rm -f settlement_type_piraeus.txt

echo  "[`date`] Finished Piraeus settlement importing ..." >> logs










euro_file=ONEPOS$(date -d "today" '+%Y%m%d').TXT

cp /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/Settlement\ Files/Eurobank/$euro_file ./settlement_type_alpha_euro_attica.txt;

echo  "[`date`] Starting Eurobank settlement importing ..." >> logs

python3.6 ./Downloads/settlement_type_alpha_euro_attica_importer.py >> logs

rm -f settlement_type_alpha_euro_attica.txt

echo  "[`date`] Finished Eurobank settlement importing ..." >> logs










euro_file=ONEPOSCUP$(date -d "today" '+%m%d')????.TXT

cp /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/Settlement\ Files/Eurobank/$euro_file ./settlement_type_alpha_euro_attica.txt;

echo  "[`date`] Starting Eurobank CUP settlement importing ..." >> logs

python3.6 ./Downloads/settlement_type_alpha_euro_attica_importer.py >> logs

rm -f settlement_type_alpha_euro_attica.txt

echo  "[`date`] Finished Eurobank CUP settlement importing ..." >> logs












attica_file=atticabank$(date -d "today" '+%m%d')????

cp /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/Settlement\ Files/Attica/$attica_file ./settlement_type_alpha_euro_attica.txt;

echo  "[`date`] Starting Attica settlement importing ..." >> logs

python3.6 ./Downloads/settlement_type_alpha_euro_attica_importer.py >> logs

rm -f settlement_type_alpha_euro_attica.txt

echo  "[`date`] Finished Attica settlement importing ..." >> logs













alpha_file=alphabank$(date -d "today" '+%m%d')????

cp /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/Settlement\ Files/Alpha\ Bank/$alpha_file ./settlement_type_alpha_euro_attica.txt;

echo  "[`date`] Starting Alpha settlement importing ..." >> logs

python3.6 ./Downloads/settlement_type_alpha_euro_attica_importer.py >> logs

rm -f settlement_type_alpha_euro_attica.txt

echo  "[`date`] Finished Alpha settlement importing ..." >> logs









alpha_file=alphabankCUP_$(date -d "today" '+%y%m%d').txt

cp /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/Settlement\ Files/Alpha\ Bank/$alpha_file ./settlement_type_alpha_euro_attica.txt;

echo  "[`date`] Starting Alpha CUP settlement importing ..." >> logs

python3.6 ./Downloads/settlement_type_alpha_euro_attica_importer.py >> logs

rm -f settlement_type_alpha_euro_attica.txt

echo  "[`date`] Finished Alpha CUP settlement importing ..." >> logs














alpha_file=alphabankamex$(date -d "today" '+%m%d')????

cp /mnt/share/Common\ Tasks/FTP-Data/FDH-IncomingData/Settlement\ Files/Alpha\ Bank/$alpha_file ./settlement_type_alpha_euro_attica.txt;

perl -pi.back -e 's/AH      ALPHA/AH      EURO AMEX/g;' settlement_type_alpha_euro_attica.txt

echo  "[`date`] Starting Eurobank (alpha_amex) settlement importing ..." >> logs

python3.6 ./Downloads/settlement_type_alpha_euro_attica_importer.py >> logs

rm -f settlement_type_alpha_euro_attica.txt*

echo  "[`date`] Finished Eurobank (alpha_amex) settlement importing ..." >> logs






















#msg="mail, please do not reply.\n\nIoannis Atlamazoglou"
#email1=ioannis.atlamazoglou@cardlink.gr



#echo -e $msg | mail -s "PZAC Daily Monitoring_$dt" $email1 $email4 $email5 $email2 $email3 $email6 $email7 $email9 $email10 $email11 $email13 $email16 $email17 $email18 $email19 -A ./pzac_reports/PZAC_Daily_Report_$dt.pdf
