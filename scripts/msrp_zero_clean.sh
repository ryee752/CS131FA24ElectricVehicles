#!/bin/bash

input=$1
output=$2

# Extract all non-zero values of the Base MSRP column
awk -F',' '$12 > 0 {print $12}' "$input" | sort -n | awk '{
    a[NR]=$1
} END {
    if (NR%2==1) print a[(NR+1)/2]; 
    else print (a[NR/2]+a[NR/2+1])/2;
}' > msrp_median.txt

# Replace zeros in the Base MSRP column with the median value
median=$(cat msrp_median.txt)
awk -F',' -v OFS=',' -v median=$median '
    {
        if ($12 == 0) {
            $12 = median
        }
        print $0
    }' "$input" > "$output"
