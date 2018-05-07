library(ggplot2)
library(tidyverse)
library(tidyr)
library(ggmap)
library(dplyr)
library(jsonlite)
library(anytime)

#importing

tripdata_2017 <- read_csv("tripdata_2017.csv")

#separating date

tripdata_2017 <- tripdata_2017 %>%
  separate(start_time, c("Start_Year","Start_Month","Start_Day","Start_Hour","Start_Minute","Start_Second")) %>%
  separate(end_time, c("End_Year","End_Month","End_Day","End_Hour","End_Minute","End_Second"))

#dealing with NAs

not_specified <- tripdata_2017[is.na(tripdata_2017$member_birth_year),] %>%
  mutate(member_birth_year = "Not Specified")
specified <- tripdata_2017[!is.na(tripdata_2017$member_birth_year),]

tripdata_2017 <- rbind(not_specified, specified)

not_specified2 <- tripdata_2017[is.na(tripdata_2017$member_gender),] %>%
  mutate(member_gender = "Not Specified")
specified2 <- tripdata_2017[!is.na(tripdata_2017$member_gender),]

tripdata_2017 <- rbind(not_specified2, specified2)



#SUMMARIES AND FREQUENCY TABLES

# DURATION

# Average Trip Duration Per Month

duration_month <- tripdata_2017 %>%
  group_by(Start_Month) %>%
  summarize(Average_Duration = mean(duration_sec))

# Average duration per day of month

duration_day <- tripdata_2017 %>%
  group_by(Start_Day) %>%
  summarize(Average_Duration = mean(duration_sec))

# Average duration per start hour

duration_hour <- tripdata_2017 %>%
  group_by(Start_Hour) %>%
  summarize(Average_Duration = mean(duration_sec))

# average duration per start station

duration_startstat <- tripdata_2017 %>%
  group_by(start_station_id) %>%
  summarize(Average_Duration = mean(duration_sec))

# average duration per end station

duration_endstat <- tripdata_2017 %>%
  group_by(end_station_id) %>%
  summarize(Average_Duration = mean(duration_sec))

# average duration per bike id

duration_bike <- tripdata_2017 %>%
  group_by(bike_id) %>%
  summarize(Average_Duration = mean(duration_sec))

# average duration for each user type

duration_user <- tripdata_2017 %>%
  group_by(user_type) %>%
  summarize(Average_Duration = mean(duration_sec))

# average duration for each birth year

duration_birth <- tripdata_2017 %>%
  group_by(member_birth_year) %>%
  summarize(Average_Duration = mean(duration_sec))

# average duration for each gender

duration_gender <- tripdata_2017 %>%
  group_by(member_gender) %>%
  summarize(Average_Duration = mean(duration_sec))


#number of trips per duration ??



# START MONTH

# number of trips during each month 
trips_month <- tripdata_2017 %>%
  group_by(Start_Month) %>%
  summarize(Trips = n())


# START DAY

# number of trips each day (for EVERY day)
trips_everyday <- tripdata_2017 %>%
  group_by(Start_Month, Start_Day) %>%
  summarize(Trips = n())

# average number of trips for certain day of the month
trips_day <- trips_everyday %>%
  group_by(Start_Day) %>%
  summarize(Average_Trips = mean(Trips))



# START_HOUR    

#average number of trips started at a certain hour of the day

trips_everyshour <- tripdata_2017 %>%
  group_by(Start_Month, Start_Day, Start_Hour) %>%
  summarize(Trips = n())
  
trips_starthour <- trips_everyshour %>%
  group_by(Start_Hour) %>%
  summarize(Average_Trips = mean(Trips))


# END HOUR

#average number of trips ended at a certain hour of the day

trips_everyehour <- tripdata_2017 %>%
  group_by(End_Month, End_Day, End_Hour) %>%
  summarize(Trips = n())

trips_endhour <- trips_everyehour %>%
  group_by(End_Hour) %>%
  summarize(Average_Trips = mean(Trips))




# START STATION ID

# total number of trips per station id (total all data)

trips_startstat <- tripdata_2017 %>%
  group_by(start_station_id, start_station_longitude, start_station_latitude) %>%
  summarize(Trips = n()) %>%
  arrange(desc(Trips))

top_startstat <- trips_startstat[1:10,]

ggplot(top_startstat) +
  geom_bar(mapping=aes(x=as.factor(start_station_id), y=Trips), stat = "identity", fill = "aquamarine3")+
  xlab("Start Station ID") +
  ylab("Number of Trips") 

# average number of trips per station broken down by month (only do this for top stations)
# average number of trips per station broken down by day of month (only do this for top stations)
# average number of trips per station broken down by start hour (only do this for top stations)
# average number of trips per station broken down by end hour (only do this for top stations)




# END STATION ID

# total number of trips per station id (total all data)

trips_endstat <- tripdata_2017 %>%
  group_by(end_station_id, end_station_longitude, end_station_latitude) %>%
  summarize(Trips = n()) %>%
  arrange(desc(Trips))

top_endstat <- trips_endstat[1:10,]

ggplot(top_endstat) +
  geom_bar(mapping=aes(x=as.factor(end_station_id), y=Trips), stat = "identity", fill = "aquamarine3")+
  xlab("End Station ID") +
  ylab("Number of Trips")
    
# average number of trips per station broken down by month (only do this for top stations)
# average number of trips per station broken down by day of month (only do this for top stations)
# average number of trips per station broken down by start hour (only do this for top stations)
# average number of trips per station broken down by end hour (only do this for top stations)




# BIKE ID   

# total number of trips per bike id 

trips_bike <- tripdata_2017 %>%
  group_by(bike_id) %>%
  summarize(Trips = n()) %>%
  arrange(desc(Trips))

