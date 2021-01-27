import mysql.connector
from mysql.connector import cursor

cnx = mysql.connector.connect(user='root', password='root', host= '127.0.0.1', database='report')

x = cnx.cursor(buffered=True)

list_buffer_merchant = []*1000
list_buffer_terminal = []*1000
list_buffer_batch = []*1000
list_buffer_trxs = []*1000
merchants_inserts = terminals_inserts = batches_inserts = trxs_inserts = 0
merchants_buff_inserts = terminals_buff_inserts = batches_buff_inserts = trxs_buff_inserts = 0

bill_payment_flag = 0



query = ("SELECT vtid, tid FROM tid_map ")

x.execute(query)

terminal_map_list = x.fetchall()



query = ("SELECT vmid, mid FROM tid_map ")

x.execute(query)

merchant_map_list = x.fetchall()



terminal_map_dict = {i[0] : i[1] for i in terminal_map_list}

merchant_map_dict = {i[0] : i[1] for i in merchant_map_list}




def insert_trxs():

    try:

        stmt = "INSERT INTO trxs (batch_id, trx_type, pan, exp_date, trx_datetime, trx_amount, rrn, auth_code, card_type, entry_mode, ident_method, auth_method, install) " \
               "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

        x.executemany(stmt, list_buffer_trxs)

        cnx.commit()

    except Exception as error:

        print("trxs error db insert",error)

        cnx.rollback()

    list_buffer_trxs.clear()






def insert_batches():

    try:

        stmt = "INSERT INTO batch (batch_id, tid, mid, batch_acq, batch_datetime, batch_num, batch_currency, batch_credits, batch_credits_total, batch_debits, batch_debits_total, batch_trx_count, batch_net_amount) " \
               "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

        x.executemany(stmt, list_buffer_batch)

        cnx.commit()

    except Exception as error:

        print("batches error db insert",error)

        cnx.rollback()

    list_buffer_batch.clear()






def insert_terminals():

    try:

        stmt = "INSERT INTO terminal (merchant_id,tid, mid, tid_batch_count, tid_currency, tid_credits, tid_credits_total, tid_debits, tid_debits_total, tid_trx_count, tid_net_amount) " \
               "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

        x.executemany(stmt, list_buffer_terminal)

        cnx.commit()



    except Exception as error:

        print("terminals error db insert",error)

        cnx.rollback()

    list_buffer_terminal.clear()








def insert_merchants():

    try:

        stmt = "INSERT INTO merchant (merchant_id,mid, mid_name, mid_acq, mid_settl_date, mid_tid_count, mid_currency, mid_credits, mid_credits_total, mid_debits, mid_debits_total, mid_trx_count, mid_net_amount) " \
               "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

        x.executemany(stmt, list_buffer_merchant)

        cnx.commit()

    except Exception as error:

        print("merchants error db insert",error)

        cnx.rollback()

    list_buffer_merchant.clear()







