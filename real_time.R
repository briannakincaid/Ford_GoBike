
library(tidyverse)
library(tidyr)
library(dplyr)
library(jsonlite)
library(anytime)


# data point 1
stationstatus1 <- fromJSON("station_status.json")
time1 <- stationstatus1$last_updated
stationstatus1 <- stationstatus1$data$stations 

stationstatus1 <- stationstatus1 %>%
  select(-eightd_has_available_keys) %>%
  select(-eightd_active_station_services)

stationstatus1_sf <- full_join(stationstatus1, id_capacity_sf, by = "station_id")
stationstatus1_sf <- filter(stationstatus1_sf, !is.na(capacity))

stationstatus1_sf <- stationstatus1_sf %>%
  mutate(percent_filled = num_bikes_available/capacity) %>%
  filter(!is.na(percent_filled))

# data point 2
stationstatus2 <- fromJSON("station_status2.json")
time2 <- stationstatus2$last_updated
stationstatus2 <- stationstatus2$data$stations 

stationstatus2 <- stationstatus2 %>%
  select(-eightd_has_available_keys) %>%
  select(-eightd_active_station_services)

stationstatus2_sf <- full_join(stationstatus2, id_capacity_sf, by = "station_id")
stationstatus2_sf <- filter(stationstatus2_sf, !is.na(capacity))

stationstatus2_sf <- stationstatus2_sf %>%
  mutate(percent_filled = num_bikes_available/capacity) %>%
  filter(!is.na(percent_filled))

# data point 3
stationstatus3 <- fromJSON("station_status3.json")
time3 <- stationstatus3last_updated
stationstatus3 <- stationstatus3$data$stations 

stationstatus3 <- stationstatus3 %>%
  select(-eightd_has_available_keys) %>%
  select(-eightd_active_station_services)

stationstatus3_sf <- full_join(stationstatus3, id_capacity_sf, by = "station_id")
stationstatus3_sf <- filter(stationstatus3_sf, !is.na(capacity))

stationstatus3_sf <- stationstatus3_sf %>%
  mutate(percent_filled = num_bikes_available/capacity) %>%
  filter(!is.na(percent_filled))

# data point 4
stationstatus4 <- fromJSON("station_status4.json")
time4 <- stationstatus4$last_updated
stationstatus4 <- stationstatus4$data$stations 

stationstatus4 <- stationstatus4 %>%
  select(-eightd_has_available_keys) %>%
  select(-eightd_active_station_services)

stationstatus4_sf <- full_join(stationstatus4, id_capacity_sf, by = "station_id")
stationstatus4_sf <- filter(stationstatus4_sf, !is.na(capacity))

stationstatus4_sf <- stationstatus4_sf %>%
  mutate(percent_filled = num_bikes_available/capacity) %>%
  filter(!is.na(percent_filled))

# data point 5
stationstatus5 <- fromJSON("station_status5.json")
time5 <- stationstatus5$last_updated
stationstatus5 <- stationstatus5$data$stations 

stationstatus5 <- stationstatus5 %>%
  select(-eightd_has_available_keys) %>%
  select(-eightd_active_station_services)

stationstatus5_sf <- full_join(stationstatus5, id_capacity_sf, by = "station_id")
stationstatus5_sf <- filter(stationstatus5_sf, !is.na(capacity))

stationstatus5_sf <- stationstatus5_sf %>%
  mutate(percent_filled = num_bikes_available/capacity) %>%
  filter(!is.na(percent_filled))

# data point 6
stationstatus6 <- fromJSON("station_status6.json")
time6 <- stationstatus6$last_updated
stationstatus6 <- stationstatus6$data$stations 

stationstatus6 <- stationstatus6 %>%
  select(-eightd_has_available_keys) %>%
  select(-eightd_active_station_services)

stationstatus6_sf <- full_join(stationstatus6, id_capacity_sf, by = "station_id")
stationstatus6_sf <- filter(stationstatus6_sf, !is.na(capacity))

stationstatus6_sf <- stationstatus6_sf %>%
  mutate(percent_filled = num_bikes_available/capacity) %>%
  filter(!is.na(percent_filled))

# data point 7
stationstatus7 <- fromJSON("station_status7.json")
time7 <- stationstatus7$last_updated
stationstatus7 <- stationstatus7$data$stations 

