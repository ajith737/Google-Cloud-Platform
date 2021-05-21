echo "ProjectId,ServiceName,ServiceTitle"
#get each projectId
for PROJECT in $ (\
	gcloud projects list \
	--format="value(projectId)"
do
	gcloud services list --project=${PROJECT} --format="csv[no-heading](NAME,TITLE)" --enabled > ./temp/services_list.txt #get enabled services details and store in temp folder in csv format
	
	cat /temp/services_list.txt | while read LINE
	do
		echo "${PROJECT},${LINE}" #print projectId and services details stored in temp folder.
	done
done
