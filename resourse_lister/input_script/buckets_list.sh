echo "ProjectId,BucketName"
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)")
do
	gsutil ls -p ${PROJECT} > ./temp/buckets_list.txt
	cat ./temp/buckets_list.txt | while read LINE
	do
		echo "${PROJECT},${LINE}"
	done
done
