echo "ProjectId,BucketName"
#get each projectId
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)")
do
	#list all buckets in the project ${PROJECT}
	gsutil ls -p ${PROJECT} > ./temp/buckets_list.txt
	cat ./temp/buckets_list.txt | while read LINE
	do
		echo "${PROJECT},${LINE}" #output projectId along with Bucket list.
	done
done
