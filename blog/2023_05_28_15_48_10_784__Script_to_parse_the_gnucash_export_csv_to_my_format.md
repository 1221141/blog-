---
created: 20230528154810784
modified: 20230528155110015
title: Script to parse the gnucash export csv to my format
---

# Script to parse the gnucash export csv to my format

## Context: 

I want to use gnucash to track my expenses, but I also want to provide in a specific google sheets format.

The output from gnucash is like this:
```
Date,Account Name,Number,Description,Full Category Path,Reconcile,Amount With Sym,Amount Num.,Value With Sym,Value Num.,Rate/Price


2023-05-27,Expenses:Entertainment,,Redacted,Equity:Opening Balances - SEK,n,kr276.39,276.39,kr276.39,276.39,1.0000
```

I want to be in this format:

```
Date,Responsible,Category,SEK
```

The following script achieves that:

```python
import csv
from datetime import datetime

def format_date(date_str):
    date_obj = datetime.strptime(date_str, "%Y-%m-%d")
    formatted_date = date_obj.strftime("%#m/%#d/%Y")  
    return formatted_date

def filter_csv(csv_file, responsible):
    output_rows = []
    with open(csv_file, 'r') as file:
        reader = csv.DictReader(file)
        headers = ['Date', 'Responsible', 'Category', 'SEK']
        output_rows.append(headers)

        for row in reader:
            date = format_date(row['Date'])
            account_name = row['Account Name'].split(':')[-1]
            amount_sek = row['Amount Num.']

      

            output_row = [date, responsible, account_name, amount_sek]
            output_rows.append(output_row)

    with open('output.csv', 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerows(output_rows)


csv_file_path = 'test.csv' 
responsible_string = 'John Doe'  

filter_csv(csv_file_path, responsible_string)
```