echo "ProjectId,ProjectName,SubscriptionName,topic,ackDeadlineSeconds,deadLetterPolicy,deadLetterPolicy.deadLetterTopic,deadLetterPolicy.maxDeliveryAttempts,expirationPolicy,messageRetentionDuration,pushConfig.pushEndpoint"                                                                                                                                                   
# get each projectId
for PROJECT in $(\                                                                                                                                                                                                                         
        gcloud projects list \                                                                                                                                                                                                             
        --format="value(projectId)")                                                                                                                                                                                                       
do                                                                                                                                                                                                                                         
        PROJECTNAME=$(gcloud projects list --format="csv[no-heading](name)" --filter="projectId=${PROJECT}")      #get project name                                                                                                                        
        gcloud pubsub subscriptions list --project=${PROJECT} --format="csv[no-heading](name,topic,ackDeadlineSeconds,deadLetterPolicy,deadLetterPolicy.deadLetterTopic,deadLetterPolicy.maxDeliveryAttempts,expirationPolicy,messageRetentionDuration,pushConfig.pushEndpoint)" --quiet > ./temp/pubsub.txt       #get pubsub details in csv format and store in temp file                                                                                                                                                                                                  
        cat ./temp/pubsub.txt | while read LINE                                                                                                                                                                                   
        do                                                                                                                                                                                                                                 
                echo "${PROJECT},${PROJECTNAME},${LINE}"     #print projectId, projectname and pub sub details that was stored in temp folder                                                                                                                                                                              
        done                                                                                                                                                                                                                               
done

