## mjayson/rpi-k8s

This [Drone](https://drone.io/) plugin allows you to use `kubectl` for connecting to any cluster you want.

## Usage
For **drone ci/cd**
```
    image: 'mjayson/rpi-k8s:latest'
    environment:
      TOKEN:
        from_secret: token
      APISERVER:
        from_secret: apiserver
    commands:
      - kubectl config set-credentials admin --token=$${TOKEN}
      - kubectl config set-cluster microk8s-cluster --server=$${APISERVER} --insecure-skip-tls-verify=true
      - kubectl config set-context microk8s --cluster=microk8s-cluster --user=admin
      - kubectl config use-context microk8s
      - kubectl config view
      - kubectl get all --all-namespaces
```
just make sure to add **token** and **apiserver** to your **secrets**

## How to get the credentials
On your k8s cluster 

get the cluster you need
```
export CLUSTER_NAME="microk8s-cluster"
```

form there get the **APISERVER**
```
APISERVER=$(kubectl config view -o jsonpath="{.clusters[?(@.name==\"$CLUSTER_NAME\")].cluster.server}")
```

and the **TOKEN**
```
TOKEN=$(kubectl get secrets -o jsonpath="{.items[?(@.metadata.annotations['kubernetes\.io/service-account\.name']=='default')].data.token}"|base64 --decode)
```

### Special thanks

Inspired by [inlead/drone-kubectl](https://github.com/sinlead/drone-kubectl).
