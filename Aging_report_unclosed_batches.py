from datetime import datetime, date, timedelta
import xlsxwriter

import pandas as pd
import numpy as np

unclose_batches = pd.read_csv("report_unclosed_batches.txt", header=None, sep='|')

unclose_batches = unclose_batches.iloc[2:]
unclose_batches = unclose_batches.iloc[:-1]

unclose_batches[0] = unclose_batches[0].str.strip()
unclose_batches[1] = unclose_batches[1].str.strip()
unclose_batches[2] = unclose_batches[2].str.strip()

unclose_batches.replace('', np.nan, inplace=True)
unclose_batches = unclose_batches.dropna()

unclose_batches[2] = pd.to_datetime(unclose_batches[2])


# unclose_batches.set_index(2)


def date_grouper(group):
    after_start_date = unclose_batches[2] >= group[0]
    before_end_date = unclose_batches[2] <= group[1]
    between_two_dates = after_start_date & before_end_date
    filtered_dates = unclose_batches.loc[between_two_dates]
    return filtered_dates


now = datetime.now()
group_1_7_start_date = now - timedelta(days=7)
group_8_15_start_date = group_1_7_start_date - timedelta(days=7)
group_16_30_start_date = group_8_15_start_date - timedelta(days=14)
group_31_60_start_date = group_16_30_start_date - timedelta(days=30)
group_61_90_start_date = group_31_60_start_date - timedelta(days=30)
group_91_120_start_date = group_61_90_start_date - timedelta(days=30)
group_121_150_start_date = group_91_120_start_date - timedelta(days=30)
group_151_180_start_date = group_121_150_start_date - timedelta(days=30)

G1 = pd.DataFrame(date_grouper([group_1_7_start_date, now])[0])

G2 = pd.DataFrame(date_grouper([group_8_15_start_date, group_1_7_start_date])[0])

G3 = pd.DataFrame(date_grouper([group_16_30_start_date, group_8_15_start_date])[0])

G4 = pd.DataFrame(date_grouper([group_31_60_start_date, group_16_30_start_date])[0])

G5 = pd.DataFrame(date_grouper([group_61_90_start_date, group_31_60_start_date])[0])

G6 = pd.DataFrame(date_grouper([group_91_120_start_date, group_61_90_start_date])[0])

G7 = pd.DataFrame(date_grouper([group_121_150_start_date, group_91_120_start_date])[0])

G8 = pd.DataFrame(date_grouper([group_151_180_start_date, group_121_150_start_date])[0])

G2012 = pd.DataFrame(date_grouper(['2012-01-01 00:00:00.0000', '2012-12-31 00:00:00.0000'])[0])

G2013 = pd.DataFrame(date_grouper(['2013-01-01 00:00:00.0000', '2013-12-31 00:00:00.0000'])[0])

G2014 = pd.DataFrame(date_grouper(['2014-01-01 00:00:00.0000', '2014-12-31 00:00:00.0000'])[0])

G2015 = pd.DataFrame(date_grouper(['2015-01-01 00:00:00.0000', '2015-12-31 00:00:00.0000'])[0])

G2016 = pd.DataFrame(date_grouper(['2016-01-01 00:00:00.0000', '2016-12-31 00:00:00.0000'])[0])

G2017 = pd.DataFrame(date_grouper(['2017-01-01 00:00:00.0000', '2017-12-31 00:00:00.0000'])[0])

G2018 = pd.DataFrame(date_grouper(['2018-01-01 00:00:00.0000', '2018-12-31 00:00:00.0000'])[0])

G2019 = pd.DataFrame(date_grouper(['2019-01-01 00:00:00.0000', '2019-12-31 00:00:00.0000'])[0])

G2020 = pd.DataFrame(date_grouper(['2020-01-01 00:00:00.0000', group_151_180_start_date])[0])



writer = pd.ExcelWriter('Ageing_report_unclosed_batches.xlsx', engine='xlsxwriter')

