echo "ProjectId,ServiceName,ServiceTitle"
for PROJECT in $ (\
	gcloud projects list \
	--format="value(projectId)"
do
	gcloud services list --project=${PROJECT} --format="csv[no-heading](NAME,TITLE)" --enabled > ./temp/services_list.txt
	
	cat /temp/services_list.txt | while read LINE
	do
		echo "${PROJECT},${LINE}"
	done
done
