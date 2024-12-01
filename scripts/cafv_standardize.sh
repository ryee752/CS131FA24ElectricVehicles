#!/bin/bash

# Replace "Clean Alternative Fuel Vehicle Eligible" with "ELIGIBLE" and
# "Not eligible due to low battery range" with "INELIGIBLE" in column 10
awk -F',' -v OFS=',' '
    {
        # Replace in column 10
        if ($10 == "Clean Alternative Fuel Vehicle Eligible") {
            $10 = "ELIGIBLE"
        } else if ($10 == "Not eligible due to low battery range") {
            $10 = "INELIGIBLE"
        }
        print $0
    }' Electric_Vehicle_Population_Data_ER_NO_ZEROS.csv > Electric_Vehicle_Population_Data_cleaned_cafv.csv
