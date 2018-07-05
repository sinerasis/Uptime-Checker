#!/bin/bash

# checks an array of urls for a 200 html response using cURL
# sends an email if the response is anything other than 200/OK

# sites to check (array)
sites=(
	#https://www.sample.com
	#http://www.anothersite.com
)

for i in ${sites[@]}; do
	# uses curl to make http request and save the status code to a variable
	status=$(curl -o /dev/null -u root:root -Isw '%{http_code}' ${i})

	# check the status code to see if it's 200, send an email if not
	if [ ${status} -ne "200" ]; then
		# full path of binary must be used because cron has a limited PATH!
		echo "Subject: ${i} down!" | /usr/sbin/sendmail your@email.com
	fi
done