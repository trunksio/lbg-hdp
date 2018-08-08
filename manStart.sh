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

