echo "ProjectId,IAM_Member,IAM_Role"
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)"
do
	gcloud projects get-iam-policy ${PROJECT} --flatten="bindings[].members[]" --format="csv[no-heading](bindings.members,bindings.role)" --quiet > ./temp/iam_role.txt
	
	cat ./temp/iam_role.txt | while read LINE
	do
		echo "${PROJECT},${LINE}"
	done
done
