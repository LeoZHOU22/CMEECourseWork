#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <input_file1> <input_file2> <output_file>"
    exit 1
fi

input_file1="$1"
input_file2="$2"
output_file="$3"

# Check if the input files exist
if [ ! -f "$input_file1" ]; then
    echo "Error: File '$input_file1' does not exist."
    exit 1
fi

if [ ! -f "$input_file2" ]; then
    echo "Error: File '$input_file2' does not exist."
    exit 1
fi

# Merge the input files into the output file
cat "$input_file1" > "$output_file"
cat "$input_file2" >> "$output_file"

echo "Merged File is '$output_file'"
cat $3
