# lbg-hdp

To run:
```
$ cd lbg-hdp
$ docker-compose -p lbg -f examples/compose/multi-container.yml up
```
Then in another screen:
```
$ ./makeHosts.sh
$ ./run.sh
```

## Running on Kubernetes

Some of the work here has been replicated in the [lbg-aks-terraform](https://github.com/contino/lbg-aks-terraform) repo. The project aims to run Ambari (and other components) on Kubernetes in Azure Kubernetes Service (AKS). Artefacts such as Kubernetes manifests are also compatiable with IBM Cloud Private/ICP, which are in the `manifests/icp` directory.
