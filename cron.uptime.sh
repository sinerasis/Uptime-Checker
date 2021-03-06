#!/bin/bash

# checks an array of urls for a 200 html response using cURL
# sends an email if the response is anything other than 200/OK

# sites to check (array)
sites=(
	#https://www.sample.com
	#http://www.anothersite.com
)

#notification addresses (array)
notify=(
	#sample@email.com
)

# path to logfile
logfile=/var/log/cron.uptime.log

# maximum size of log file, in bytes
logfilemax=500000

for i in ${sites[@]}; do
	# uses curl to make http request and save the status code to a variable
	status=$(curl -o /dev/null -u root:root -Isw '%{http_code}' ${i})

	# write result to file
	echo `date`","${i}","${status} >> /var/log/cron.uptime.log

	# check the status code to see if it's 200, send an email if not
	if [ ${status} -ne "200" ]; then
		# send email to each notification address, full path of binary must be used because cron has a limited PATH!
		for email in ${notify}; do
			echo "Subject: ${i} alert!" | /usr/sbin/sendmail ${email}
		done
	fi
done

# get the current size of the logfile
logfilesize=$(wc -c <"$logfile")

# if our log file is getting large, cycle it
if [ $logfilesize -ge $logfilemax ]; then
	# get the current date
	date=`date '+%Y%m%d-%H.%M.%S'`

	# rename (move) the log file
	mv "$logfile" "$logfile"-"$date"
fi
