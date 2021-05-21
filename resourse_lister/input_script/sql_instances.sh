echo "ProjectId,ProjectName,SQL_InstanceName,DatabaseVersion,Location,Tier,PrimaryAddress,PrivateAddress,Status"
#get projectId
for PROJECT in $(\
        gcloud projects list \
        --format="value(projectId)")
do
        PROJECTNAME=$(gcloud projects list --format="csv[no-heading](name)" --filter="projectId=${PROJECT}") #get project name
        gcloud sql instances list --project=${PROJECT} --format="csv[no-heading](NAME,DATABASE_VERSION,LOCATION,TIER,PRIMARY_ADDRESS,PRIVATE_ADDRESS,STATUS)" --quiet > ./temp/sql_instances.txt   #get sql_instances details and store in temp folder

        cat ./temp/sql_instances.txt | while read LINE
        do
                echo "${PROJECT},${PROJECTNAME},${LINE}" #print projectId, project name and shared-vpc from temp folder
        done
done

