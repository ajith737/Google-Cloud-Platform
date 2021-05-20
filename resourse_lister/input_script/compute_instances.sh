echo "ProjectId,ComputeInstanceName,Zone,MachineType,Preemptible,InternalIP,ExternalIP,Status"
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)")
do
	gcloud compute instances list --project=${PROJECT} --format="csv[no-heading](NAME,ZONE,MACHINE_TYPE,PREEMPTIBLE,INTERNAL_IP,EXTERNAL_IP,STATUS)" > ./temp/compute_instances.txt
	
	cat ./temp/compute_instances.txt | while read LINE
	do
		echp "${PROJECT},${LINE}"
	done
done
