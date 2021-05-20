echo "ProjectId,ProjectName,LoadBalancerName,DefaultService"
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)")
do
	PROJECTNAME=$(gcloud projects list --format="csv[no-heading](name)" --filter="projectId=${PROJECT}")
	gcloud compute url-maps list --format="csv[no-heading](NAME,DEFAULT_SERVICE)" --project=${PROJECT} > ./temp/http_loadbalancer.txt
	
	cat ./temp/http_loadbalancer.txt | while read LINE
	do
		echo "${PROJECT},${PROJECTNAME},${LINE}"
	done
done
