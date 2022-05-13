#!/usr/bin/env bash

DATE=$(date)
echo "$@" >> /etc/fail2ban/pushover.log

### PUSHOVER SETTINGS ###
PUSHOVER_URL="https://api.pushover.net/1/messages.json"
PUSHOVER_API_TOKEN="your application token"
PUSHOVER_USER_TOKEN="your user or group token"


### PUSHOVER MSG ###

if [ "$1" == "ban" ]; then
    ### Report a new ban ###
    EXPIRE=$(date -d "$DATE + $4 seconds")
    PUSHOVER_PRIORITY=0
    PUSHOVER_TITLE="Fail2ban Ban Notification"
    PUSHOVER_MESSAGE="($DATE): NEW BAN! $2 was added to the $3 jail until $EXPIRE."
elif [ "$1" == "unban" ]; then
    ### Report a low priority unban ###
    PUSHOVER_PRIORITY=-1
    PUSHOVER_TITLE="Fail2ban Unban Notification"
    PUSHOVER_MESSAGE="($DATE): EXPIRED! $2 was removed from the $3 jail."
else
    ### abandon a broken notification ###
    exit 0
fi

### SEND TO PUSHOVER API ###
curl -s --data token="$PUSHOVER_API_TOKEN" --data user="$PUSHOVER_USER_TOKEN" --data-urlencode title="$PUSHOVER_TITLE" --data priority=$PUSHOVER_PRIORITY --data-urlencode message="$PUSHOVER_MESSAGE" $PUSHOVER_URL > /dev/null 2>&1 &