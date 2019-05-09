#!/bin/bash -xe

mkdir repository
cd repository || exit
gsutil cp gs://yeebase-helm-charts/index.yaml .
cp index.yaml "$HOME/.helm/repository/local/index.yaml"
for dir in $(git diff --name-only HEAD~1 HEAD ../*/ | awk -F'/' 'NF!=1{print $1}' | sort -u);do
	helm dep update "../$dir"
	helm dep build "../$dir"
	helm package "../$dir"
done
helm repo index --url gs://yeebase-helm-charts --merge ./index.yaml .
gsutil -m rsync . gs://yeebase-helm-charts
cd ..
ls -lh repository
rm repository -rf