with open("/home/linux/settlement_type_alpha_euro_attica.txt") as fd:
    line = fd.readline()

    while line:
        row_type = line[0:2]


        if row_type == 'FH':

            file_settl_date = line[7:15]



        if row_type == 'AH':

            if bill_payment_flag == 0:
                acq_name = line[8:19].strip()
            else:
                acq_name = line[8:19].strip()+"_BP"

            bill_payment_flag = 1
            if acq_name == "ALPHA CUP":
                acq_code = "4"
            elif acq_name == "ALPHA":
                acq_code = "5"
            elif acq_name == "ATTICA":
                acq_code = "6"
            elif acq_name == "EUROBANK":
                acq_code = "7"
            elif acq_name == "EUROBANKCUP":
                acq_code = "8"
            elif acq_name == "EUROBANK_BP":
                acq_code = "9"
                acq_name = "CORTEX"
            elif acq_name == "ALPHA_BP":
                acq_code = "10"
            elif acq_name == "EURO AMEX":
                acq_code = "11"
            else:
                acq_code = "12"
                acq_name = "CORTEX AMEX"



        if row_type == 'MH':

            vmid = line[8:18]

            mid_name = line[38:58]

            try:

                mid = merchant_map_dict[vmid]

            except Exception as error:

                print("Physical merchant id not found for this virtual mid: ", vmid,error)
                mid = "1111111111"



        if row_type == 'TH':

            vtid = line[38:46]

            try:

                tid = terminal_map_dict[vtid]

            except Exception as error:

                print("Physical terminal id not found for this virtual tid: ", vtid,error)
                tid = "11111111"



        if row_type == 'BH':

            batch_num = line[71:74]
            batch_datetime = line[84:98]









        if row_type == 'DR':

            trxs_inserts = trxs_inserts + 1

            if line[2:4] == '01':
                trx_type = 'PURCHASE'
            elif line[2:4] == '02':
                trx_type = 'REFUND'
            elif line[2:4] == '26':
                trx_type = 'REVERSAL'
            elif line[2:4] == '91':
                trx_type = 'PAYMENT'
            else:
                trx_type = 'N/A'


            pan1 = line[4:23].strip()
            pan = pan1[:6]+"*****"+pan1[-4:]
            exp_date = line[29:35]+"01"
            if exp_date[4:6] not in ['01' ,'02' ,'03' ,'04' ,'05' ,'06' ,'07' ,'08' ,'09' ,'10' ,'11' ,'12'] :
                exp_date = line[29:33]+"0101"
            trx_datetime = line[41:55]
            trx_amount = int(line[72:86])/100
            rrn = line[104:113]
            auth_code = line[138:144]
            card_type = line[144:164]

            if line[164:165] == 'D':
                entry_mode = 'SWIPED'
            elif line[164:165] == '':
                entry_mode = 'MANUAL'
            elif line[164:165] == 'E':
                entry_mode = 'ICC'
            elif line[164:165] == 'P':
                entry_mode = 'CTLS'
            else:
                entry_mode = 'N/A'


            if line[166:167] == '1':
                ident_method = 'SIGN'
            elif line[166:167] == '2':
                ident_method = 'PIN'
            elif line[166:167] == '3':
                ident_method = 'NO PIN'
            elif line[166:167] == '4':
                ident_method = 'MAIL'
            else:
                ident_method = 'N/A'



            if line[167:168] == '1':
                auth_method = 'ONLINE'
            elif line[167:168] == '3':
                auth_method = 'OFFLINE'
            elif line[167:168] == '5':
                auth_method = 'VOICE AUTH'
            else:
                auth_method = 'N/A'

            install = line[172:174]

            if len(list_buffer_trxs) == 1000:

                insert_trxs()



            try:

                list_buffer_trxs.append((tid+batch_num+file_settl_date+acq_code, trx_type, pan, exp_date, trx_datetime, trx_amount, rrn, auth_code, card_type, entry_mode, ident_method, auth_method, install))

                trxs_buff_inserts = trxs_buff_inserts + 1

            except Exception as error:

                print("error insert trx into list buffer with datetime and auth code :",trx_datetime,auth_code,error)










        if row_type == 'BT':

             batches_inserts = batches_inserts + 1

             batch_currency = line[98:101]
             batch_trx_count = line[101:107]
             batch_credits = line[107:113]
             batch_credits_total = int(line[113:131])/100
             batch_debits = line[131:137]
             batch_debits_total = int(line[137:155])/100
             batch_net_amount = int(line[155:176])/100

             if len(list_buffer_batch) == 1000:

                 insert_batches()


             try:

                list_buffer_batch.append((tid+batch_num+file_settl_date+acq_code, tid, mid, acq_name, batch_datetime, batch_num, batch_currency, batch_credits, batch_credits_total, batch_debits, batch_debits_total, batch_trx_count, batch_net_amount))

                batches_buff_inserts = batches_buff_inserts + 1

             except Exception as error:

                 print("error insert batch into list buffer with batch id :",tid+batch_num,error)






        if row_type == 'TT':

             terminals_inserts = terminals_inserts + 1

             tid_batch_count = line[68:74]
             tid_currency = line[74:77]
             tid_credits = line[77:83]
             tid_credits_total = int(line[83:101])/100
             tid_debits = line[101:107]
             tid_debits_total = int(line[107:125])/100
             tid_trx_count = line[125:131]
             tid_net_amount = int(line[131:152])/100

             if len(list_buffer_terminal) == 1000:

                 insert_terminals()


             try:

                list_buffer_terminal.append((mid+file_settl_date+acq_code,tid, mid, tid_batch_count, tid_currency, tid_credits, tid_credits_total, tid_debits, tid_debits_total, tid_trx_count, tid_net_amount))

                terminals_buff_inserts = terminals_buff_inserts + 1

             except Exception as error:

                 print("error insert terminal into list buffer with tid :", tid,error)












        if row_type == 'MT':

             merchants_inserts = merchants_inserts + 1

             mid_tid_count = line[38:44]
             mid_currency = line[44:47]
             mid_credits = line[47:53]
             mid_credits_total = int(line[53:71])/100
             mid_debits = line[71:77]
             mid_debits_total = int(line[77:95])/100
             mid_trx_count = line[95:101]
             mid_net_amount = int(line[101:122])/100

             if len(list_buffer_merchant) == 1000:

                 insert_merchants()


             try:

                list_buffer_merchant.append((mid+file_settl_date+acq_code,mid, mid_name, acq_name, file_settl_date, mid_tid_count, mid_currency, mid_credits, mid_credits_total, mid_debits, mid_debits_total, mid_trx_count, mid_net_amount))

                merchants_buff_inserts = merchants_buff_inserts + 1

             except Exception as error:

                 print("error insert merchant into list buffer with mid :", mid,error)







        if row_type == 'AT':

            acq_tid_count = line[8:14]
            acq_currency = line[14:17]
            acq_credits = line[17:23]
            acq_credits_total = int(line[23:41])/100
            acq_debits = line[41:47]
            acq_debits_total = int(line[47:65])/100
            acq_trx_count = line[65:71]
            acq_net_amount = int(line[71:92])/100

            try:
                x.execute("INSERT INTO acq (acq_name, acq_tid_count, acq_currency, acq_credits, acq_credits_total, acq_debits, acq_debits_total, acq_trx_count, acq_net_amount) "
                          "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
                          (acq_name, acq_tid_count, acq_currency, acq_credits, acq_credits_total, acq_debits, acq_debits_total, acq_trx_count, acq_net_amount))
                cnx.commit()
            except Exception as error:

                print(error)
                cnx.rollback()












        if row_type == 'FT':

            file_acq_count = line[2:8]
            file_currency = line[8:11]
            file_credits = line[11:18]
            file_credits_total = int(line[18:36])/100
            file_debits = line[36:43]
            file_debits_total = int(line[43:61])/100
            file_trx_count = line[61:68]
            file_net_amount = int(line[68:89])/100

            try:
                x.execute("INSERT INTO file_acq (file_settl_date, file_acq_count, file_currency, file_credits, file_credits_total, file_debits, file_debits_total, file_trx_count, file_net_amount) "
                          "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
                          (file_settl_date, file_acq_count, file_currency, file_credits, file_credits_total, file_debits, file_debits_total, file_trx_count, file_net_amount))
                cnx.commit()
            except Exception as error:
                print(error)
                cnx.rollback()


            insert_trxs()
            insert_batches()
            insert_terminals()
            insert_merchants()



        line = fd.readline()






x.close()
cnx.close()

print ("merchants found in total / actual buffer inserts :", merchants_inserts , merchants_buff_inserts)
print ("terminals found in total / actual buffer inserts :", terminals_inserts , terminals_buff_inserts)
print ("batches found in total   / actual buffer inserts :", batches_inserts , batches_buff_inserts)
print ("trxs found in total      / actual buffer inserts :", trxs_inserts , trxs_buff_inserts)
