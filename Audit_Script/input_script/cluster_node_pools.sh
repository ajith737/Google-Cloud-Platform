echo "ProjectId,ClusterName,NodePoolName,MachineType,diskSize,NodeVerision"
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)")
do
	for CLUSTER in $(\
		gcloud container clusters list \
		--project=${PROJECT}
		--format="value(name)")
	do
		PLACE=$(gcloud container clusters list --project=$(PROJECT} --filter="name=${CLUSTER}" --format="csv[no-heading](LOCATION)")
		gcloud container node-pools list --project=${PROJECT} --zone=${PLACE} --cluster=${CLUSTER} --format="csv[no-heading](NAME,MACHINE_TYPE,DISK_SIZE_GB,NODE_VERSION)" --quiet > ./temp/cluster_node_pools.txt
		cat ./temp/cluster_node_pools.txt | while read LINE
		do
			echo "${PROJECT},${CLUSTER},${LINE}"
		done
	done
done
