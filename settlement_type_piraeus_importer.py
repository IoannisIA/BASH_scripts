import mysql.connector
from mysql.connector import cursor

cnx = mysql.connector.connect(user='root', password='root', host= '127.0.0.1', database='report')

x = cnx.cursor(buffered=True)

dict_buffer_terminal_batch = dict()
dict_buffer_merchant_terminals = dict()
dict_buffer_batch = dict()
dict_buffer_terminal = dict()
dict_buffer_merchant = dict()
list_buffer_merchant = []*1000
list_buffer_terminal = []*1000
list_buffer_batch = []*1000
list_buffer_trxs = []*1000
merchants_inserts = terminals_inserts = batches_inserts = trxs_inserts = 0
merchants_buff_inserts = terminals_buff_inserts = batches_buff_inserts = trxs_buff_inserts = 0


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


    for i in dict_buffer_batch:

        global batches_inserts
        global batches_buff_inserts
        batches_inserts = batches_inserts + 1
        batch_id = i
        tid = dict_buffer_batch[i]['tid']
        mid = dict_buffer_batch[i]['mid']
        acq_name = dict_buffer_batch[i]['batch_acq']
        batch_datetime = dict_buffer_batch[i]['batch_datetime']
        batch_num = dict_buffer_batch[i]['batch_num']
        batch_currency = dict_buffer_batch[i]['batch_cur']
        batch_trx_count = dict_buffer_batch[i]['batch_trx_count']
        batch_credits = dict_buffer_batch[i]['batch_credits']
        batch_credits_total = dict_buffer_batch[i]['batch_credits_total']
        batch_debits = dict_buffer_batch[i]['batch_debits']
        batch_debits_total = dict_buffer_batch[i]['batch_debits_total']
        batch_net_amount = dict_buffer_batch[i]['batch_net_amount']



        try:

            list_buffer_batch.append((batch_id, tid, mid, acq_name, batch_datetime, batch_num,
                                      batch_currency, batch_credits, batch_credits_total, batch_debits,
                                      batch_debits_total,
                                      batch_trx_count, batch_net_amount))

            batches_buff_inserts = batches_buff_inserts + 1

        except Exception as error:

            print("error insert batch into list buffer with batch id :", batch_id,error)

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


    for i in dict_buffer_terminal:

        global terminals_inserts
        global terminals_buff_inserts
        terminals_inserts = terminals_inserts + 1
        tid = i
        key = dict_buffer_terminal[i]['key']
        tid_batch_count = len(dict_buffer_terminal_batch[tid])
        mid = dict_buffer_terminal[i]['terminal_mid']
        tid_currency = dict_buffer_terminal[i]['terminal_cur']
        tid_trx_count = dict_buffer_terminal[i]['terminal_trx_count']
        tid_credits = dict_buffer_terminal[i]['terminal_credits']
        tid_credits_total = dict_buffer_terminal[i]['terminal_credits_total']
        tid_debits = dict_buffer_terminal[i]['terminal_debits']
        tid_debits_total = dict_buffer_terminal[i]['terminal_debits_total']
        tid_net_amount = dict_buffer_terminal[i]['terminal_net_amount']

        try:

            list_buffer_terminal.append((
                        key,tid, mid, tid_batch_count, tid_currency, tid_credits, tid_credits_total, tid_debits,
                        tid_debits_total, tid_trx_count, tid_net_amount))

            terminals_buff_inserts = terminals_buff_inserts + 1

        except Exception as error:

            print("error insert terminal into list buffer with tid :", tid,error)

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

    for i in dict_buffer_merchant:

        global merchants_inserts
        global merchants_buff_inserts

        merchants_inserts = merchants_inserts + 1
        key = dict_buffer_merchant[i]['key']
        mid = i
        mid_name = dict_buffer_merchant[i]['mid_name']
        mid_currency = dict_buffer_merchant[i]['mid_cur']
        mid_tid_count = len(dict_buffer_merchant_terminals[mid])
        mid_credits = dict_buffer_merchant[i]['mid_credits']
        mid_credits_total = dict_buffer_merchant[i]['mid_credits_total']
        mid_debits = dict_buffer_merchant[i]['mid_debits']
        mid_debits_total = dict_buffer_merchant[i]['mid_debits_total']
        mid_trx_count = dict_buffer_merchant[i]['mid_trx_count']
        mid_net_amount = dict_buffer_merchant[i]['mid_net_amount']


        try:

            list_buffer_merchant.append((key,mid, mid_name, acq_name, file_settl_date, mid_tid_count, mid_currency, mid_credits,
                                         mid_credits_total, mid_debits, mid_debits_total, mid_trx_count, mid_net_amount))

            merchants_buff_inserts = merchants_buff_inserts + 1

        except Exception as error:

            print("error insert merchant into list buffer with mid :", mid,error)



    try:

        stmt = "INSERT INTO merchant (merchant_id,mid, mid_name, mid_acq, mid_settl_date, mid_tid_count, mid_currency, mid_credits, mid_credits_total, mid_debits, mid_debits_total, mid_trx_count, mid_net_amount) " \
               "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

        x.executemany(stmt, list_buffer_merchant)

        cnx.commit()

    except Exception as error:

        print("merchants error db insert",error)

        cnx.rollback()

    list_buffer_merchant.clear()







