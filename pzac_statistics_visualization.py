from matplotlib.backends.backend_pdf import PdfPages
pdf_pages = PdfPages('pzac_statistics.pdf')
import matplotlib.dates as mdates
import matplotlib.pyplot as plt
import mysql.connector
cnx = mysql.connector.connect(user='root', password='root', host='localhost', database='zac')
x = cnx.cursor(buffered=True)

stmn = ('select * from total_stats WHERE dt BETWEEN CURDATE() - INTERVAL 7 DAY AND CURDATE() ORDER BY dt')

x.execute(stmn)

rows = x.fetchall()


cnx2 = mysql.connector.connect(user='root', password='root', host='localhost', database='ionix')
x2 = cnx2.cursor(buffered=True)

stmn2 = ('select * from pzac_statistics WHERE dt BETWEEN CURDATE() - INTERVAL 7 DAY AND CURDATE() ORDER BY dt')

x2.execute(stmn2)

rows2 = x2.fetchall()


dt2=[]
max_cpu_pzapp1=[]
max_mem_pzapp1=[]
max_disk_pzapp1=[]
max_cpu_pzdb1=[]
max_cpu_pzapp2=[]
max_mem_pzapp2=[]
max_disk_pzapp2=[]
max_cpu_pzdb2=[]

for row in rows2:
    dt2.append(row[0])
    max_cpu_pzapp1.append(row[1])
    max_mem_pzapp1.append(row[2])
    max_disk_pzapp1.append(row[3])
    max_cpu_pzdb1.append(row[4])
    max_cpu_pzapp2.append(row[5])
    max_mem_pzapp2.append(row[6])
    max_disk_pzapp2.append(row[7])
    max_cpu_pzdb2.append(row[8])



def plot_report(dates, data, legends, tittle, labelx, labely):

    f, ax = plt.subplots()
    plt.title(tittle)
    for i in range(len(data)):
        plt.plot_date(x=dates, y=data[i], fmt='-', label=legends[i], linewidth=2)
    plt.ylabel(labely)
    plt.xlabel(labelx)
    ax.xaxis.set_major_locator(mdates.DayLocator())
    myFmt = mdates.DateFormatter('%d-%m-%y')
    ax.xaxis.set_major_formatter(myFmt)
    plt.gcf().set_size_inches(15, 8)
    plt.legend(fancybox=True, shadow=True, loc='upper right', framealpha=0.2)
    plt.grid(True)
    f.autofmt_xdate()
    locator = mdates.AutoDateLocator()
    ax.xaxis.set_major_locator(locator)
    plt.show()
    plt.close()
    pdf_pages.savefig(f)



dates=[]
pr_batches=[]
dr_batches=[]
pr_uploads=[]
dr_uploads=[]
pr_sol=[]
dr_sol=[]
pr_unsol=[]
dr_unsol=[]
pr_approvals=[]
dr_approvals=[]
pr_declines=[]
dr_declines=[]
pr_handshakes=[]
dr_handshakes=[]
sessions_zacnd_pr=[]
sessions_zacnd_dr=[]
sessions_zaccd_pr=[]
sessions_zaccd_dr=[]
sessions_cache_DB_postgres_pr=[]
sessions_cache_DB_postgres_dr=[]
sessions_shadow_DB_postgres_pr_syscenter=[]
sessions_shadow_DB_postgres_dr_syscenter=[]
pr_max_batches=[]
dr_max_batches=[]
peak_max_tps=[]
peak_max_tpm=[]
peak_max_tph=[]
pzac_pos_trxs=[]
e_comm_trxs=[]
euronet_trxs=[]
viva_trxs=[]
for row in range(len(rows)):
    dt, total_batch_closes_pr, total_batch_uploads_pr, total_sol_pr, total_unsol_pr, total_approvals_pr, \
    total_declines_pr, total_handshakes_pr, max_sessions_zacnd_pr, max_sessions_zaccd_pr, max_sessions_cache_DB_postgres_pr, \
    max_sessions_shadow_DB_postgres_pr_syscenter, max_batches_pr, total_batch_closes_dr, total_batch_uploads_dr, \
    total_sol_dr, total_unsol_dr, total_approvals_dr, total_declines_dr, total_handshakes_dr, max_sessions_zacnd_dr, \
    max_sessions_zaccd_dr, max_sessions_cache_DB_postgres_dr, max_sessions_shadow_DB_postgres_dr_syscenter, \
    max_batches_dr, SPDH_IN_2, SPDH_IN, SPDH_IN_3, BICISO_FDH, BICISO_IN, BASE24_HCE_D, PIRAEUS_IN, VIVA_IN, STIP_IN, max_tps_datetime, \
    max_tps, max_tpm_datetime, max_tpm, max_tph_datetime, max_tph = [rows[row][cell] for cell in range(0, 40)]
    dates.append(dt)
    pr_batches.append(total_batch_closes_pr)
    dr_batches.append(total_batch_closes_dr)
    pzac_pos_trxs.append(SPDH_IN_2+SPDH_IN+SPDH_IN_3)
    e_comm_trxs.append(BICISO_IN)
    euronet_trxs.append(PIRAEUS_IN)
    pr_uploads.append(total_batch_uploads_pr)
    dr_uploads.append(total_batch_uploads_dr)
    pr_sol.append(total_sol_pr)
    dr_sol.append(total_sol_dr)
    pr_unsol.append(total_unsol_pr)
    dr_unsol.append(total_unsol_dr)
    pr_approvals.append(total_approvals_pr)
    dr_approvals.append(total_approvals_dr)
    pr_declines.append(total_declines_pr)
    dr_declines.append(total_declines_dr)
    pr_handshakes.append(total_handshakes_pr)
    dr_handshakes.append(total_handshakes_dr)
    sessions_zacnd_pr.append(max_sessions_zacnd_pr)
    sessions_zacnd_dr.append(max_sessions_zacnd_dr)
    sessions_zaccd_pr.append(max_sessions_zaccd_pr)
    sessions_zaccd_dr.append(max_sessions_zaccd_dr)
    sessions_cache_DB_postgres_pr.append(max_sessions_cache_DB_postgres_pr)
    sessions_cache_DB_postgres_dr.append(max_sessions_cache_DB_postgres_dr)
    sessions_shadow_DB_postgres_pr_syscenter.append(max_sessions_shadow_DB_postgres_pr_syscenter)
    sessions_shadow_DB_postgres_dr_syscenter.append(max_sessions_shadow_DB_postgres_dr_syscenter)
    peak_max_tps.append(max_tps)
    peak_max_tpm.append(max_tpm)
    peak_max_tph.append(max_tph)
    viva_trxs.append(VIVA_IN)
    pr_max_batches.append(max_batches_pr)
    dr_max_batches.append(max_batches_dr)


