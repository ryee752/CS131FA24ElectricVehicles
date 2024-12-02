#!/bin/bash

input=$1


awk -F',' '{
    for (i = 1; i <= NF; i++) {
        if ($i == "") {
            print $0
            break
        }
    }
}' "$input"

