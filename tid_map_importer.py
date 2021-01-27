import mysql.connector
from mysql.connector import cursor

cnx = mysql.connector.connect(user='root', password='root', host= '127.0.0.1', database='report')

x = cnx.cursor()

x.execute("TRUNCATE TABLE tid_map")

line_counter = bad_buffer_inserts = final_buffer_inserts = bad_insert_database = 0

list_buffer = []*1000



def insert_to_db():

    global bad_insert_database

    try:

        stmt = "INSERT INTO tid_map (tid, mid, vtid, vmid, acq, trx_prof) VALUES (%s, %s, %s, %s, %s, %s)"

        x.executemany(stmt, list_buffer)

        cnx.commit()

    except Exception as e:

        print(e)

        bad_insert_database = bad_insert_database + 1
        print(list_buffer)

        cnx.rollback()


with open("/home/linux/tid_map_file_import.txt") as fd:
    line = fd.readline()


    while line:

        end_file_check = line[0:1]

        if end_file_check == '(':

            insert_to_db()

            break

        if line_counter >= 2:

            tid = line[1:9]
            mid = line[15:25]
            vtid = line[29:37]
            vmid = line[46:56]
            acq = line[64:78]
            trx_prof = line[188:213]

            if not (tid.isspace() or mid.isspace() or vtid.isspace() or vmid.isspace()):


                try:

                    if isinstance(int(tid),int) and isinstance(int(mid),int) and isinstance(int(vtid),int) and isinstance(int(vmid),int) :

                        list_buffer.append((tid.strip(), mid.strip(), vtid.strip(), vmid.strip(), acq.strip(), trx_prof.strip()))

                        final_buffer_inserts = final_buffer_inserts + 1


                except:

                    print(tid, mid, vtid, vmid)

                    bad_buffer_inserts = bad_buffer_inserts +1

            else:

                bad_buffer_inserts = bad_buffer_inserts + 1




        if len(list_buffer) == 1000 :

            insert_to_db()

            list_buffer.clear()


        line_counter += 1

        line = fd.readline()


cnx.close()

print('Final lines inserted / Total lines of the file: ',final_buffer_inserts,'/', (line_counter-2))
print('Number of error - inserts into the buffer: ',bad_buffer_inserts)
print('Number of error - batch inserts into the DB: ',bad_insert_database)

