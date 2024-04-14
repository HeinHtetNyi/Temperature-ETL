#! /bin/bash

# creating weather report filename
weather_report=raw_data_$(date +%Y%m%d)

# getting data and save it
curl wttr.in/Myanmar --output $weather_report

# prepare date
hour=$(TZ='Asia/Yangon' date -u +%H) 
day=$(TZ='Asia/Yangon' date -u +%d) 
month=$(TZ='Asia/Yangon' date +%m)
year=$(TZ='Asia/Yangon' date +%Y)


# extract temperature data
grep °C $weather_report > temperatures.txt


# extract current temperature
obs_tmp=$(head -1 temperatures.txt | tr -s " " | xargs | rev | cut -d " " -f2 | rev)

# extract the forecast temperature
fc_temp=$(head -3 temperatures.txt | tail -1 | tr -s " " | xargs | cut -d "C" -f2 | rev | cut -d " " -f2 |rev)


record=$(echo -e "$year\t$month\t$day\t$obs_tmp\t$fc_temp")
# append the record to rx_poc.log
echo $record>>rx_poc.log
