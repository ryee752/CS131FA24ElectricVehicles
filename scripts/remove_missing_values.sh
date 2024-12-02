#!/bin/bash

input_file=$1
output_file=$2

# Use awk to remove rows with missing values
awk -F',' -v OFS=',' '
{
    # Check if any field is empty (NF - number of fields, $i - field value)
    for (i = 1; i <= NF; i++) {
        if ($i == "" || $i == " ") {
            next  # Skip the row if any field is empty
        }
    }
    # If no empty field, print the row
    print $0
}' "$input_file" > "$output_file"

echo "Rows with missing values have been removed from $input_file and saved to $output_file"
