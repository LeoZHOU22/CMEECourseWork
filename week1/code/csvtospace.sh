#!/bin/bash
# Author: Yutao ZHOU leo.zhou23@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2023

# Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_csv_file> <output_space_file>"
    exit 1
fi

input_csv_file="$1"
output_space_file="$2"

# Check if the input file exists
if [ ! -f "$input_csv_file" ]; then
    echo "Error: Input file '$input_csv_file' does not exist."
    exit 1
fi

# Replace commas with spaces and save the result in the output file
sed 's/,/ /g' "$input_csv_file" > "$output_space_file"

echo "Conversion complete. Result saved as '$output_space_file'"
