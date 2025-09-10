#!/bin/bash
export PGPASSWORD=$DB_PASSWORD

## Load env and create folder
source ../../.env

echo "DEBUG: DB_HOST=$DB_HOST"
echo "DEBUG: DB_PORT=$DB_PORT"
echo "DEBUG: DB_NAME=$DB_NAME"
echo "DEBUG: DB_USER=$DB_USER"

csv_files="../../posey_data"
mkdir -p "$csv_files"

## Download files
url="https://raw.githubusercontent.com/jdbarillas/parchposey/master/data-raw"
files=("accounts.csv" "orders.csv" "region.csv" "sales_reps.csv" "web_events.csv")

# for f in "${files[@]}"; do
#     curl -s -o "$csv_files/$f" "$url/$f"
#     echo "Downloaded: $f"
# done

echo "Starting load into database: $DB_NAME"

# Looping through all CSV files and loading data into Postgres
for file in "$csv_files"/*.csv; do
    table_name=$(basename "$file" .csv)

    echo "Creating table: $table_name"

    # Create table and copy data
    header=$(head -n 1 "$file")
    columns=$(echo "$header" | awk -F',' '{for(i=1;i<=NF;i++) printf "%s TEXT%s", $i, (i<NF?",":"")}')
    
    psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "DROP TABLE IF EXISTS $table_name;"
    psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "CREATE TABLE $table_name ($columns);"

    echo "Copying data into: $table_name"
    psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "\COPY $table_name FROM '$file' CSV HEADER"

    echo "Loading completed $file into $table_name"
done