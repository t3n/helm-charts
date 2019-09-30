#!/bin/bash -xe

for dir in $(git diff --name-only HEAD~1 HEAD ./*/ | awk -F'/' 'NF!=1{print $1}' | sort -u);do
	echo "$dir"
	helm dep update "$dir"
	helm lint "$dir"
done
