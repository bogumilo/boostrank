# boostrank
My take on how to tackle annual UK university rankings data with dbt.
To emphasize various scenarios, original .xlsx file is saved as GSHeet on Google Drive.
From there I source its' respective sheets to Google Bigquery as external tables.
This is the easiest method to work with spreadsheet data in sql.

Inside Google Spreadsheets use 'share' button to give access to your service account email address,
the one that you use in your dbt project.