with open("/home/linux/settlement_type_piraeus.txt") as fd:
    line = fd.readline()

    while line:
        row_type = line[0:2]


        if row_type == '01':

            file_settl_date = line[5:9]+line[11:13]+line[9:11]

            if line[2:5] == '002':
                acq_name = "PIRAEUS"



        if row_type == '02':

            trxs_inserts = trxs_inserts + 1

            vmid = line[191:200].strip()

            mid_name = 'null'

            try:

                mid = merchant_map_dict[vmid]

            except Exception as error:

                print("Physical merchant id not found for this virtual mid: ", vmid,error)
                mid = "1111111111"





            vtid = line[181:189].strip()

            try:

                tid = terminal_map_dict[vtid]

            except Exception as error:

                print("Physical terminal id not found for this virtual tid: ", vtid,error)
                tid = "11111111"





            batch_num = line[71:74]
            batch_datetime = file_settl_date





            if line[143:144] == 'D':
                trx_type = 'PURCHASE'
            elif line[143:144] == 'C':
                trx_type = 'REFUND'
            else:
                trx_type = 'N/A'


            pan1 = line[2:21].strip()
            pan = pan1[:6]+"*****"+pan1[-4:]
            exp_date = line[21:25]+'01'
            if exp_date[2:4] == "00":
                exp_date = line[21:23]+"0101"
            trx_datetime = line[34:42]+line[278:284]
            trx_amount = int(line[42:57])/100
            rrn = "111111111"
            auth_code = line[60:66]



            check_bin = int(pan[0:2])

            if check_bin in [40,41,42,43,44,45,46,47,48,49]:
                card_type = "Visa"
            elif check_bin == 34 or check_bin == 37:
                card_type = "Amex"
            elif check_bin == 30 or check_bin == 36 or check_bin == 38:
                card_type = "Diners"
            elif check_bin >= 51 and check_bin <= 55:
                card_type = "Mastercard"
            elif check_bin in [60,61,63,64,65,66,67,68,69] or check_bin == 50 or (check_bin >= 56 and check_bin <= 58):
                card_type = "Maestro"
            elif check_bin == 35:
                card_type = "JCB"
            elif check_bin == 62:
                card_type = "CUP"
            else:
                card_type = "UNKNOWN"






            if line[85:87] == '90':
                entry_mode = 'SWIPED'
            elif line[85:87] == '01':
                entry_mode = 'MANUAL'
            elif line[85:87] == '05':
                entry_mode = 'ICC'
            elif line[85:87] == '07':
                entry_mode = 'CTLS'
            else:
                entry_mode = 'N/A'



            if line[109:110] == 'Y':
                ident_method = 'PIN'
            elif line[109:110] == 'N':
                ident_method = 'NO PIN'
            else:
                ident_method = 'N/A'



            if line[190:191] == '1':
                auth_method = 'ONLINE'
            elif line[190:191] == '3':
                auth_method = 'OFFLINE'
            else:
                auth_method = 'N/A'

            install = line[57:60]




            if (tid+batch_num+file_settl_date+"2") in dict_buffer_batch:
                dict_buffer_batch[tid+batch_num+file_settl_date+"2"]["batch_trx_count"] += 1
                if trx_type == "PURCHASE" :
                    dict_buffer_batch[tid+batch_num+file_settl_date+"2"]["batch_debits"] += 1
                    dict_buffer_batch[tid+batch_num+file_settl_date+"2"]["batch_debits_total"] += trx_amount
                    dict_buffer_batch[tid+batch_num+file_settl_date+"2"]["batch_net_amount"] += trx_amount
                else:
                    dict_buffer_batch[tid+batch_num+file_settl_date+"2"]["batch_credits"] += 1
                    dict_buffer_batch[tid+batch_num+file_settl_date+"2"]["batch_credits_total"] += trx_amount
                    dict_buffer_batch[tid+batch_num+file_settl_date+"2"]["batch_net_amount"] -= trx_amount

            else:

                if trx_type == "PURCHASE":
                    dict_buffer_batch.setdefault(tid+batch_num+file_settl_date+"2",
                        {"batch_trx_count": 1, "mid": mid, "tid": tid, "batch_acq": acq_name, "batch_num": batch_num,
                         "batch_cur": "978", "batch_datetime": batch_datetime, "batch_credits": 0, "batch_credits_total": 0,
                         "batch_debits": 1, "batch_debits_total": trx_amount, "batch_net_amount": trx_amount})
                else:
                    dict_buffer_batch.setdefault(tid+batch_num+file_settl_date+"2",
                        {"batch_trx_count": 1, "mid": mid, "tid": tid, "batch_acq": acq_name, "batch_num": batch_num,
                         "batch_cur": "978", "batch_datetime": batch_datetime, "batch_credits": 1, "batch_credits_total": trx_amount,
                         "batch_debits": 0, "batch_debits_total": 0, "batch_net_amount": -trx_amount})






            if tid in dict_buffer_terminal_batch:

                if not batch_num in dict_buffer_terminal_batch[tid]:

                    dict_buffer_terminal_batch[tid].append(batch_num)
            else:

                dict_buffer_terminal_batch.setdefault(tid, [batch_num])






            if mid in dict_buffer_merchant_terminals:

                if not tid in dict_buffer_merchant_terminals[mid]:

                    dict_buffer_merchant_terminals[mid].append(tid)
            else:

                dict_buffer_merchant_terminals.setdefault(mid, [tid])


		    


            if tid in dict_buffer_terminal:
                dict_buffer_terminal[tid]["terminal_trx_count"] += 1
                if trx_type == "PURCHASE" :
                    dict_buffer_terminal[tid]["terminal_debits"] += 1
                    dict_buffer_terminal[tid]["terminal_debits_total"] += trx_amount
                    dict_buffer_terminal[tid]["terminal_net_amount"] += trx_amount
                else:
                    dict_buffer_terminal[tid]["terminal_credits"] += 1
                    dict_buffer_terminal[tid]["terminal_credits_total"] += trx_amount
                    dict_buffer_terminal[tid]["terminal_net_amount"] -= trx_amount

            else:

                if trx_type == "PURCHASE":
                    dict_buffer_terminal.setdefault(tid,
                        {"key": mid+file_settl_date+"2", "terminal_trx_count": 1, "terminal_mid": mid, "terminal_cur": "978", "terminal_credits": 0, "terminal_credits_total": 0,
                         "terminal_debits": 1, "terminal_debits_total": trx_amount, "terminal_net_amount": trx_amount})
                else:
                    dict_buffer_terminal.setdefault(tid,
                        {"key": mid+file_settl_date+"2", "terminal_trx_count": 1, "terminal_mid": mid, "terminal_cur": "978", "terminal_credits": 1, "terminal_credits_total": trx_amount,
                         "terminal_debits": 0, "terminal_debits_total": 0, "terminal_net_amount": -trx_amount})





            if mid in dict_buffer_merchant:
                dict_buffer_merchant[mid]["mid_trx_count"] += 1
                if trx_type == "PURCHASE" :
                    dict_buffer_merchant[mid]["mid_debits"] += 1
                    dict_buffer_merchant[mid]["mid_debits_total"] += trx_amount
                    dict_buffer_merchant[mid]["mid_net_amount"] += trx_amount
                else:
                    dict_buffer_merchant[mid]["mid_credits"] += 1
                    dict_buffer_merchant[mid]["mid_credits_total"] += trx_amount
                    dict_buffer_merchant[mid]["mid_net_amount"] -= trx_amount

            else:

                if trx_type == "PURCHASE":
                    dict_buffer_merchant.setdefault(mid,
                        {"key": mid+file_settl_date+"2", "mid_trx_count": 1, "mid_name": mid_name, "mid_cur": "978", "mid_credits": 0, "mid_credits_total": 0,
                         "mid_debits": 1, "mid_debits_total": trx_amount, "mid_net_amount": trx_amount})
                else:
                    dict_buffer_merchant.setdefault(mid,
                        {"key": mid+file_settl_date+"2", "mid_trx_count": 1, "mid_name": mid_name, "mid_cur": "978", "mid_credits": 1, "mid_credits_total": trx_amount,
                         "mid_debits": 0, "mid_debits_total": 0, "mid_net_amount": -trx_amount})






            if len(list_buffer_trxs) == 1000:

                insert_trxs()



            try:

                list_buffer_trxs.append((tid+batch_num+file_settl_date+"2", trx_type, pan, exp_date, trx_datetime, trx_amount, rrn, auth_code, card_type, entry_mode, ident_method, auth_method, install))

                trxs_buff_inserts = trxs_buff_inserts + 1

            except Exception as error:

                print("error insert trx into list buffer with datetime and auth code :",trx_datetime,auth_code,error)







        if row_type == '03':


            file_trx_count = line[2:12]



            insert_trxs()
            insert_batches()
            insert_terminals()
            insert_merchants()



        line = fd.readline()



x.close()
cnx.close()

print ("merchants found in total / actual buffer inserts :", merchants_inserts , merchants_buff_inserts)
print ("terminals found in total / actual buffer inserts :", terminals_inserts , terminals_buff_inserts)
print ("batches found in total / actual buffer inserts   :", batches_inserts , batches_buff_inserts)
print ("trxs found in total / actual buffer inserts      :", trxs_inserts , trxs_buff_inserts)



