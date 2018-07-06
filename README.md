# lbg-hdp

cd lbg-hdp
docker-compose -p lbg -f examples/compose/ranger.yml up
```
Then in another screen:
```
./regDomain.sh
on ipa server: do these manual steps:
#ipa passwd hadoopadmin
#kinit hadoopadmin@LBG.DEV
#ipa passwd cdcsa
#kinit cdcsa@LBG.DEV

./run.sh
```

## Running on Kubernetes

Some of the work here has been replicated in the [lbg-aks-terraform](https://github.com/contino/lbg-aks-terraform) repo. The project aims to run Ambari (and other components) on Kubernetes in Azure Kubernetes Service (AKS). Artefacts such as Kubernetes manifests are also compatiable with IBM Cloud Private/ICP, which are in the `manifests/icp` directory.
