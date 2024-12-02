#!/bin/bash

input=$1
output=$2

# Use awk to keep only rows where the State column contains "WA"
awk -F',' -v OFS=',' '
    {
        if ($4 == "WA") {
            print $0
        } 
    }' "$input" > "$output"
