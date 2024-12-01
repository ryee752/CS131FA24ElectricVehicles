# Preprocessing
The shell scripts listed are used for preprocessing the data in ([Link](https://data.wa.gov/Transportation/Electric-Vehicle-Population-Data/f6w7-q2d2/about_data))
## replace_zero_range.sh
This script replaces rows with an electric range of 0 with the average electric range of cars with the same model and make. If the electric range is still 0 after preprocessing, the rows are deleted. <br />
The parameters are the input file and the output file.<br />
Ex: sh replace_zero_range.sh Electric_Vehicle_Population_Data.csv Electric_Vehicle_Population_Data_ER_NO_ZEROS.csv
## cafv_standardize.sh
This script standardizes the Clean Alternative Fuel Vehicle (CAFV) Eligibility column by replacing all instances of eligibility with “ELIGIBLE” and all instances of ineligibility with “INELIGIBLE” <br />
The parameters are the input file and the output file.<br />
Ex: sh cafv_standardize.sh Electric_Vehicle_Population_Data_ER_NO_ZEROS.csv Electric_Vehicle_Population_Data_cleaned_cafv.csv
## msrp_zero_clean.sh
This script replaces rows with an base msrp of 0 with the median base msrp of all cars. <br />
The parameters are the input file and the output file.<br />
Ex: sh msrp_zero_clean.sh Electric_Vehicle_Population_Data_cleaned_cafv.csv Electric_Vehicle_Population_Data_cleaned_msrp.csv
## hybrid_battery_standardize.sh
This script standardizes vehicle type by replacing all instances of hybrid cars with “HYPBRID” and all instances of battery electric cars with “BATTERY”. <br />
The parameters are the input file and the output file.<br />
Ex: sh hybrid_battery_standardize.sh Electric_Vehicle_Population_Data_cleaned_msrp.csv Electric_Vehicle_Population_Data_cleaned_hybrid_battery.csv
## standardize_address.sh
This script standardizes the county and city columns by capitalizing all values in the column that is selected. <br />
The parameters are the input file, the output file, the column to be standardized (2 or 3).<br />
Ex: sh standardize_address.sh Electric_Vehicle_Population_Data_cleaned_hybrid_battery.csv temp.csv 2
