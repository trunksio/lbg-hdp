#!/bin/bash
sed -i "s/hostname=localhost/hostname=ambari-server.lbg.dev/" /etc/ambari-agent/conf/ambari-agent.ini
ambari-agent start

while true; do
  sleep 3
  tail -f /var/log/ambari-agent/ambari-agent.log
done
