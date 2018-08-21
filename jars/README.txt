####### create hdfs dir for root:
su - hdfs
hadoop fs -mkdir /user/root
hadoop fs -chown root:root /user/root

####### create hive database CDC_TEST:


####### to load data into kafka:
/usr/jdk64/jdk1.8.0_112/bin/java -jar kafka-writer.jar ./kafka.properties CDC_TEST MOCK_DATA.json

####### to drop table:
in hive:
drop table cdc_test;

in hdfs:

hadoop fs -rmr /user/root/HADOOP/RAW/CDC_TEST
