#!/bin/sh

if [[ $HOST == "" ]]; then
        echo $(date ) - HOST has not been defined, please set a host to be monitored
        exit 1
else

while true
        do ping -c1 $HOST &>/dev/null
        if [ $? = 0 ]; then
                if [[ $ALERTED == 1 ]]; then
                        ./send_mail.sh -s 'Host UP Notification' -b "Host $HOST is UP" -r c.mart@outlook.com
                        ALERTED=0
                fi
                FAIL_COUNT=0
                sleep 60s
        else
                FAIL_COUNT=$((FAIL_COUNT + 1))
                if [[ $FAIL_COUNT == 3 ]]; then
                        if [[ $ALERTED == 1 ]]; then
                                echo $(date +%D_%H:%M) - Fail count for host $HOST is $FAIL_COUNT >> /tmp/host_check.log
                        else
                                ./send_mail.sh -s 'Host DOWN Notification' -b "Host $HOST is DOWN" -r c.mart@outlook.com
                                ALERTED=1
                        fi
                else sleep 30s
                fi
        fi
done
fi
