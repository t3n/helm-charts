# t3n Helm Charts

This repository contains Charts to deploy Neos & Flow Applications for Kubernetes Helm. Charts are curated application definitions for Kubernetes Helm. For more information about installing and using Helm, see its
[README.md](https://github.com/kubernetes/helm/tree/master/README.md). To get a quick introduction to Charts see this [chart document](https://github.com/kubernetes/helm/blob/master/docs/charts.md).

## How do I enable the t3n repository?

To add the t3n charts for your local client, run `helm repo add`:

```
$ helm repo add t3n https://storage.googleapis.com/t3n-helm-charts
"t3n" has been added to your repositories
```

You can then run `helm search t3n` to see the charts.

## How do I install these charts?

Just run `helm install t3n/<chart>`.

For more information on using Helm, refer to the [Helm's documentation](https://github.com/kubernetes/helm#docs).

## Supported Kubernetes Versions

This chart repository supports the latest and previous minor versions of Kubernetes. For example, if the latest minor release of Kubernetes is 1.8 then 1.7 and 1.8 are supported. Charts may still work on previous versions of Kubernetes even though they are outside the target supported window.

To provide that support the API versions of objects should be those that work for both the latest minor release and the previous one.

## Status of the Project

This project is still under active development, so you might run into [issues](https://github.com/yeebase/helm-charts/issues). If you do, please don't be shy about letting us know, or better yet, contribute a fix or feature.
We will also add more charts over time, so keep an eye on this repository.
