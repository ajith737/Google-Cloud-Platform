echo "ProjectId,ProjectName,FunctionName,Status,Trigger,Region"
#get each projectId
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)")
do
	PROJECTNAME=$(gcloud projects list --format="csv[no-heading](name)" --filter="projectId=${PROJECT}") #get project name
	gcloud fuctions list --project=${PROJECT} --format="csv[no-heading](NAME,STATUS,TRIGGER,REGION)" > ./temp/cloud_functions.txt #list functions in csv format and put in  temp folder for later use

	cat ./temp/cloud_functions.txt | while read LINE
	do
		echo "${PROJECT},${PROJECTNAME},${LINE}"  #prints projectId,ProjectName and function details before we fetched.
	done
done
