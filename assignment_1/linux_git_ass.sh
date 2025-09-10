#!/bin/bash

URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

echo "Step 1: Extract data......"

#---Create raw folder
mkdir -p raw

# Download data into raw folder
curl -o raw/finance_data.csv "$URL"

# File confirmation

if [ -f "raw/finance_data.csv" ]; then
    echo "This file already exist in this folder"
else
    echo "file not saved"
    exit 1
fi

echo "Step 2: Transform data......"

## Create transformed folder
mkdir -p transformed

## Rename column and write column header to new file
head -n 1 raw/finance_data.csv | sed 's/Variable_code/variable_code/' | awk -F',' 'NR=1 {print $1","$9","$5","$6}' > transformed/2023_year_finance.csv

## Append all other rows to the new file
awk -F',' 'NR>1 {print $1","$9","$5","$6}' raw/finance_data.csv >> transformed/2023_year_finance.csv

#head -n 1 transformed/2023_year_finance.csv

## confirm file
if [ -f "transformed/2023_year_finance.csv" ]; then
    echo "This file exist in the transformed folder"
else
    echo "This file does not exist"
    exit 1
fi


#### Loading Data
echo "Step 3: Loading data....."

## Create gold folder
mkdir -p gold

## Copy file into gold folder
cp transformed/2023_year_finance.csv gold/

## confirm file
if [ -f "gold/2023_year_finance.csv" ]; then
    echo "This file exist in the gold file"
else
    echo "This file does not exist"
    exit 1
fi




