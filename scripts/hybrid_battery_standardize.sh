#!/bin/bash

input=$1
output=$2

# Replace any occurrence of "Plug-in Hybrid Electric Vehicle (PHEV)" with "HYBRID"
# and any occurrence of "Battery Electric Vehicle (BEV)" with "BATTERY" in column 9
awk -F',' -v OFS=',' '
    {
        if ($9 == "Plug-in Hybrid Electric Vehicle (PHEV)") {
            $9 = "HYBRID"
        }
        if ($9 == "Battery Electric Vehicle (BEV)") {
            $9 = "BATTERY"
        }
        
        # Print the modified row
        print $0
    }' "$input" > "$output"
