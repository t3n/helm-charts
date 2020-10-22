#!/bin/bash -xe

mkdir repository
cd repository || exit
gsutil -n cp gs://t3n-helm-charts/index.yaml .
cp index.yaml "$HOME/.cache/helm/repository/t3n-index.yaml"
for dir in $(git diff --name-only HEAD~1 HEAD ../*/ | awk -F'/' 'NF!=1{print $1}' | sort -u);do
	helm dep update "../$dir"
	helm dep build "../$dir"
	helm package "../$dir"
done
helm repo index --url https://storage.googleapis.com/t3n-helm-charts --merge ./index.yaml .
gsutil -m rsync -x 'index.yaml' . gs://t3n-helm-charts
gsutil -h "Cache-Control:private, max-age=0, no-transform" cp index.yaml gs://t3n-helm-charts/index.yaml
cd ..
ls -lh repository
rm repository -rf
