docker-compose  -p lbg -f examples/compose/testNoAmbari.yml up -d
sleep 30
docker exec -ti lbg_master0.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_master0.lbg.dev_1 bash -c 'service messagebus restart'
docker exec -ti lbg_master0.lbg.dev_1 bash -c 'service oddjobd restart'
docker exec -ti lbg_master0.lbg.dev_1 bash -c 'service sssd restart'
docker exec -ti lbg_dn0.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_dn0.lbg.dev_1 bash -c 'service  messagebus restart'
docker exec -ti lbg_dn0.lbg.dev_1 bash -c 'service oddjobd restart'
docker exec -ti lbg_dn0.lbg.dev_1 bash -c 'service sssd restart'
docker exec -ti lbg_dn1.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_dn1.lbg.dev_1 bash -c 'service  messagebus restart'
docker exec -ti lbg_dn1.lbg.dev_1 bash -c 'service oddjobd restart'
docker exec -ti lbg_dn1.lbg.dev_1 bash -c 'service sssd restart'
docker exec -ti lbg_dn2.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_dn2.lbg.dev_1 bash -c 'service  messagebus restart'
docker exec -ti lbg_dn2.lbg.dev_1 bash -c 'service oddjobd restart'
docker exec -ti lbg_dn2.lbg.dev_1 bash -c 'service sssd restart'
#Zookeeper:
docker exec --user zookeeper lbg_dn0.lbg.dev_1 bash -c "export ZOOCFGDIR=/usr/hdp/current/zookeeper-server/conf ; export ZOOCFG=zoo.cfg; source /usr/hdp/current/zookeeper-server/conf/zookeeper-env.sh ; /usr/hdp/current/zookeeper-server/bin/zkServer.sh start"
docker exec --user zookeeper lbg_dn1.lbg.dev_1 bash -c "export ZOOCFGDIR=/usr/hdp/current/zookeeper-server/conf ; export ZOOCFG=zoo.cfg; source /usr/hdp/current/zookeeper-server/conf/zookeeper-env.sh ; /usr/hdp/current/zookeeper-server/bin/zkServer.sh start"
docker exec --user zookeeper lbg_dn2.lbg.dev_1 bash -c "export ZOOCFGDIR=/usr/hdp/current/zookeeper-server/conf ; export ZOOCFG=zoo.cfg; source /usr/hdp/current/zookeeper-server/conf/zookeeper-env.sh ; /usr/hdp/current/zookeeper-server/bin/zkServer.sh start"

#HDFS:
docker exec --user hdfs lbg_master0.lbg.dev_1 bash -c "/usr/hdp/current/hadoop-hdfs-namenode/../hadoop/sbin/hadoop-daemon.sh start namenode"

docker exec --user hdfs lbg_master0.lbg.dev_1 bash -c "/usr/hdp/current/hadoop-hdfs-namenode/../hadoop/sbin/hadoop-daemon.sh start secondarynamenode"

docker exec lbg_dn0.lbg.dev_1 bash -c "chown hdfs:hadoop /var/run/hadoop"
docker exec --user hdfs lbg_dn0.lbg.dev_1 bash -c "chown hdfs:hadoop /var/run/hadoop ; /usr/hdp/current/hadoop-hdfs-datanode/../hadoop/sbin/hadoop-daemon.sh start datanode"
docker exec lbg_dn1.lbg.dev_1 bash -c "chown hdfs:hadoop /var/run/hadoop"
docker exec --user hdfs lbg_dn1.lbg.dev_1 bash -c "chown hdfs:hadoop /var/run/hadoop ; /usr/hdp/current/hadoop-hdfs-datanode/../hadoop/sbin/hadoop-daemon.sh start datanode"
docker exec lbg_dn2.lbg.dev_1 bash -c "chown hdfs:hadoop /var/run/hadoop"
docker exec --user hdfs lbg_dn2.lbg.dev_1 bash -c "chown hdfs:hadoop /var/run/hadoop ; /usr/hdp/current/hadoop-hdfs-datanode/../hadoop/sbin/hadoop-daemon.sh start datanode"

