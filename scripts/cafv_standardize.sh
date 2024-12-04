#!/bin/bash

input=$1
output=$2

# Replace "Clean Alternative Fuel Vehicle Eligible" with "ELIGIBLE" and
# "Not eligible due to low battery range" with "INELIGIBLE" in column 10
# "Eligibility unknown as battery range has not been researched" with "N/A"
awk -F',' -v OFS=',' '
    {
        # Replace in column 10
	if (NR == 1) {
	   print; 
           next
	}
        if ($10 == "Clean Alternative Fuel Vehicle Eligible") {
            $10 = "ELIGIBLE"
        } else if ($10 == "Not eligible due to low battery range") {
            $10 = "INELIGIBLE"
        } else {
	    $10 = "N/A"
	}
        print $0
    }' "$input" > "$output"
