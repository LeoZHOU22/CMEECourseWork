#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_csv_file> <output_space_file>"
    exit 1
fi

input_csv="$1"
output_space="$2"

# Check if the input CSV file exists
if [ ! -f "$input_csv" ]; then
    echo "Error: Input file '$input_csv' does not exist."
    exit 1
fi

# Convert CSV to space-separated values and save it to the output file
awk 'BEGIN { FS=","; OFS=" " } { $1=$1; print }' "$input_csv" > "$output_space"

if [ $? -eq 0 ]; then
    echo "Conversion complete. Space-separated values saved in '$output_space'."
else
    echo "Error: Conversion failed."
    exit 1
fi
