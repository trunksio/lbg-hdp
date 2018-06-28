
echo "adminadmin" | kinit admin@LBG.DEV
ipa dnszone-mod 1.18.172.in-addr.arpa. --allow-sync-ptr=true
ipa dnszone-mod lbg.dev. --allow-sync-ptr=true
ipa dnsrecord-add lbg.dev. postgres --a-ip-address=172.18.1.3 --a-create-reverse

ipa user-add hadoopadmin --first=Hadoop --last=Admin
ipa group-add-member admins --users=hadoopadmin

ipa group-add ambari-managed-principals
ipa group-add hdfs-users
ipa group-add yarn-users
ipa group-add hive-users
ipa group-add kafka-users
ipa group-add ambari-users
ipa user-add cdcsa --first='CDC' --last='Service Account'
ipa group-add-member hdfs-users --users=cdcsa
ipa group-add-member yarn-users --users=cdcsa
ipa group-add-member hive-users --users=cdcsa
ipa group-add-member kafka-users --users=cdcsa
ipa group-add-member ambari-users --users=cdcsa

#ipa passwd hadoopadmin
#kinit hadoopadmin@LBG.DEV
#ipa passwd cdcsa
#kinit cdcsa@LBG.DEV

