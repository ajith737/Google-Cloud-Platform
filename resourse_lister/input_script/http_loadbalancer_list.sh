echo "ProjectId,ProjectName,LoadBalancerName,DefaultService"
#get each projectId
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)")
do
	PROJECTNAME=$(gcloud projects list --format="csv[no-heading](name)" --filter="projectId=${PROJECT}") #get project name
	gcloud compute url-maps list --format="csv[no-heading](NAME,DEFAULT_SERVICE)" --project=${PROJECT} > ./temp/http_loadbalancer.txt #get list of http loadbalancer in csv format and store in temp file
	
	cat ./temp/http_loadbalancer.txt | while read LINE
	do
		echo "${PROJECT},${PROJECTNAME},${LINE}" #print projectId,projectName and loadbalancer details stored in temp folder.
	done
done
