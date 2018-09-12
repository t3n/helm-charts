#!/bin/sh -e

mkdir repository
cd repository
	gsutil cp gs://yeebase-helm-charts/index.yaml .
	cp index.yaml "$HOME/.helm/repository/local/index.yaml"
	for dir in ../*/
	do
		case $dir in
			../repository/)
				true
			;;
			*)
				helm dep build "$dir"
				helm package "$dir"
			;;
		esac
	done
	helm repo index --url https://storage.googleapis.com/yeebase-helm-charts --merge ./index.yaml .
	gsutil -m rsync . gs://yeebase-helm-charts
cd .. || exit
ls -lh repository
rm repository -rf
