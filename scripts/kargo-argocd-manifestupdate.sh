#!/bin/bash
set -e

for stage in $(kargo get stages --project kargo-demo -o jsonpath='{.items[*].metadata.name}')
do
	kargo get stage ${stage} -p kargo-demo -o json | jq ".spec.promotionTemplate.argoCDAppUpdates[0] += {\"appName\": \"guestbook-simple-${stage}\"}" | kargo apply -f -
done
