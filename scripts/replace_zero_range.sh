#!/bin/bash

input=$1
output=$2

# Step 1: Calculate the average electric range for each make and model (excluding zero values)
awk -F',' '$11 > 0 {sum[$8 FS $7] += $11; count[$8 FS $7]++}
            END {for (key in sum) print key, sum[key] / count[key]}' "$input" > averages.txt

# Step 2: Use the calculated averages to replace rows with a zero electric range
awk -F',' -v OFS=',' '
    BEGIN {
        # Load averages into an array
        while ((getline < "averages.txt") > 0) {
            make_model[$1 FS $2] = $3
        }
    }
    {
        # Check if the electric range is 0 and replace it with the average
        if ($11 == 0) {
            key = $8 FS $7
            if (key in make_model) {
                $11 = make_model[key]
            }
        }
        # Print the row only if the electric range is not 0
        if ($11 != 0) {
            print $0
        }
    }' "$input" > "$output"

