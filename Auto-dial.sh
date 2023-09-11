cd ~
while true
do
    if ping -c 1 -W 1 10.10.16.12 > /dev/null #Internal HHT Portal Test
    then 
        echo -e "$(date) - HHT Successful" >> log.txt
        if ping -c 1 -W 1 223.5.5.5 > /dev/null # China internal net
        then
            echo -e "$(date) - China successful" >> log.txt
            if curl -s -o /dev/null https://www.google.com; then
                echo -e "$(date) - Google successful" >> log.txt
            else 
                echo -e "$(date) - Google Error" >> log.txt
                /etc/init.d/passwall restart
            fi
        else
            echo -e "$(date) - China failed, executing login.sh" >> log.txt
            ./logout.sh
            ./login-cmcc.sh
        fi
    else 
        echo -e "$(date) - HHT error" >> log.txt
        reboot
    fi
    sleep 1
done
