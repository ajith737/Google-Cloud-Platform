echo "ProjectId,ClusterName,ServiceName,Type,ClusterIP,ExternalIP,Port,Age"
for PROJECT in $(\                                                                                                                                                                                                                         
        gcloud projects list \                                                                                                                                                                                                             
        --format="value(projectId)")                                                                                                                                                                                                       
do
        for CLUSTER in $(\
                gcloud conatiner clusters list \
                --project=${PROJECT} \
                --format="value(name)")
        do
                PLACE=$(gcloud conatiner clusters list --project=${PROJECT} --filter="name=${CLUSTER}" --format="csv[no-heading](LOCATION)")
                gcloud config set ${PROJECT}
                gcloud container clusters get-credentials ${CLUSTER} --zone=${PLACE}
                kubectl get service > ./temp/k_services.txt
                tail -n +2 ./temp/k_services.txt > ./temp/k_services1.txt
                while read line do
                        liner=""
                        for word in $line; do
                                LETTER=${WORD}
                                if grep -q "," <<< ${word};
                                then
                                        LETTER=`"`${WORD}`"`
                                fi
                                if [ ! "$liner" ];
                                then
                                        liner=${LETTER}
                                else
                                        liner+=","${LETTER}
                                fi
                        done
                        echo "$PROJECT},${CLUSTER},${LINER}"
                done < ./temp/k_services1.txt
        done
done

