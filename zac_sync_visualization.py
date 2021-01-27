from matplotlib.backends.backend_pdf import PdfPages
pdf_pages = PdfPages('zac_sync_daily_report.pdf')
import matplotlib.dates as mdates
import matplotlib.pyplot as plt
import mysql.connector
cnx = mysql.connector.connect(user='root', password='root', host='localhost', database='zac')
x = cnx.cursor(buffered=True)


def get_sync_from_db(task_to_be_get):
    stmn = ('select datetime, upddur, instdur, updlg1dur, seldur from sync '
              'where datetime >= NOW() - INTERVAL 1 DAY and keyss = %(keyss)s')
    x.execute(stmn, {'keyss': task_to_be_get})
    rows = x.fetchall()
    return rows


def plot_the_figure(rows, title):
    datetime_list = []
    updur = []
    instdur = []
    uplg1dur = []
    seldur = []
    global f
    for row in rows:
        datetime_list.append(mdates.date2num(row[0]))
        updur.append(row[1] / 1000)
        instdur.append(row[2] / 1000)
        uplg1dur.append(row[3] / 1000)
        seldur.append(row[4] / 1000)
    f = plt.figure()
    plt.title(title)
    plt.plot_date(x=datetime_list, y=updur, fmt='-', label='updur', linewidth=2)
    plt.plot_date(x=datetime_list, y=instdur, fmt='--', label='instdur', linewidth=2)
    plt.plot_date(x=datetime_list, y=seldur, fmt='-.', label='seldur', linewidth=2)
    plt.plot_date(x=datetime_list, y=uplg1dur, fmt='-', label='uplg1dur', linewidth=2)
    xformatter = mdates.DateFormatter('%H:%M')
    plt.gcf().axes[0].xaxis.set_major_formatter(xformatter)
    xlocator = mdates.MinuteLocator(byminute=[15, 30, 45, 60], interval=2)
    plt.gcf().axes[0].xaxis.set_major_locator(xlocator)
    plt.gcf().set_size_inches(15, 8)
    plt.xticks(rotation=30)
    plt.ylabel('Duration in seconds')
    plt.xlabel('Time')
    plt.legend(fancybox=True, shadow=True, loc='upper right')
    plt.grid(True)
    plt.show()
    plt.close()
    pdf_pages.savefig(f)


# Main program. You can add new figures adding both process and title in the bellow lists

task_list = ["trnlogw-cache1-cache2 - [zac1 ==> zac2]","trnlogw-cache1-cache2 - [zac2 ==> zac1]","trnlogw-new1-new2 - [zac1 ==> zac2]","eodlogw-new1-new2 - [pzac1 ==> pzac2]","eodsumw-new1-new2 - [pzac1 ==> pzac2]","trnlogw-new1-new2 - [zac2 ==> zac1]","eodlogw-new1-new2 - [pzac2 ==> pzac1]","eodsumw-new1-new2 - [pzac2 ==> pzac1]","trnlogw-new1-new_archive1 - [pzac1 ==> new_archive1]","eodlogw-new1-new_archive1 - [pzac1 ==> new_archive1]","eodsumw-new1-new_archive1 - [pzac1 ==> new_archive1]","eodlogw-new2-new_archive2 - [pzac1 ==> new_archive2]","eodsumw-new2-new_archive2 - [pzac1 ==> new_archive2]","trnlogw-new_archive1-dw - [arch1 ==> dw]","eodlogw-new_archive1-dw - [arch1 ==> dw]","eodsumw-new_archive1-dw - [arch1 ==> dw]","trnlogw-new_archive2-dw2 - [arch2 ==> dw2]","eodlogw-new_archive2-dw2 - [arch2 ==> dw2]","eodsumw-new_archive2-dw2 - [arch2 ==> dw2]","trnlogw-new2-new_archive2 - [pzac1 ==> new_archive2]"]
task_list_titles = ["PZAC Cache DB synchronization from PZAC APP1 to PZAC APP2 (for TRNLOG)","PZAC Cache DB synchronization from PZAC APP2 to PZAC APP1 (for TRNLOG)","PZAC Shadow DB synchronization from PZAC APP1 to PZAC APP2 (for TRNLOG)","PZAC Shadow DB synchronization from PZAC APP1 to PZAC APP2 (for EODLOG)","PZAC Shadow DB synchronization from PZAC APP1 to PZAC APP2 (for EODSUM)","PZAC Shadow DB synchronization from PZAC APP2 to PZAC APP1 (for TRNLOG)","PZAC Shadow DB synchronization from PZAC APP2 to PZAC APP1 (for EODLOG)","PZAC Shadow DB synchronization from PZAC APP2 to PZAC APP1 (for EODSUM)","PZAC synchronization from PZAC APP1 to PZAC DB1 (for TRNLOG)","PZAC synchronization from PZAC APP1 to PZAC DB1 (for EODLOG)","PZAC synchronization from PZAC APP1 to PZAC DB1 (for EODSUM)","PZAC synchronization from PZAC APP2 to PZAC DB2 (for EODLOG)","PZAC synchronization from PZAC APP2 to PZAC DB2 (for EODSUM)","PZAC synchronization from PZAC APP1 to Portal DB1 (for TRNLOG)","PZAC synchronization from PZAC APP1 to Portal DB1 (for EODLOG)","PZAC synchronization from PZAC APP1 to Portal DB1 (for EODSUM)","PZAC synchronization from PZAC APP2 to Portal DB2 (for TRNLOG)","PZAC synchronization from PZAC APP2 to Portal DB2 (for EODLOG)","PZAC synchronization from PZAC APP2 to Portal DB2 (for EODSUM)","PZAC synchronization from PZAC APP1 to PZAC DB2 (for TRNLOG)"]

for i in range(len(task_list)):

    try:
        rows = get_sync_from_db(task_list[i])
        plot_the_figure(rows, task_list_titles[i]+" The key was: "+task_list[i])
    except:
        print("No data about the :", task_list[i])

pdf_pages.close()
