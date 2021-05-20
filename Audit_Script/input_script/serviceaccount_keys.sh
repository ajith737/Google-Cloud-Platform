echo "ProjectId,Key,Created_Time,Expire_Time"
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)"
do
	for ACCOUNT in $ (\
		gcloud iam service-accounts list \
		--project=${PROJECT}
		--format="value(email)")
	do
		gcloud iam service-accounts keys list --iam-account=${ACCOUNT} --project=${PROJECT} --format="csv[no-heading](KEY_ID,CREATED_AT,EXPIRES_AT)" --quiet > ./temp/serviceaccount_keys.txt
		
		cat ./temp/serviceaccount_keys.txt | while read LINE
		do
			echo "$PROJECT},${LINE}"
		done
	done
done
