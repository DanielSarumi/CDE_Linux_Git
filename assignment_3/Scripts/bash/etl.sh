#!/bin/bash


##  Itemize and Creating necessary folder
source="../../source"
destination="../../json_csv_files"

mkdir -p "$destination"

## create files
echo "This is my json file" > "$source/jsontest1.json"
echo "This is my text file" > "$source/hello.txt"
echo "This is my csv file" > "$source/hello.csv"
echo "This is my pdf file" > "$source/hello.pdf"
echo "This is my json file" > "$source/jsontest2.json"
echo "This is my csv file" > "$source/hello2.csv"

## move files from source to destination
echo "Moving selected files from source to destination...."

mv "$source"/*.csv "$source"/*.json "$destination" 2>/dev/null