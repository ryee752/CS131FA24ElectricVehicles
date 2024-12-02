#!/bin/bash

input=$1  # Input file
output=$2  # Output file

# Use sed to replace ", INC" with "" in every line
sed 's/, INC//g' "$input" > "$output"
