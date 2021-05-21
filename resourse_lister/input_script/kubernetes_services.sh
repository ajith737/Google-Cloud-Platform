echo "ProjectId,ClusterName,ServiceName,Type,ClusterIP,ExternalIP,Port,Age"
#get each projectId
for PROJECT in $(\                                                                                                                                                                                                                         
        gcloud projects list \                                                                                                                                                                                                             
        --format="value(projectId)")                                                                                                                                                                                                       
do
        #get each cluster
        for CLUSTER in $(\
                gcloud conatiner clusters list \
                --project=${PROJECT} \
                --format="value(name)")
        do
                PLACE=$(gcloud conatiner clusters list --project=${PROJECT} --filter="name=${CLUSTER}" --format="csv[no-heading](LOCATION)") #get location
                gcloud config set ${PROJECT}   #set project
                gcloud container clusters get-credentials ${CLUSTER} --zone=${PLACE}  #get credentials 
                kubectl get service > ./temp/k_services.txt    #get service details and store temp folder
                tail -n +2 ./temp/k_services.txt > ./temp/k_services1.txt   #get service details excluding heading
                while read line do
                        liner=""
                        for word in $line; do
                                LETTER=${WORD}
                                if grep -q "," <<< ${word};   #if contains "," add double quotes to the word
                                then
                                        LETTER=`"`${WORD}`"`
                                fi
                                if [ ! "$liner" ];  #append word
                                then
                                        liner=${LETTER}
                                else
                                        liner+=","${LETTER}
                                fi
                        done
                        echo "$PROJECT},${CLUSTER},${LINER}"     #print projectId, project name, and pods details
                done < ./temp/k_services1.txt
        done
done

