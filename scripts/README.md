# Preprocessing
The shell scripts listed are used for preprocessing the data in ([Link](https://data.wa.gov/Transportation/Electric-Vehicle-Population-Data/f6w7-q2d2/about_data))
## eu_standardize.sh
This script fixes rows with more than 17 columns due to having an additional "," in the value for electric utility while using "," as the delimiter. <br />
The parameters are the input file and the output file.<br />
Ex: sh eu_standardize.sh Electric_Vehicle_Population_Data.csv Electric_Vehicle_Population_Data_cleaned.csv
## replace_zero_range.sh
This script replaces rows with an electric range of 0 with the average electric range of cars with the same model and make. If the electric range is still 0 after preprocessing, the rows are deleted. <br />
The parameters are the input file and the output file.<br />
Ex: sh replace_zero_range.sh Electric_Vehicle_Population_Data.csv Electric_Vehicle_Population_Data_ER_NO_ZEROS.csv
## cafv_standardize.sh
This script standardizes the Clean Alternative Fuel Vehicle (CAFV) Eligibility column by replacing all instances of eligibility with “ELIGIBLE” and all instances of ineligibility with “INELIGIBLE” <br />
The parameters are the input file and the output file.<br />
Ex: sh cafv_standardize.sh Electric_Vehicle_Population_Data_ER_NO_ZEROS.csv Electric_Vehicle_Population_Data_cleaned_cafv.csv
## msrp_zero_clean.sh
This script replaces rows with a base MSRP of 0 with the average base MSRP of cars of the same make. If the average MSRP is 0, the base MSRP is replaced with the median base MSRP of all cars. <br />
The parameters are the input file and the output file.<br />
Ex: sh msrp_zero_clean.sh Electric_Vehicle_Population_Data_cleaned_cafv.csv Electric_Vehicle_Population_Data_cleaned_msrp.csv
## ev_type_standardize.sh
This script standardizes vehicle type by replacing all instances of hybrid cars with “HYPBRID” and all instances of battery electric cars with “BATTERY”. <br />
The parameters are the input file and the output file.<br />
Ex: sh ev_type_standardize.sh Electric_Vehicle_Population_Data_cleaned_msrp.csv Electric_Vehicle_Population_Data_cleaned_hybrid_battery.csv
## address_standardize.sh
This script standardizes the county and city columns by capitalizing all values in the column that is selected. <br />
The parameters are the input file, the output file, and the column to be standardized (2 or 3).<br />
Ex: sh address_standardize.sh Electric_Vehicle_Population_Data_cleaned_hybrid_battery.csv temp.csv 2
## clean_non_WA.sh
This script removes all instances where the residency of the car owner is outside of Washington. <br />
The parameters are the input file, the output file.<br />
Ex: sh clean_non_WA.sh Electric_Vehicle_Population_Data_cleaned_hybrid_battery.csv temp.csv
## remove_missing_values.sh
This script removes all rows with missing values <br />
The parameters are the input file, the output file.<br />
Ex: sh remove_missing_values.sh Electric_Vehicle_Population_Data_cleaned_hybrid_battery.csv temp.csv
## coords_standardize.sh
This script standardizes the coordinates for longitude and latitude in the Vehicle Location column <br />
The parameters are the input file, the output file.<br />
Ex: sh coords_standardize.sh Electric_Vehicle_Population_Data_cleaned_hybrid_battery.csv temp.csv
## remove_fields.sh
This script removes removes the selected columns from the input file. <br />
The parameters are the input file, the output file, and the list of columns to be removed.<br />
Ex: sh remove_fields.sh Electric_Vehicle_Population_Data_cleaned_hybrid_battery.csv temp.csv 1,2,3,4,5

