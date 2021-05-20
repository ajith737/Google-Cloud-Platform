echo "ProjectId,ProjectName,SubnetName,Region,Network,Range"
for PROJECT in $(\
        gcloud projects list \
        --format="value(projectId)")
do
        PROJECTNAME=$(gcloud projects list --format="csv[no-heading](name)" --filter="projectId=${PROJECT}")
        gcloud compute networks subnets list --project=${PROJECT} --format="csv[no-heading](NAME,REGION,NETWORK,RANGE)" > ./temp/subnet_details.txt

        cat ./temp/subnet_details.txt | while read LINE
        do
                echo "${PROJECT},${PROJECTNAME},${LINE}"
        done
done

