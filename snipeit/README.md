# Snipe-IT

[Snipeit-IT](http://www.snipeitapp.com) is free open source IT asset/license management system

## Generate config.snipeit.key

In order for Snipe-IT to work correctly you need to set the yaml-key config.snipeit.key in the values.yaml.
This must be a Base64 Encoded key, which you have to set *before deploying* this Chart.
```
$ docker run -i -t snipe/snipe-it php artisan key:generate --show
```
Then set the generated key from the output with *--set config.snipeit.key* when you're deploying.
## TL;DR;
```
$ helm repo add t3n https://storage.googleapis.com/t3n-helm-charts
$ helm install t3n/snipeit --set config.snipeit.key="base64:....."
```

## Introduction

This chart bootstraps a [Snipe-IT](https://github.com/snipe/snipe-it)
deployment on a [Kubernetes](http://kubernetes.io) cluster using the
[Helm](https://helm.sh) package manager.

## Installing the Chart

To install the chart with the release name `my-release`:

```
$ helm install --name my-release t3n/snipeit --set config.snipeit.key="base64:....."
```

The command deploys Snipe-IT on the Kubernetes cluster in the default
configuration. The [configuration](#configuration) section lists the parameters
that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and
deletes the release.

## Configuration

The following table lists the configurable parameters of the Snipe-IT chart
and their default values.

| Parameter                            | Description                                           | Default                        |
|--------------------------------------|-------------------------------------------------------|--------------------------------|
| `config.mysql.externalDatabase.user` | Username of external MySQL Database User              | `snipeit`                      |
| `config.mysql.externalDatabase.pass` | Password of external MySQL Database User              | `""`                           |
| `config.mysql.externalDatabase.name` | Name of external MySQL Database                       | `db-snipeit`                   |
| `config.mysql.externalDatabase.host` | Hostname/IP of external MySQL Database                | `mysql`                        |
| `config.mysql.externalDatabase.port` | Port of external MySQL Database                       | `3306`                         |
| `config.snipeit.env`                 | Snipe-IT Environment to use                           | `production`                   |
| `config.snipeit.debug`               | Whether to enable Debug mode or not                   | `false`                        |
| `config.snipeit.url`                 | URL of Snipe-IT                                       | `http://snipeit.example.local` |
| `config.snipeit.key`                 | Application-Key for Snipe-IT                          | `""`                           |
| `config.snipeit.timezone`            | Snipe-IT Timezone                                     | `Europe/Berlin`                |
| `config.snipeit.locale`              | Snipe-IT Locale                                       | `en`                           |
| `config.snipeit.envConfig`           | Configure Environment Values                          | `{}`                           |
| `deploymentAnnotations`              | Annotations for Deployment                            | `{}`                           |
| `image.repository`                   | Image Repository                                      | `snipe/snipe-it`               |
| `image.tag`                          | Image Tag                                             | `4.6.16`                       |
| `image.pullPolicy`                   | Image Pull Policy                                     | `IfNotPresent`                 |
| `ingress.enabled`                    | Whether or not to enable Ingress                      | `true`                         |
| `ingress.className`                  | Ingress Class Name                                    | `""`                           |
| `ingress.annotations`                | Custom Ingress Annotations                            | `{}`                           |
| `ingress.path`                       | Root Path for the Ingress Ressource                   | `/`                            |
| `ingress.hosts`                      | URL where Snipe-IT will be accessed                   | `example.local`                |
| `ingress.tls`                        | Configuration for SecretName and TLS-Hosts            | `[]`                           |
| `mysql.enabled`                      | Whether or not to deploy a MySQL Deployment           | `true`                         |
| `mysql.mysqlUser`                    | MySQL User to create                                  | `snipeit`                      |
| `mysql.mysqlPassword`                | MySQL Password for the User                           | `""`                           |
| `mysql.mysqlDatabase`                | Name of MySQL Database to create                      | `db-snipeit`                   |
| `mysql.persistence.enabled`          | Whether or not to enable Persistence                  | `true`                         |
| `mysql.persistence.storageClass`     | StorageClass for MySQL Deployment persistence         | `""`                           |
| `mysql.persistence.accessMode`       | Access Mode of PV                                     | `ReadWriteOnce`                |
| `mysql.persistence.size`             | Size of the PV                                        | `8Gi`                          |
| `persistence.enabled`                | Whether or not Snipe-IT Data should be persisted      | `true`                         |
| `persistence.annotations`            | Annotations for the PVC                               | `{}`                           |
| `persistence.size`                   | Size of the persistent Snipe-IT Volume                | `2Gi`                          |
| `replicaCount`                       | Number of Snipe-IT Pods to run                        | `1`                            |
| `deploymentStrategy`                 | Deployment strategy	                                 | `{ "type": "RollingUpdate" }`  |
| `revisionHistoryLimit`               | The number of old Replicas to keep to allow rollback. | `0`                            |
| `service.type`                       | Type of service to create                             | `ClusterIP`                    |
| `service.annotations`                 | Annotations of service to create                      | `{}`                           |
| `service.clusterIP`                  | Internal cluster service IP                           | `nil`                          |
| `service.loadBalancerIP`             | IP address to assign to load balancer (if supported)  | `nil`                          |
| `service.loadBalancerSourceRanges`   | list of IP CIDRs allowed access to lb (if supported)  | `[]`                           |
| `service.externalIPs`                | service external IP addresses                         | `[]`                           |
| `resources`                          | CPU/Memory resource requests/limits                   | `{}`                           |
| `nodeSelector`                       | Node labels for pod assignment                        | `{}`                           |
| `tolerations`                        | Toleration labels for pod assignment                  | `[]`                           |
| `affinity`                           | Affinity settings for pod assignment                  | `{}`                           |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```
$ helm install --name my-release \
  --set service.type=LoadBalancer \
    t3n/snipeit
```

The above command sets the service type LoadBalancer.

Alternatively, a YAML file that specifies the values for the above parameters
can be provided while installing the chart. For example,

```
$ helm install --name my-release -f values.yaml t3n/snipeit
```

> **Tip**: You can use the default [values.yaml](values.yaml)

### Persistence

The Snipe-IT image stores persistence under `/var/lib/snipeit` path of the
container. A dynamically managed Persistent Volume Claim is used to keep the
data across deployments, by default. This is known to work in GCE, AWS, and
minikube.
Alternatively, a previously configured Persistent Volume Claim can be used.


#### Existing PersistentVolumeClaim

1. Create the PersistentVolume
1. Create the PersistentVolumeClaim
1. Install the chart

```bash
$ helm install --name my-release \
    --set persistence.existingClaim=PVC_NAME \
    t3n/snipeit
```

### Custom Environment Values

Snipe-IT uses `.env` file to store configuration variables. This includes 
Email configuration, advanced configurations like proxy, login throttling etc.
To override the default values for these variables, use the `config.snipeit.envConfig`.

```yaml
config:
  snipeit:
    envConfig:
      MAIL_HOST: smtp.example.com
      MAIL_PORT: 25
      MAIL_USERNAME: username
      MAIL_PASSWORD: password
      MAIL_FROM_ADDR: snipeit@example.com
      MAIL_FROM_NAME: Snipe-IT
```
