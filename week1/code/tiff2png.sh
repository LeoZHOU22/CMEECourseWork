#!/bin/bash
# Author: Yutao ZHOU leo.zhou23@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2023

for f in *.tif; 
    do  
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tif).png"; 
    done