stationstatus7 <- stationstatus7 %>%
  select(-eightd_has_available_keys) %>%
  select(-eightd_active_station_services)

stationstatus7_sf <- full_join(stationstatus7, id_capacity_sf, by = "station_id")
stationstatus7_sf <- filter(stationstatus7_sf, !is.na(capacity))

stationstatus7_sf <- stationstatus7_sf %>%
  mutate(percent_filled = num_bikes_available/capacity) %>%
  filter(!is.na(percent_filled))

# data point 8
stationstatus8 <- fromJSON("station_status8.json")
time8 <- stationstatus8$last_updated
stationstatus8 <- stationstatus8$data$stations 

stationstatus8 <- stationstatus8 %>%
  select(-eightd_has_available_keys) %>%
  select(-eightd_active_station_services)

stationstatus8_sf <- full_join(stationstatus8, id_capacity_sf, by = "station_id")
stationstatus8_sf <- filter(stationstatus8_sf, !is.na(capacity))

stationstatus8_sf <- stationstatus8_sf %>%
  mutate(percent_filled = num_bikes_available/capacity) %>%
  filter(!is.na(percent_filled))

# data point 9
stationstatus9 <- fromJSON("station_status9.json")
time9 <- stationstatus9$last_updated
stationstatus9 <- stationstatus9$data$stations 

stationstatus9 <- stationstatus9 %>%
  select(-eightd_has_available_keys) %>%
  select(-eightd_active_station_services)

stationstatus9_sf <- full_join(stationstatus9, id_capacity_sf, by = "station_id")
stationstatus9_sf <- filter(stationstatus9_sf, !is.na(capacity))

stationstatus9_sf <- stationstatus9_sf %>%
  mutate(percent_filled = num_bikes_available/capacity) %>%
  filter(!is.na(percent_filled))

# data point 10
stationstatus10 <- fromJSON("station_status10.json")
time10 <- stationstatus10$last_updated
stationstatus10 <- stationstatus10$data$stations 

stationstatus10 <- stationstatus10 %>%
  select(-eightd_has_available_keys) %>%
  select(-eightd_active_station_services)

stationstatus10_sf <- full_join(stationstatus10, id_capacity_sf, by = "station_id")
stationstatus10_sf <- filter(stationstatus10_sf, !is.na(capacity))

stationstatus10_sf <- stationstatus10_sf %>%
  mutate(percent_filled = num_bikes_available/capacity) %>%
  filter(!is.na(percent_filled))

# data point 11
stationstatus11 <- fromJSON("station_status11.json")
time11 <- stationstatus11$last_updated
stationstatus11 <- stationstatus11$data$stations 

stationstatus11 <- stationstatus11 %>%
  select(-eightd_has_available_keys) %>%
  select(-eightd_active_station_services)

stationstatus11_sf <- full_join(stationstatus11, id_capacity_sf, by = "station_id")
stationstatus11_sf <- filter(stationstatus11_sf, !is.na(capacity))

stationstatus11_sf <- stationstatus11_sf %>%
  mutate(percent_filled = num_bikes_available/capacity) %>%
  filter(!is.na(percent_filled))


real_time_data <- rbind(
  stationstatus1_sf,
  stationstatus2_sf,
  stationstatus3_sf,
  stationstatus4_sf,
  stationstatus5_sf,
  stationstatus6_sf,
  stationstatus7_sf,
  stationstatus8_sf,
  stationstatus9_sf,
  stationstatus10_sf,
  stationstatus11_sf
)

real_time_data <- real_time_data %>%
  mutate(time = anytime(last_reported)) %>%
  select(-last_reported)

write_csv(real_time_data,"real_time_data.csv")


stationinfo <- fromJSON("station_information.json")
stationinfo <- stationinfo$data$stations

stationinfo <- stationinfo %>%
  select(-rental_methods) %>%
  select(-rental_url) %>%
  select(-eightd_has_key_dispenser) %>%
  select(-eightd_station_services)

stationinfo_sf <- filter(stationinfo, region_id==3)
id_capacity_sf <- stationinfo_sf %>%
  select(station_id, capacity)


write_csv(stationinfo_sf,"stationinfo_sf.csv")
write_csv(stationinfo,"stationinfo.csv")
#writing the real time data to a file to be used in the shiny app
