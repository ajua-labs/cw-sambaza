G_DIR="/var/log/auth.log"

#grep previous hour failed logins
SEARCH_DATE=$(date +"%b  %-d %H" -d-1hour)

MONITOR_IP="34.218.85.207"
MONITOR_USER="monitoringmaster"

SEARCH_STRING="Failed password for invalid"

SEARCH_IGNORE_STRING="COMMAND=/bin/grep"

SEARCH_IGNORE_STRING_FINAL="port"
FAILED_LOGIN_FILE="failedlogins.txt"

#Change this for every server
LOCAL_SERVER="Scheduler Primary (52.24.125.137)"

PREVIOUS_EAT_HOUR=$(date +"%H" -d2hour)
sudo grep "${SEARCH_DATE}.* ${SEARCH_STRING}.*"  ${LOG_DIR} | grep -v ${SEARCH_IGNORE_STRING} | grep -o "${SEARCH_STRING}.*"| sort | uniq -c > ${FAILED_LOGIN_FILE}
echo "Here I am"
if [ -s ${FAILED_LOGIN_FILE} ]
then

    ssh "${MONITOR_USER}"@"${MONITOR_IP}" 'mail -s "Failed Logins for Server '${LOCAL_SERVER}': Hour Failed '${PREVIOUS_EAT_HOUR}' Hours" -r "monitoringmaster@msurvey.co" "marc.murua@msurvey.co, george.githae@msurvey.co, cyrus.kariuki"' <failedlogins.txt
fi