#Yarn:
docker exec --user yarn lbg_master0.lbg.dev_1 bash -c "/usr/hdp/current/hadoop-yarn-resourcemanager/sbin/yarn-daemon.sh start resourcemanager"
docker exec --user yarn lbg_master0.lbg.dev_1 bash -c "/usr/hdp/current/hadoop-mapreduce-historyserver/sbin/mr-jobhistory-daemon.sh start historyserver"
docker exec --user yarn lbg_dn0.lbg.dev_1 bash -c "/usr/hdp/current/hadoop-yarn-nodemanager/sbin/yarn-daemon.sh start nodemanager"
docker exec --user yarn lbg_dn1.lbg.dev_1 bash -c "/usr/hdp/current/hadoop-yarn-nodemanager/sbin/yarn-daemon.sh start nodemanager"
docker exec --user yarn lbg_dn2.lbg.dev_1 bash -c "/usr/hdp/current/hadoop-yarn-nodemanager/sbin/yarn-daemon.sh start nodemanager"

# Hive:
docker exec --user hive lbg_master0.lbg.dev_1 bash -c "nohup /usr/hdp/current/hive-metastore/bin/hive --service metastore>/var/log/hive/hive.out 2>/var/log/hive/hive.log &"
# su $HIVE_USER 
docker exec --user hive lbg_master0.lbg.dev_1 bash -c "nohup /usr/hdp/current/hive-server2/bin/hiveserver2 -hiveconf hive.metastore.uris=' ' >>/tmp/hiveserver2HD.out 2>> /tmp/hiveserver2HD.log &"
docker exec --user hcat lbg_master0.lbg.dev_1 bash -c "/usr/hdp/current/hive-webhcat/sbin/webhcat_server.sh start &"

#Kafka:
docker exec --user kafka lbg_dn0.lbg.dev_1 bash -c "/usr/hdp/current/kafka-broker/bin/kafka start"
docker exec --user kafka lbg_dn1.lbg.dev_1 bash -c "/usr/hdp/current/kafka-broker/bin/kafka start"
docker exec --user kafka lbg_dn2.lbg.dev_1 bash -c "/usr/hdp/current/kafka-broker/bin/kafka start"

 
while (docker exec --user hdfs lbg_master0.lbg.dev_1 bash -c "hadoop dfsadmin -safemode get 2>/dev/null" | grep -vq OFF); do
  echo "waiting for safemode to exit."
  sleep  2
done
# create HDFS home dir for root:
docker exec --user hdfs lbg_master0.lbg.dev_1 bash -c "hadoop fs -mkdir /user/root"
docker exec --user hdfs lbg_master0.lbg.dev_1 bash -c "hadoop fs -chown root:root /user/root"

# create hive db
docker exec lbg_master0.lbg.dev_1 bash -c 'hive -S -e "create database CDC_TEST"'


# load kafka data
docker exec lbg_master0.lbg.dev_1 bash -c '/usr/jdk64/jdk1.8.0_112/bin/java -jar /jars/kafka-writer.jar /jars/kafka.properties CDC_TEST /jars/MOCK_DATA.json'

# run spark job
export JAVA_HOME=/usr/jdk64/jdk1.8.0_112/
docker exec lbg_master0.lbg.dev_1 bash -c 'export JAVA_HOME=/usr/jdk64/jdk1.8.0_112/; /usr/hdp/2.6.4.0-91/spark/bin/spark-submit --master yarn --deploy-mode client --driver-cores 1 --jars /usr/hdp/current/spark-client/lib/datanucleus-api-jdo-3.2.6.jar,/usr/hdp/current/spark-client/lib/datanucleus-rdbms-3.2.9.jar,/usr/hdp/current/spark-client/lib/datanucleus-core-3.2.10.jar --files /jars/spark/application.conf,/jars/spark/hive-site.xml --class com.lloydsbanking.edh.JobRunner /jars/spark/bd-edh-SparkStreaming-Avro-1.0.50-develop-jar-with-dependencies.jar ./application.conf'
# poll hive 
