#!/bin/bash

input=$1
output=$2

# Step 1: Calculate the average electric range for each make and model (excluding zero values)
awk -F',' '$11 > 0 {sum[$8 FS $7] += $11; count[$8 FS $7]++}
            END {for (key in sum) print key "," sum[key] / count[key]}' "$input" > averages.txt

# Step 2: Use the calculated averages to replace rows with a zero electric range
awk -F',' -v OFS=',' '
    BEGIN {
        # Load averages into an array
        while ((getline < "averages.txt") > 0) {
            # Split the line into make, model, and average
            split($0, arr, ",")
            make_model[arr[1] FS arr[2]] = arr[3]
        }
    }
    {
        # Check if the electric range is 0 or an empty string (i.e., no value) and replace it with the average
        if ($11 == 0 || length($11) == 0) {
            key = $8 FS $7
            if (key in make_model) {
                $11 = make_model[key]
            }
        }

        # Exclude rows where the electric range is still 0 or an empty string
        if ($11 != 0 && length($11) > 0) {
            print $0
        }
    }' "$input" > "$output"
