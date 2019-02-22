# OCI FSS - Multi-Read-Write Persistent Volumes
In some use cases, you will need the share storage with MultiReadWrite access to many pods. You can leverage on OCI File Storage Service (FSS) to create the shared storage.

This is reference from [OCI workshop](https://github.com/owainlewis/oci-workshop-for-kubernetes/blob/master/03-storage/FileStorage.md)

## OCI volume provisioner secret
[OCI Volume Provisioner](https://github.com/oracle/oci-volume-provisioner)
Refer to [config.yaml](https://github.com/oracle/oci-cloud-controller-manager/blob/master/manifests/provider-config-example.yaml) for the configuration and execute the following:

```
kubectl create secret generic oci-volume-provisioner \
    -n kube-system \
    --from-file=config.yaml=config.yaml
```

## Install OCI Volume provisioner
Install the driver with the following
```s
kubectl create -f https://raw.githubusercontent.com/oracle/oci-cloud-controller-manager/master/manifests/volume-provisioner/oci-volume-provisioner-rbac.yaml
kubectl create -f https://raw.githubusercontent.com/oracle/oci-cloud-controller-manager/master/manifests/volume-provisioner/oci-volume-provisioner-fss.yaml
```

## Create FSS mount
Create new FSS mount for the cluster. Replace the compartment-id and subnet-id with the one in your cloud account

```bash
oci fs mount-target create --availability-domain=mNVh:PHX-AD-1 \
--compartment-id=ocid1.compartment.oc1..aaaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa \
--subnet-id=ocid1.subnet.oc1.phx.aaaaaaaa3aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa --profile AAAPHX
```

If the FSS is successfully create, json output of the mount is shown like the example:
```json
{
  "data": {
    "availability-domain": "mNVh:PHX-AD-1",
    "compartment-id": "ocid1.compartment.oc1..aaaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    "display-name": "mt-316",
    "export-set-id": "ocid1.exportset.oc1.phx.aaaaaby27ve2pt4hobuhqllqojxwiotqnb4c2ylefuyqaaaa",
    "id": "ocid1.mounttarget.oc1.phx.aaaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    "lifecycle-details": null,
    "lifecycle-state": "CREATING",
    "private-ip-ids": null,
    "subnet-id": "ocid1.subnet.oc1.phx.aaaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    "time-created": "2018-11-30T03:37:52.211000+00:00"
  },
  "etag": "aaaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}
```

## Add the storage class
Update the mntTargetId  in the storageclass.yaml. Add the storage class oci-fss using kubectl

```bash
kubectl create -f storageclass.yaml
```

## Create a PVC
Create a new PVC to test the provision FSS storage
```
kubectl create -f pvc_sample.yaml
```
Check if the PVC is bound
```
kubectl get pvc
```


## Consume the PVC storage in Pod
create a sample pod and bound PVC in the Pod.
```
kubectl create -f pod_sample.yaml
```

This will create 2 nginx pods sharing the PVC. You can go into the shell and check the /usr/share/nginx/html directory.

## OCI Load-Balancer
OCI Load Balance is automatically created when you set the service to LoadBalancer in kuberenetes config.
If you need to change the load-balancer shapes or as private load-balancer, you can add this in the service 
metadata annotations.

```json
apiVersion: v1
kind: Service
metadata:
  name: platform-platform-gateway-private
  namespace: backbase
  annotations:
    service.beta.kubernetes.io/oci-load-balancer-shape: "100Mbps"
    service.beta.kubernetes.io/oci-load-balancer-internal: "true"
    service.beta.kubernetes.io/oci-load-balancer-subnet1: "ocid1.subnet.oc1.phx.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    service.beta.kubernetes.io/oci-load-balancer-subnet2: "ocid1.subnet.oc1.phx.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
spec:
  ports:
  - name: http-private-80
    port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    app: platform-gateway
    release: platform
  type: LoadBalancer
```

Currently, OCI supports the following shapes: 100Mbps, 400Mbps and 8000Mbps. To define the shape:
```json
service.beta.kubernetes.io/oci-load-balancer-shape: "100Mbps"
```

To set the load-balancer as private one,
```json
service.beta.kubernetes.io/oci-load-balancer-internal: "true"
```