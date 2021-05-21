echo "ProjectId,ProjectName,SubnetName,Region,Network,Range"
#get projectId
for PROJECT in $(\
        gcloud projects list \
        --format="value(projectId)")
do
        PROJECTNAME=$(gcloud projects list --format="csv[no-heading](name)" --filter="projectId=${PROJECT}")    #get projectname
        gcloud compute networks subnets list --project=${PROJECT} --format="csv[no-heading](NAME,REGION,NETWORK,RANGE)" > ./temp/subnet_details.txt #get subnet details and store in temp folder

        cat ./temp/subnet_details.txt | while read LINE
        do
                echo "${PROJECT},${PROJECTNAME},${LINE}" #print projectId, projectName and subnet details that was stored in temp folder
        done
done

