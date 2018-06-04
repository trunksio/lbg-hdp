docker-compose  -p lbg -f examples/compose/multi-container.yml down 
docker volume rm lbg_dn0-data lbg_dn1-data lbg_dn2-data lbg_krb5kdc-data lbg_master0-data
