# t3n Helm Charts

[![license: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

>A chart repository for the Kubernetes package manager Helm.

## Project Status

This project is still under active development, so you might run into [issues](https://github.com/t3n/helm-charts/issues). If you do, please don't be shy about letting us know, or better yet, contribute a fix or feature.
We will also add more charts over time, so keep an eye on this repository.

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Background

This repository contains charts to deploy Neos & Flow Applications for Kubernetes Helm. Charts are curated application definitions for Kubernetes Helm. For more information about installing and using Helm, see its
[README.md](https://github.com/kubernetes/helm/tree/master/README.md). To get a quick introduction to charts see this [chart guide](https://helm.sh/docs/topics/charts/).

## Install

To add the t3n charts for your local client, run `helm repo add`:
```
$ helm repo add t3n https://storage.googleapis.com/t3n-helm-charts
"t3n" has been added to your repositories
```

## Usage

You can then run `helm search repo t3n` to see available charts. To install a chart just run `helm install t3n/<chart>`.

For more information on using Helm, refer to the [Helm's documentation](https://helm.sh/docs/).

## Contributing

PRs accepted. Pipeline is using Helm v3.

Small note: If editing the Readme, please conform to the [standard-readme](https://github.com/RichardLitt/standard-readme) specification.

## License

[MIT](LICENSE)
