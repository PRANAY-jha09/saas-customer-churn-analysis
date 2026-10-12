
import sqlite3
import pandas as pd
from pathlib import Path

# Folder containing your CSV files
data_folder = Path(
    r"D:\Customer_churn_risk_analysis\data_cleaned"
)

# SQLite database path
db_path = Path(
    r"D:\Customer_churn_risk_analysis\churn.db"
)

# Connect to SQLite
conn = sqlite3.connect(db_path)

try:
    # Load each CSV file into SQLite
    for file in data_folder.glob("*.csv"):

        # Read CSV file
        df = pd.read_csv(file)

        # Create table name from the CSV filename
        table_name = file.stem.lower()

        # Insert data into SQLite
        df.to_sql(
            table_name,
            conn,
            if_exists="replace",
            index=False
        )

        print(f"Loaded file: {file.name}")
        print(f"Table name: {table_name}")
        print(f"Rows loaded: {len(df)}")
        print("-" * 40)

    print("All CSV files loaded successfully!")

finally:
    conn.close()
