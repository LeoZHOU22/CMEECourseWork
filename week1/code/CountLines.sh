#!/bin/bash
file_path="$1"
if [ ! -f "$file_path" ]; then
    echo "Error: The file '$file_path' does not exist."
    exit 1
fi
cat "$file_path"
NumLines=`wc -l  $1`
echo "The file $1 has $NumLines lines"
echo