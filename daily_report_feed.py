from datetime import datetime, timedelta
import mysql.connector
cnx = mysql.connector.connect(user='root', password='root', host= '127.0.0.1', database='zac')
x = cnx.cursor(buffered=True)

def insert_to_db():

    try:

        stmt = "INSERT INTO trx_stats (datetime, sessions_zacnd_pr, sessions_zaccd_pr, " \
               "sessions_postgres_pr, sessions_cache_DB_postgres_pr, sessions_shadow_DB_postgres_pr, " \
               "sessions_shadow_DB_postgres_syscenter_pr, sessions_zacnd_dr, sessions_zaccd_dr, " \
               "sessions_postgres_dr, sessions_cache_DB_postgres_dr, sessions_shadow_DB_postgres_dr, " \
               "sessions_shadow_DB_postgres_syscenter_dr, batch_closes_pr, batch_closes_dr, " \
               "handshakes_pr, handshakes_dr, batch_uploads_pr, batch_uploads_dr, unsol_pr, unsol_dr, " \
               "sol_pr, sol_dr, approvals_pr, approvals_dr, declines_pr, declines_dr)  " \
               "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

        x.executemany(stmt, list_buffer)

        cnx.commit()

    except Exception as error:

        print("list_buffer error db insert",error)

        cnx.rollback()

    list_buffer.clear()


list_buffer = [] * 1000


with open("trx_stats") as file:
    line = file.readline()

    while line:
        row = []
        time = line.split(';')[0].split(' ')[0]
        dt = (datetime.now() - timedelta(1)).strftime('%Y-%m-%d')+' '+time+':00'
        row.append(dt)
        for i in line.split(';'):
            row.append(i.split(' ')[1].strip())
        list_buffer.append(row)
        line = file.readline()
        if len(list_buffer) == 1000:
            insert_to_db()

    insert_to_db()
file.close()

list_buffer = [(datetime.now() - timedelta(1)).strftime('%Y-%m-%d')]

with open("total2_pr.txt") as file:
    line = file.readline()

    while line:
        list_buffer.append(line.split()[1].strip())
        line = file.readline()
file.close()


with open("total2_dr.txt") as file:
    line = file.readline()

    while line:
        list_buffer.append(line.split()[1].strip())
        line = file.readline()
file.close()

temp=[]
with open("total.txt") as file:
    line = file.readline()

    while line:
        temp.append(line.split()[1].strip())
        line = file.readline()
file.close()

if len(temp) < 9: temp.append('0')

list_buffer = list_buffer + temp

with open("trx_per") as file:
    line = file.readline()

    while line:
        list_buffer.append(line.split('|')[0].strip())
        list_buffer.append(line.split('|')[1].strip())
        line = file.readline()
file.close()


try:

    stmt = "INSERT INTO total_stats (dt, total_batch_closes_pr, total_batch_uploads_pr, total_sol_pr, total_usnol_pr, " \
           "total_approvals_pr, total_declines_pr, total_handshakes_pr, max_sessions_zacnd_pr, max_sessions_zaccd_pr, " \
           "max_sessions_cache_DB_postgres_pr, max_sessions_shadow_DB_postgres_pr_syscenter, " \
           "max_batches_pr, total_batch_closes_dr, " \
           "total_batch_uploads_dr, total_sol_dr, total_usnol_dr, total_approvals_dr, total_declines_dr, " \
           "total_handshakes_dr, max_sessions_zacnd_dr, max_sessions_zaccd_dr, " \
           "max_sessions_cache_DB_postgres_dr, max_sessions_shadow_DB_postgres_dr_syscenter, " \
           "max_batches_dr, SPDH_IN_2, SPDH_IN, SPDH_IN_3, BICISO_FDH, BICISO_IN, " \
           "BASE24_HCE_D, PIRAEUS_IN, VIVA_IN, STIP_IN, max_tps_datetime, max_tps, max_tpm_datetime, " \
           "max_tpm, max_tph_datetime, max_tph) " \
           "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s, %s, %s, %s, %s, %s, " \
           "%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

    x.execute(stmt, tuple(list_buffer))

    cnx.commit()

except Exception as error:

    print("list_buffer error db insert:", error)

    cnx.rollback()

x.close()

