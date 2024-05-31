#!/usr/local/bin/bash

#run the df command and manipulate the results to store the information we want into variables
cap=$(df / | awk '/%/{print $5}' | sed 's/%//')
drive=$(df / | awk '/%/{print $1}')
space=$(df -h / | awk '/%/ {print $4}')

#if the capacity in use is higher than 90%, send a warning email
if [ $cap -ge 90 ]; then
        message="Running out of space on root drive ($drive), ${cap}% in use with $space available!"
        echo $message | mail -s "WARNING, disk space alert on $HOSTNAME" "osntemp2020@gmail.com"
fi