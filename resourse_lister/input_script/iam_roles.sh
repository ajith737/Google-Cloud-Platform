echo "ProjectId,IAM_Member,IAM_Role"
#get each projectId
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)"
do
	gcloud projects get-iam-policy ${PROJECT} --flatten="bindings[].members[]" --format="csv[no-heading](bindings.members,bindings.role)" --quiet > ./temp/iam_role.txt  #get iam policy details and store in temp folder
	
	cat ./temp/iam_role.txt | while read LINE
	do
		echo "${PROJECT},${LINE}" #print projectId and iam-policy
	done
done
