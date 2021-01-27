import re
import mysql.connector
from operator import itemgetter
cnx = mysql.connector.connect(user='root', password='root', host= '127.0.0.1', database='ionix')
x = cnx.cursor(buffered=True)
from datetime import datetime, date, timedelta
import pytz
local_tz = pytz.timezone ("Europe/Athens")


def datetime_converter(x):
    temp = int(x.strip('"'))
    y = datetime.fromtimestamp(temp, local_tz).strftime('%Y-%m-%d %H:%M:%S')
    return y

def parse(filepath):

    data = []
    with open(filepath, 'r') as file:
        line = file.readline()
        while line:
            reg_match = _RegExLib(line)

            if reg_match.data_type:
                server = reg_match.data_type.group(1)
                data_type = reg_match.data_type.group(2)



            if reg_match.data:
                line = file.readline()
                data_list=[]
                while line.strip():
                    timestamp, value = line.strip().split(',')
                    value = value.strip('"')
                    value = float(value)
                    timestamp2 = datetime_converter(timestamp)
                    data_list.append((timestamp2,value))
                    line = file.readline()

                dict_of_data = {
                    'server': server,
                    'data_type': data_type,
                    'data': data_list,
                }
                data.append(dict_of_data)

            line = file.readline()

    return data


class _RegExLib:
    """Set up regular expressions"""
    _reg_data_type = re.compile('.*\((\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\)/(.*\))')
    _reg_name_score = re.compile('"Timestamp",("CPU Utilization \(%\)"|"Real Utilization"|"CurrentUtilization \(%\)")')

    def __init__(self, line):
        # check whether line has a positive match with all of the regular expressions
        self.data_type = self._reg_data_type.match(line)
        self.data = self._reg_name_score.search(line)


if __name__ == '__main__':
    filepath = 'ionix.csv'
    data = parse(filepath)

    PZAPP1 = '167.16.161.232'
    PZDB1 = '167.16.162.49'
    PZAPP2 = '170.186.14.152'
    PZDB2 = '170.186.245.163'

    max_cpu_pzapp1, max_mem_pzapp1, max_disk_pzapp1, max_cpu_pzdb1, max_cpu_pzapp2, max_mem_pzapp2, max_disk_pzapp2, max_cpu_pzdb2 = 0, 0, 0, 0, 0, 0, 0, 0



    for i in data:
        if i['server'] == PZAPP1:
            if i['data_type'] == 'CPU Utilization (%)':
                try:
                    max_cpu_pzapp1 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzapp1_cpu (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzapp1_cpu error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == 'Memory used (%)':
                try:
                    max_mem_pzapp1 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzapp1_mem (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzapp1_mem error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == 'Filesystem Utilization /  (%)':
                try:
                    max_disk_pzapp1 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzapp1_disk (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzapp1_disk error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == 'FileSystem Utilization /run (%)':
                try:
                    max_disk_run_pzapp1 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzapp1_disk_run (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzapp1_disk_run error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == 'FileSystem Utilization /ramfs (%)':
                try:
                    max_disk_ramfs_pzapp1 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzapp1_disk_ramfs (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzapp1_disk_ramfs error db insert", error)
                    cnx.rollback()

        elif i['server'] == PZDB1:
            if i['data_type'] == 'CPU Utilization (%)':
                try:
                    max_cpu_pzdb1 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzdb1_cpu (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzdb1_cpu error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == 'Memory used (%)':
                try:
                    max_mem_pzdb1 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzdb1_mem (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzdb1_mem error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == 'Filesystem Utilization /  (%)':
                try:
                    max_disk_pzdb1 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzdb1_disk (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzdb1_disk error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == 'FileSystem Utilization /oracle1 (%)':
                try:
                    max_oracle1_pzdb1 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzdb1_disk_oracle (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzdb1_disk_oracle error db insert", error)
                    cnx.rollback()

        elif i['server'] == PZAPP2:
            if i['data_type'] == 'CPU Utilization (%)':
                try:
                    max_cpu_pzapp2 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzapp2_cpu (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzapp2_cpu error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == 'Memory used (%)':
                try:
                    max_mem_pzapp2 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzapp2_mem (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzapp2_mem error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == 'Filesystem Utilization /  (%)':
                try:
                    max_disk_pzapp2 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzapp2_disk (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzapp2_disk error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == 'FileSystem Utilization /run (%)':
                try:
                    max_disk_run_pzapp2 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzapp2_disk_run (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzapp2_disk_run error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == 'FileSystem Utilization /ramfs (%)':
                try:
                    max_disk_ramfs_pzapp2 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzapp2_disk_ramfs (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzapp2_disk_ramfs error db insert", error)
                    cnx.rollback()

        elif i['server'] == PZDB2:
            if i['data_type'] == 'CPU Utilization (%)':
                try:
                    max_cpu_pzdb2 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzdb2_cpu (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzdb2_cpu error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == 'Memory used (%)':
                try:
                    max_mem_pzdb2 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzdb2_mem (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzdb2_mem error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == "File system Utilization '/dev/mapper/rhel_pzarch2-oracle on /oracle' (%)":
                try:
                    max_oracle_pzdb2 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzdb2_disk_oracle (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzdb2_disk_oracle error db insert", error)
                    cnx.rollback()
            elif i['data_type'] == "FileSystem Utilization '/dev/mapper/oracle1_pzarch2-oracle1_lv on /oracle1' (%)":
                try:
                    max_oracle1_pzdb2 = max(i['data'], key=itemgetter(1))[1]
                    stmn = "INSERT INTO pzdb2_disk_oracle1 (dt, value ) VALUES (%s, %s)"
                    x.executemany(stmn, i['data'])
                    cnx.commit()
                except Exception as error:
                    print("pzdb2_disk_oracle1 error db insert", error)
                    cnx.rollback()

    dt = date.today() - timedelta(days=1)
    dt.strftime('%m%d%y')

    try:
        stmn = "INSERT INTO pzac_statistics (dt, max_cpu_pzapp1, max_mem_pzapp1, max_disk_pzapp1, max_cpu_pzdb1, " \
               "max_cpu_pzapp2, max_mem_pzapp2, max_disk_pzapp2, max_cpu_pzdb2 ) " \
               "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
        x.execute(stmn, [dt, max_cpu_pzapp1, max_mem_pzapp1, max_disk_pzapp1, max_cpu_pzdb1,
                         max_cpu_pzapp2, max_mem_pzapp2, max_disk_pzapp2, max_cpu_pzdb2])
        cnx.commit()
    except Exception as error:
        print("pzac_statistics error db insert", error)
        cnx.rollback()