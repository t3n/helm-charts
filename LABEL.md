## Migrate to new labels without downtime

1. Delete deployment with `--cascade=false`
2. Delete the corresponding replicaset with `--cascade=false` too
3. Add label to orphaned pods to match the new service selector
4. Deploy the Helm Chart
5. Wait for the newly created pods to get ready
6. Delete orphaned pods using old selector labels


## Example
```bash
kubectl delete deploy -l release=[RELEASE],app=[NAME] --cascade=false
```
```bash
kubectl delete rs -l release=[RELEASE],app=[NAME] --cascade=false
```
```bash
kubectl label pods -l release=[RELEASE],app=[NAME] \
  app.kubernetes.io/instance=[RELEASE] \
  app.kubernetes.io/name=[NAME]
```
```bash
kubectl delete pods -l release=[RELEASE],app=[NAME]
```
