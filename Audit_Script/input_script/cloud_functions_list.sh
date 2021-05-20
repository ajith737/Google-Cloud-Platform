echo "ProjectId,ProjectName,FunctionName,Status,Trigger,Region"
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)")
do
	PROJECTNAME=$(gcloud projects list --format="csv[no-heading](name)" --filter="projectId=${PROJECT}")
	gcloud fuctions list --project=${PROJECT} --format="csv[no-heading](NAME,STATUS,TRIGGER,REGION)" > ./temp/cloud_functions.txt

	cat ./temp/cloud_functions.txt | while read LINE
	do
		echo "${PROJECT},${PROJECTNAME},${LINE}"
	done
done
