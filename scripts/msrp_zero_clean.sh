#!/bin/bash

input=$1
output=$2

# Step 1: Calculate the median of non-zero MSRP values
awk -F',' '$12 > 0 {print $12}' "$input" | sort -n | awk '{
    a[NR]=$1
} END {
    if (NR % 2 == 1) 
        print a[(NR + 1) / 2];
    else 
        print (a[NR / 2] + a[NR / 2 + 1]) / 2;
}' > msrp_median.txt

# Read the median value from msrp_median.txt
median=$(<msrp_median.txt)

# Step 2: Calculate the average MSRP for each car make
declare -A make_msrp_sum
declare -A make_msrp_count

# Collect sums and counts for each make (column 7)
awk -F',' '{
    if ($12 > 0) {
        make_msrp_sum[$7] += $12;
        make_msrp_count[$7] += 1;
    }
} END {
    for (make in make_msrp_sum) {
        average_msrp = make_msrp_sum[make] / make_msrp_count[make];
        print make, average_msrp;
    }
}' "$input" > make_msrp_averages.txt

# Step 3: Replace zeros in the Base MSRP column with the average MSRP for that make
# If average MSRP is 0, replace it with the global median

awk -F',' -v OFS=',' -v median="$median" '
    # Load average MSRP for each make into an associative array
    NR == FNR {
        make_avg[$1] = $2; 
        next;
    }
    
    {
        # Get the make of the current row (column 7)
        make = $7;

        # Replace zero MSRP with the average for the make, or with the global median if average is 0
        if ($12 == 0) {
            if (make_avg[make] > 0) {
                $12 = make_avg[make];
            } else {
                $12 = median;
            }
        }
        print $0;
    }
' make_msrp_averages.txt "$input" > "$output"

echo "Zeros in the Base MSRP column have been replaced with the average MSRP for the car make, or with the median if no average exists."
