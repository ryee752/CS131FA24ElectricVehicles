#!/bin/bash

input_file=$1
output_file=$2

# Join all column numbers into a space-separated string

columns_to_remove="$3"

cut --complement -d, -f$columns_to_remove "$input_file" > "$output_file"

echo "Columns $columns_to_remove have been removed from $input_file and saved to $output_file"
