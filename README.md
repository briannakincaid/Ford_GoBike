# Ford GoBike
MA415 Final Project

## IMPORTANT NOTES

Due to file size limits by GitHub, the main data file could not be uploaded. However, the data can easily be downloaded from

https://s3.amazonaws.com/fordgobike-data/index.html

Please select the first file ("2017-fordgobike-tripdata.csv"), download, and rename it tripdata_2017.csv. It then needs to be placed in the main directory as well as in FordGoBike/data/tripdata_2017.csv (the Shiny app directory). Otherwise, nothing will run. 

## Description of Files

Project Description: Document.Rmd & Document.pdf
Project File: Ford_GoBike.Rproj

Historical Data:
* tripdata_2017.csv

Real Time Data:
* station_information.json
* station_status[1-10].json 

* real_time_data.csv (Note: this is a cleaned data set consisting of data from station_status[1-10].json that is tidied in real_time.R and exported for further use)
* stationinfo_sf.csv (Note: this is a cleaned data set consisting of data from station_information.json that is tidied in real_time.R and exported for further use)

Script Files:
* real_time.R
* trip_hist.R

