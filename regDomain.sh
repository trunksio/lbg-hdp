docker cp manualIPAsteps.sh lbg_ipa.lbg.dev_1:/tmp 
docker exec -ti lbg_ipa.lbg.dev_1 bash -c '/tmp/manualIPAsteps.sh'
docker exec -ti lbg_master0.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_master0.lbg.dev_1 bash -c 'ipa-client-install --no-ntp --enable-dns-updates --mkhomedir --ssh-trust-dns --principal=admin --password=adminadmin --unattended'
docker exec -ti lbg_master0.lbg.dev_1 bash -c 'service oddjobd start'
docker exec -ti lbg_dn0.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_dn0.lbg.dev_1 bash -c 'ipa-client-install --no-ntp --enable-dns-updates --mkhomedir --ssh-trust-dns --principal=admin --password=adminadmin --unattended'
docker exec -ti lbg_dn0.lbg.dev_1 bash -c 'service oddjobd start'
docker exec -ti lbg_dn1.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_dn1.lbg.dev_1 bash -c 'ipa-client-install --no-ntp --enable-dns-updates --mkhomedir --ssh-trust-dns --principal=admin --password=adminadmin --unattended'
docker exec -ti lbg_dn1.lbg.dev_1 bash -c 'service oddjobd start'
docker exec -ti lbg_dn2.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_dn2.lbg.dev_1 bash -c 'ipa-client-install --no-ntp --enable-dns-updates --mkhomedir --ssh-trust-dns --principal=admin --password=adminadmin --unattended'
docker exec -ti lbg_dn2.lbg.dev_1 bash -c 'service oddjobd start'
docker exec -ti lbg_ambari-server.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_ambari-server.lbg.dev_1 bash -c 'ipa-client-install --no-ntp --enable-dns-updates --mkhomedir --ssh-trust-dns --principal=admin --password=adminadmin --unattended'
docker exec -ti lbg_ambari-server.lbg.dev_1 bash -c 'service oddjobd start'
####WTF??? hack to remove old java7 jdbc driver from hive directory:
docker exec -ti lbg_master0.lbg.dev_1 bash -c "rm /usr/hdp/2.6.4.0-91/hive2/lib/postgresql-9.4.1208.jre7.jar"
####Set ipaserver in ambari experimental
curl -u admin:admin -i -H 'X-Requested-By: ambari' -X POST -d '{"user-pref-admin-supports":"{\"disableHostCheckOnAddHostWizard\":false,\"preUpgradeCheck\":true,\"displayOlderVersions\":false,\"autoRollbackHA\":false,\"alwaysEnableManagedMySQLForHive\":false,\"preKerberizeCheck\":false,\"customizeAgentUserAccount\":false,\"installGanglia\":false,\"opsDuringRollingUpgrade\":false,\"customizedWidgetLayout\":false,\"showPageLoadTime\":false,\"skipComponentStartAfterInstall\":false,\"preInstallChecks\":false,\"serviceAutoStart\":true,\"logSearch\":true,\"redhatSatellite\":false,\"enableIpa\":true,\"addingNewRepository\":false,\"kerberosStackAdvisor\":true,\"logCountVizualization\":false,\"enabledWizardForHostOrderedUpgrade\":true,\"manageJournalNode\":true}"}'   http://localhost:8080/api/v1/persist
docker cp lbg_ipa.lbg.dev_1:/etc/ipa/ca.crt .
