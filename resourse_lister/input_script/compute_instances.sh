echo "ProjectId,ComputeInstanceName,Zone,MachineType,Preemptible,InternalIP,ExternalIP,Status"
#get each projectId
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)")
do
	gcloud compute instances list --project=${PROJECT} --format="csv[no-heading](NAME,ZONE,MACHINE_TYPE,PREEMPTIBLE,INTERNAL_IP,EXTERNAL_IP,STATUS)" > ./temp/compute_instances.txt #get the compute instance details in csv format and save in the temp directory for later use.
	
	cat ./temp/compute_instances.txt | while read LINE
	do
		echo "${PROJECT},${LINE}" #print projectId and compute instance details stored in temp directory.
	done
done