plot_report(dates,[pzac_pos_trxs, e_comm_trxs, euronet_trxs, viva_trxs],
            ['PZAC Terminals', 'E-Commerce', 'Euronet terminals', 'Viva'],
            'Total Transactions', None, None)

plot_report(dates,[pr_batches, dr_batches], ['PZAPP1', 'PZAPP2'], 'Total Batch Closes', None, None)

plot_report(dates,[pr_uploads, dr_uploads], ['PZAPP1', 'PZAPP2'], 'Total Batch Uploads', None, None)

plot_report(dates,[pr_sol, dr_sol], ['PZAPP1', 'PZAPP2'], 'Total Solicited Reversals', None, None)

plot_report(dates,[pr_unsol, dr_unsol], ['PZAPP1', 'PZAPP2'], 'Total Unsolicited Reversals', None, None)

plot_report(dates,[pr_approvals, dr_approvals], ['PZAPP1', 'PZAPP2'], 'Total Approvals', None, None)

plot_report(dates,[pr_declines, dr_declines], ['PZAPP1', 'PZAPP2'], 'Total Declines', None, None)

plot_report(dates,[pr_handshakes, dr_handshakes], ['PZAPP1', 'PZAPP2'], 'Total Handshakes', None, None)

plot_report(dates,[sessions_zacnd_pr, sessions_zacnd_dr], ['PZAPP1', 'PZAPP2'], 'Peak Sessions zacnd', None, None)

plot_report(dates,[sessions_zaccd_pr, sessions_zaccd_dr], ['PZAPP1', 'PZAPP2'], 'Peak Sessions zaccd', None, None)

plot_report(dates,[sessions_cache_DB_postgres_pr, sessions_cache_DB_postgres_dr], ['PZAPP1', 'PZAPP2'], 'Peak Sessions DB cache', None, None)

plot_report(dates,[sessions_shadow_DB_postgres_pr_syscenter, sessions_shadow_DB_postgres_dr_syscenter], ['PZAPP1', 'PZAPP2'], 'Peak Sessions DB shadow', None, None)

plot_report(dates,[pr_max_batches, dr_max_batches], ['PZAPP1', 'PZAPP2'], 'Peak Batches', None, None)

plot_report(dates,[peak_max_tps], ['PZAC'], 'Peak TPS', None, None)

plot_report(dates,[peak_max_tpm], ['PZAC'], 'Peak TPM', None, None)

plot_report(dates,[peak_max_tph], ['PZAC'], 'Peak TPH', None, None)

plot_report(dt2, [max_cpu_pzapp1, max_mem_pzapp1, max_disk_pzapp1], ['Peak CPU', 'Peak Memory', 'Peak Disk'], 'PZAPP1 Hardware Statistics (%)', None, None)

plot_report(dt2, [max_cpu_pzapp2, max_mem_pzapp2, max_disk_pzapp2], ['Peak CPU', 'Peak Memory', 'Peak Disk'], 'PZAPP2 Hardware Statistics (%)', None, None)

plot_report(dt2, [max_cpu_pzdb1], ['Peak CPU'], 'PZDB1 Hardware Statistics (%)', None, None)

plot_report(dt2, [max_cpu_pzdb2], ['Peak CPU'], 'PZDB2 Hardware Statistics (%)', None, None)


pdf_pages.close()


