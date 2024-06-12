SERVICO="httpd"
STATUS=$(systemctl is-active $SERVICE)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
MESSAGE=""

if [ "$STATUS" = "active" ]; then
  MESSAGE="ONLINE"
  echo "$TIMESTAMP - $SERVICE - $STATUS - $MESSAGE" >> srv/nfs/stedata/service_online.log
else
  MESSAGE="OFFLINE"
  echo "$TIMESTAMP - $SERVICE - $STATUS - $MESSAGE" >> srv/nfs/stedata/service_offline.log
fi
