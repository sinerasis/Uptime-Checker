# Uptime-Checker
A simple bash script that can be used with a server cron scheduler to log and/or notify you of website downtime.

## Usage
In your cron file, include a definition to run the script at your desired check interval. For example, to check sites every 5 minutes for availablity use:

```
*/5 * * * * /bin/bash /path/to/cron.uptime.sh
```

## Notes

Remember to edit the array of sites and enter your email address in the script itself!