G1.to_excel(writer, sheet_name='Group lists', startrow=1, header=False, index=False)
G2.to_excel(writer, sheet_name='Group lists', startrow=1, header=False, index=False, startcol=1)
G3.to_excel(writer, sheet_name='Group lists', startrow=1, header=False, index=False, startcol=2)
G4.to_excel(writer, sheet_name='Group lists', startrow=1, header=False, index=False, startcol=3)
G5.to_excel(writer, sheet_name='Group lists', startrow=1, header=False, index=False, startcol=4)
G6.to_excel(writer, sheet_name='Group lists', startrow=1, header=False, index=False, startcol=5)
G7.to_excel(writer, sheet_name='Group lists', startrow=1, header=False, index=False, startcol=6)
G8.to_excel(writer, sheet_name='Group lists', startrow=1, header=False, index=False, startcol=7)




workbook = writer.book
worksheet = writer.sheets['Group lists']

# Add a header format.
header_format = workbook.add_format({
    'bold': True,
    'text_wrap': True,
    'valign': 'top',
    'fg_color': 'orange',
    'border': 1})

headers = ['1 - 7 days', '8 - 15 days', '16 - 30 days', '31 - 60 days', '61 - 90 days', '91 - 120 days',
           '121 - 150 days', '151 - 180 days']

# Write the column headers with the defined format.
for col_num, value in enumerate(headers, start=-1):
    worksheet.write(0, col_num + 1, value, header_format)

totals = [G1.count().values[0], G2.count().values[0], G3.count().values[0], G4.count().values[0], G5.count().values[0],
          G6.count().values[0], G7.count().values[0], G8.count().values[0]]

totals2 = [G2012.count().values[0], G2013.count().values[0], G2014.count().values[0], G2015.count().values[0], G2016.count().values[0],
          G2017.count().values[0], G2018.count().values[0], G2019.count().values[0], G2020.count().values[0]]

headers2 = ['2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020']

analysis = pd.DataFrame(data=totals, index=headers)

analysis2 = pd.DataFrame(data=totals2, index=headers2)

analysis.to_excel(writer, sheet_name='Analysis', startrow=0, header=False, index=True, startcol=0)

analysis2.to_excel(writer, sheet_name='AnalysisPerYear', startrow=0, header=False, index=True, startcol=0)

# Create a chart object.
chart = workbook.add_chart({'type': 'line'})
chart.set_title({'name': 'Ageing Report'})

# Configure the series of the chart from the dataframe data.
chart.add_series({'categories': '=Analysis!$A$1:$A$8', 'values': '=Analysis!$B$1:$B$8'})


# Create a chart object.
chart2 = workbook.add_chart({'type': 'line'})
chart2.set_title({'name': 'Ageing Report'})

# Configure the series of the chart from the dataframe data.
chart2.add_series({'categories': '=AnalysisPerYear!$A$1:$A$9', 'values': '=AnalysisPerYear!$B$1:$B$9'})

worksheet = writer.sheets['Analysis']

# Insert the chart into the worksheet.
worksheet.insert_chart('A10', chart)


worksheet = writer.sheets['AnalysisPerYear']

# Insert the chart into the worksheet.
worksheet.insert_chart('A10', chart2)


unclose_batches['Date'] = pd.to_datetime(unclose_batches[2], dayfirst=True)
pivot = unclose_batches['Date'].dt.date.value_counts().sort_index().reset_index()
pivot.columns = ['DATE', 'Count']
pivot.to_excel(writer, sheet_name='Pivot', startrow=0, header=True, index=False, startcol=0)


G2012.to_excel(writer, sheet_name='2012', startrow=1, header=False, index=False)
G2013.to_excel(writer, sheet_name='2013', startrow=1, header=False, index=False)
G2014.to_excel(writer, sheet_name='2014', startrow=1, header=False, index=False)
G2015.to_excel(writer, sheet_name='2015', startrow=1, header=False, index=False)
G2016.to_excel(writer, sheet_name='2016', startrow=1, header=False, index=False)
G2017.to_excel(writer, sheet_name='2017', startrow=1, header=False, index=False)
G2018.to_excel(writer, sheet_name='2018', startrow=1, header=False, index=False)
G2019.to_excel(writer, sheet_name='2019', startrow=1, header=False, index=False)
G2020.to_excel(writer, sheet_name='2020', startrow=1, header=False, index=False)




writer.save()
