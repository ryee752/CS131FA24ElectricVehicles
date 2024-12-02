#!/bin/bash

input=$1
output=$2

# Use awk to keep the header and only rows where the 4th column contains "WA"
awk -F',' -v OFS=',' '
    NR == 1 {print $0}  # Print header (first row)
    NR > 1 && $4 == "WA" {print $0}  # Print rows where the 4th column is "WA"
' "$input" > "$output"
