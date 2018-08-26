#!/bin/bash
docker-compose  -p lbg -f examples/compose/ranger.yml stop 
docker commit lbg_ambari-server.lbg.dev_1 registry:443/ambari-server:$1
docker commit lbg_master0.lbg.dev_1 registry:443/master0:$1
docker commit lbg_dn0.lbg.dev_1 registry:443/dn0:$1
docker commit lbg_dn1.lbg.dev_1 registry:443/dn1:$1
docker commit lbg_dn2.lbg.dev_1 registry:443/dn2:$1
docker commit lbg_postgres.lbg.dev_1 registry:443/postgres:$1
docker commit lbg_ipa.lbg.dev_1 registry:443/ipa:$1
