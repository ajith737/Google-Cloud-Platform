echo "ProjectId,ClusterName,NodePoolName,MachineType,diskSize,NodeVerision"
#get each projectId
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)")
do
	#get each cluster name in a project.
	for CLUSTER in $(\
		gcloud container clusters list \
		--project=${PROJECT}
		--format="value(name)")
	do
		PLACE=$(gcloud container clusters list --project=$(PROJECT} --filter="name=${CLUSTER}" --format="csv[no-heading](LOCATION)") #get location
		gcloud container node-pools list --project=${PROJECT} --zone=${PLACE} --cluster=${CLUSTER} --format="csv[no-heading](NAME,MACHINE_TYPE,DISK_SIZE_GB,NODE_VERSION)" --quiet > ./temp/cluster_node_pools.txt #list cluster node details in csv format and save in temp folder for later use.
		cat ./temp/cluster_node_pools.txt | while read LINE
		do
			echo "${PROJECT},${CLUSTER},${LINE}"  #print projectId,ClusterName, and Cluster details above fetched.
		done
	done
done