top_bikes <- trips_bike[1:10,]

# USER TYPE  

# total number of trips per user_type

trips_user <- tripdata_2017 %>%
  group_by(user_type) %>%
  summarize(Trips = n()) 

# BIRTH YEAR 

# total number of trips per birth year

trips_birth <- tripdata_2017 %>%
  group_by(member_birth_year) %>%
  summarize(Trips = n()) %>%
  mutate(Age = 2017 - as.numeric(member_birth_year))


# GENDER

# total number of trips per gender (MAKE SURE TO INCLUDE not specified)

trips_gender <- tripdata_2017 %>%
  group_by(member_gender) %>%
  summarize(Trips = n()) 











month_summary <- tripdata_2017 %>%
  group_by(Start_Month) %>%
  summarize(count=n())

start_station_summary <- tripdata_2017 %>%
  group_by(start_station_id, start_station_longitude,start_station_latitude) %>%
  summarize(count=n()) %>%
  arrange(desc(count))

# Top three:

#(15)
#(6)
#(30)


end_station_summary <- tripdata_2017 %>%
  group_by(end_station_id, end_station_longitude,end_station_latitude) %>%
  summarize(count=n()) %>%
  arrange(desc(count))

# Top three:
#(30)
#(15)
#(6)

ggmap(sf_roadmap) + 
  geom_point(data= filter(stationinfo_sf, station_id == 30 | station_id == 15 | station_id == 6), 
             mapping=aes(x=lon, y=lat, color = station_id),size=2)


#so let's examine stations 15, 6, and 30 in real time data (see above)



hour_summary <- tripdata_2017 %>%
  group_by(Start_Hour) %>%
  summarize(count=n())

ggplot(hour_summary) +
  geom_col(mapping=aes(x=Start_Hour,y=count))



ggplot() + 
  geom_col(data=month_summary, mapping=aes(x=Start_Month,y=count)) +
  ylab("Number of Trips") +
  xlab("Month")



ggplot(tripdata_2017) +
  geom_histogram(mapping=aes(x=start_station_id),binwidth=1) +
  ylab("Number of Trips") +
  xlab("Start Station ID")

ggplot(filter(tripdata_2017,Start_Month == "06")) +
  geom_histogram(mapping=aes(x=start_station_id),binwidth=1) +
  ylab("Number of Trips") +
  xlab("Start Station ID")

ggplot(filter(tripdata_2017,Start_Month == "07")) +
  geom_histogram(mapping=aes(x=start_station_id),binwidth=1) +
  ylab("Number of Trips") +
  xlab("Start Station ID")

ggplot(filter(tripdata_2017,Start_Month == "08")) +
  geom_histogram(mapping=aes(x=start_station_id),binwidth=1) +
  ylab("Number of Trips") +
  xlab("Start Station ID")

ggplot(filter(tripdata_2017,Start_Month == "09")) +
  geom_histogram(mapping=aes(x=start_station_id),binwidth=1) +
  ylab("Number of Trips") +
  xlab("Start Station ID")

ggplot(filter(tripdata_2017,Start_Month == "10")) +
  geom_histogram(mapping=aes(x=start_station_id),binwidth=1) +
  ylab("Number of Trips") +
  xlab("Start Station ID")

ggplot(filter(tripdata_2017,Start_Month == "11")) +
  geom_histogram(mapping=aes(x=start_station_id),binwidth=1) +
  ylab("Number of Trips") +
  xlab("Start Station ID")

ggplot(filter(tripdata_2017,Start_Month == "12")) +
  geom_histogram(mapping=aes(x=start_station_id),binwidth=1) +
  ylab("Number of Trips") +
  xlab("Start Station ID")

ggplot(filter(tripdata_2017,duration_sec < 10000)) +
  geom_histogram(mapping=aes(x=duration_sec,fill=Start_Hour),binwidth=300)

ggplot(filter(tripdata_2017,duration_sec < 10000,Start_Month == "12")) +
  geom_histogram(mapping=aes(x=duration_sec,fill=Start_Hour),binwidth=300)

ggplot(filter(tripdata_2017,duration_sec < 10000,Start_Month == "11")) +
  geom_histogram(mapping=aes(x=duration_sec,fill=Start_Hour),binwidth=300)

ggplot(filter(tripdata_2017,duration_sec < 10000,Start_Month == "10")) +
  geom_histogram(mapping=aes(x=duration_sec,fill=Start_Hour),binwidth=300)

ggplot(filter(tripdata_2017,duration_sec < 10000,Start_Month == "09")) +
  geom_histogram(mapping=aes(x=duration_sec,fill=Start_Hour),binwidth=300)

ggplot(filter(tripdata_2017,duration_sec < 10000,Start_Month == "08")) +
  geom_histogram(mapping=aes(x=duration_sec,fill=Start_Hour),binwidth=300)

ggplot(filter(tripdata_2017,duration_sec < 10000,Start_Month == "07")) +
  geom_histogram(mapping=aes(x=duration_sec,fill=Start_Hour),binwidth=300)

ggplot(filter(tripdata_2017,duration_sec < 10000,Start_Month == "06")) +
  geom_histogram(mapping=aes(x=duration_sec,fill=Start_Hour),binwidth=300)











ggmap(sf_roadmap) +
  geom_point(data=filter(tripdata_sep2017,Start_Day == "01"),mapping=aes(x=start_station_longitude,y=start_station_latitude),alpha=1/15)

ggmap(sf_roadmap) +
  geom_point(data=filter(tripdata_sep2017,Start_Day == "15"),mapping=aes(x=start_station_longitude,y=start_station_latitude,color=user_type),alpha=1/15)




