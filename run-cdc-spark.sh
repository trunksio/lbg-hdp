
docker exec --user hdfs lbg_master0.lbg.dev_1 bash -c "hadoop fs -mkdir /user/root"
docker exec --user hdfs lbg_master0.lbg.dev_1 bash -c "hadoop fs -chown root:root /user/root"

docker exec -ti lbg_dn0.lbg.dev_1 bash -c "/usr/hdp/2.6.4.0-91/kafka/bin/kafka-topics.sh --zookeeper localhost:2181 --create --topic CDC_TEST --replication-factor 3 --partitions 1"

docker cp ../application.conf lbg_master0.lbg.dev_1:/
docker cp /jars/bd-edh-SparkStreaming-Avro-1.0.50-develop-jar-with-dependencies.jar lbg_master0.lbg.dev_1:/
docker exec --user root lbg_master0.lbg.dev_1 bash -c "chown hdfs:hdfs bd-edh-SparkStreaming-Avro-1.0.50-develop-jar-with-dependencies.jar application.conf"
docker exec --user root lbg_master0.lbg.dev_1 bash -c "export JAVA_HOME=/usr/jdk64/jdk1.8.0_112/; /usr/hdp/2.6.4.0-91/spark/bin/spark-submit --master yarn --deploy-mode cluster --driver-cores 1 --jars /usr/hdp/current/spark-client/lib/datanucleus-api-jdo-3.2.6.jar,/usr/hdp/current/spark-client/lib/datanucleus-rdbms-3.2.9.jar,/usr/hdp/current/spark-client/lib/datanucleus-core-3.2.10.jar --files ./application.conf --class com.lloydsbanking.edh.JobRunner ./bd-edh-SparkStreaming-Avro-1.0.50-develop-jar-with-dependencies.jar ./application.conf"