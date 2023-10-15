#!/bin/sh
# Author: Yutao ZHOU leo.zhou23@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2023

file_path="$1"
if [ ! -f "$file_path" ]; then
    echo "Error: The file '$file_path' does not exist."
    exit 1
fi
cat "$file_path"
echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv
echo "Done!"
exit