#!/bin/bash

# Input CSV file
input_file=$1
output_file=$2

# Use awk to process each line of the CSV
awk -F, '{
    # Remove POINT ( and ) from column 15
    gsub(/POINT \(|\)/, "", $15)
    print
}' OFS=, "$input_file" > "$output_file"
