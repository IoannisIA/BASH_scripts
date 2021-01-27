import mysql.connector
cnx = mysql.connector.connect(user='root', password='root', host= '127.0.0.1', database='zac')
x = cnx.cursor(buffered=True)


def insert_to_db():

    try:

        stmt = "INSERT INTO sync (datetime, keyss, updated, inserted, deleted, " \
               "totaldur, seldur, upddur, instdur, deldur, updlg1dur, updlg2dur)  " \
               "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

        x.executemany(stmt, list_buffer)

        cnx.commit()

    except Exception as error:

        print("list_buffer error db insert",error)

        cnx.rollback()

    list_buffer.clear()


list_buffer = []*1000
details_dict = {}
with open("zacsync.csv") as file:
    line = file.readline()

    while line:
        line = line.split("-")
        if len(line) == 6:
            details = line[5].split(" ")
            if len(details) > 41:

                details_dict[details[2]] = details[5]
                details_dict[details[6]] = details[8]
                details_dict[details[9]] = details[11]
                details_dict[details[12] + details[13]] = details[15]
                details_dict[details[16] + details[17]] = details[19]
                details_dict[details[20] + details[21]] = details[23]
                details_dict[details[24] + details[25]] = details[27]
                details_dict[details[28] + details[29]] = details[31]
                details_dict[details[32] + details[33]] = details[35]
                details_dict[details[36] + details[37]] = details[39]
                details_dict[details[40] + details[41]] = details[43].strip('\n')

                datetime = line[0][6:10]+line[0][3:5]+line[0][0:2]+line[0][12:14]+line[0][15:17]+line[0][18:20]
                table = line[1].strip(' ')
                source = line[2].strip(' ')
                dest = line[3].strip(' ')
                description = line[4].strip(' ')
                keyss = table+"-"+source+"-"+dest+" - "+description

                list_buffer.append((datetime, keyss, details_dict['Updated'],
                                    details_dict['Inserted']
                                    , details_dict['Deleted'], details_dict['TotalDur.']
                                    , details_dict['Sel.Dur.'], details_dict['Upd.Dur.'], details_dict['Inst.Dur.']
                                    , details_dict['Del.Dur.'], details_dict['UpdLg1.Dur.'], details_dict['UpdLg2.Dur.']))

                details_dict.clear()
                if len(list_buffer) == 1000:
                    insert_to_db()

        line = file.readline()


file.close()
x.close()
