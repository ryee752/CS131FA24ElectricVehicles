#!/bin/bash

input=$1
output=$2
# Columns to capitalize (0-based indices, e.g., 2 for "city" and 3 for "country")
column_to_capitalize=$3

# Process the file
awk -F"," -v col=$column_to_capitalize 'BEGIN {OFS = FS} 
NR == 1 {print; next} { 
    $col = toupper($col); 
    print 
}' "$input" > "$output"
