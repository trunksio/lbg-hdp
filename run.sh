curl -v -k -u admin:admin -H "X-Requested-By:ambari" -X POST http://localhost:8080/api/v1/version_definitions  -d '{"VersionDefinition": {"version_url": "file:/tmp/HDP-2.6.4.0-91.xml" } }'
curl --user admin:admin -H 'X-Requested-By:admin' -X POST http://localhost:8080/api/v1/blueprints/hdfs --data-binary @examples/blueprints/hdfs.json
curl --user admin:admin -H 'X-Requested-By:admin' -X POST localhost:8080/api/v1/clusters/dev --data-binary @examples/hostgroups/hdfs.json
