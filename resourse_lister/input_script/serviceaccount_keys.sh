echo "ProjectId,Key,Created_Time,Expire_Time"
# get each projectId
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)"
do
	#get each service account
	for ACCOUNT in $ (\
		gcloud iam service-accounts list \
		--project=${PROJECT}
		--format="value(email)")
	do
		gcloud iam service-accounts keys list --iam-account=${ACCOUNT} --project=${PROJECT} --format="csv[no-heading](KEY_ID,CREATED_AT,EXPIRES_AT)" --quiet > ./temp/serviceaccount_keys.txt   #get serviceaccount key details and store in temp folder in csv format
		
		cat ./temp/serviceaccount_keys.txt | while read LINE
		do
			echo "$PROJECT},${LINE}" #print projectId and service account keys details which was stored in temp folder.
		done
	done
done
