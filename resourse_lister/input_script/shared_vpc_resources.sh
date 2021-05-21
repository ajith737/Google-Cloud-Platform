echo "ProjectId,ProjectName,ResourceID,ResourceType"
#get each projectId
for PROJECT in $ (\
        gcloud projects list \
        --format="value(projectId)"
do
        PROJECTNAME=$(gcloud projects list --format="csv[no-heading](name)" --filter="projectId=${PROJECT}") #get projectName
        gcloud compute shared-vpc list-associated-resources ${PROJECT} --format="csv[no-heading](RESOURCE_ID,RESOURCE_TYPE)" > ./temp/shared_vpc.txt  #get shared-vpc details and store temp folder.

        cat /temp/shared_vpc.txt | while read LINE
        do
                echo "${PROJECT},${PROJECTNAME},${LINE}" #print projectId, project name and shared vpc details from temp folder.
        done
done

