echo "ProjectId,ProjectName,ResourceID,ResourceType"
for PROJECT in $ (\
        gcloud projects list \
        --format="value(projectId)"
do
        PROJECTNAME=$(gcloud projects list --format="csv[no-heading](name)" --filter="projectId=${PROJECT}")
        gcloud compute shared-vpc list-associated-resources ${PROJECT} --format="csv[no-heading](RESOURCE_ID,RESOURCE_TYPE)" > ./temp/shared_vpc.txt

        cat /temp/shared_vpc.txt | while read LINE
        do
                echo "${PROJECT},${PROJECTNAME},${LINE}"
        done
done

