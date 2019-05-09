#!/bin/bash -xe

mkdir repository
cd repository || exit
gsutil cp gs://t3n-helm-charts/index.yaml .
cp index.yaml "$HOME/.helm/repository/local/index.yaml"
for dir in $(git diff --name-only HEAD~1 HEAD ../*/ | awk -F'/' 'NF!=1{print $1}' | sort -u);do
	helm dep update "../$dir"
	helm dep build "../$dir"
	helm package "../$dir"
done
helm repo index --url https://storage.googleapis.com/t3n-helm-charts --merge ./index.yaml .
gsutil -m rsync . gs://t3n-helm-charts
cd ..
ls -lh repository
rm repository -rf
