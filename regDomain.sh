docker cp manualIPAsteps.sh lbg_ipa.lbg.dev_1:/tmp 
docker exec -ti lbg_ipa.lbg.dev_1 bash -c '/tmp/manualIPAsteps.sh'
docker exec -ti lbg_master0.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_master0.lbg.dev_1 bash -c 'ipa-client-install --enable-dns-updates --mkhomedir --ssh-trust-dns --principal=admin --password=adminadmin --unattended'
docker exec -ti lbg_master0.lbg.dev_1 bash -c 'service oddjobd start'
docker exec -ti lbg_dn0.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_dn0.lbg.dev_1 bash -c 'ipa-client-install --enable-dns-updates --mkhomedir --ssh-trust-dns --principal=admin --password=adminadmin --unattended'
docker exec -ti lbg_dn0.lbg.dev_1 bash -c 'service oddjobd start'
docker exec -ti lbg_dn1.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_dn1.lbg.dev_1 bash -c 'ipa-client-install --enable-dns-updates --mkhomedir --ssh-trust-dns --principal=admin --password=adminadmin --unattended'
docker exec -ti lbg_dn1.lbg.dev_1 bash -c 'service oddjobd start'
docker exec -ti lbg_dn2.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_dn2.lbg.dev_1 bash -c 'ipa-client-install --enable-dns-updates --mkhomedir --ssh-trust-dns --principal=admin --password=adminadmin --unattended'
docker exec -ti lbg_dn2.lbg.dev_1 bash -c 'service oddjobd start'
docker exec -ti lbg_ambari-server.lbg.dev_1 bash -c 'cp /etc/resolv.conf.bak /etc/resolv.conf'
docker exec -ti lbg_ambari-server.lbg.dev_1 bash -c 'ipa-client-install --enable-dns-updates --mkhomedir --ssh-trust-dns --principal=admin --password=adminadmin --unattended'
docker exec -ti lbg_ambari-server.lbg.dev_1 bash -c 'service oddjobd start'
curl -u admin:admin -i -H 'X-Requested-By: ambari' -X POST -d '{"user-pref-admin-supports":"{\"disableHostCheckOnAddHostWizard\":false,\"preUpgradeCheck\":true,\"displayOlderVersions\":false,\"autoRollbackHA\":false,\"alwaysEnableManagedMySQLForHive\":false,\"preKerberizeCheck\":false,\"customizeAgentUserAccount\":false,\"installGanglia\":false,\"opsDuringRollingUpgrade\":false,\"customizedWidgetLayout\":false,\"showPageLoadTime\":false,\"skipComponentStartAfterInstall\":false,\"preInstallChecks\":false,\"serviceAutoStart\":true,\"logSearch\":true,\"redhatSatellite\":false,\"enableIpa\":true,\"addingNewRepository\":false,\"kerberosStackAdvisor\":true,\"logCountVizualization\":false,\"enabledWizardForHostOrderedUpgrade\":true,\"manageJournalNode\":true}"}'   http://localhost:8080/api/v1/persist
