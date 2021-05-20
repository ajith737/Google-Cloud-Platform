echo "ProjectId,ClusterName,NameSpace,Name,Ready,Status,Restarts,Age"
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
		kubectl get pods --all-namespaces > ./temp/k_pods.txt
		tail -n +2 ./temp/k_pods.txt > ./temp/k_pods1.txt
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
		done < ./temp/k_pods1.txt
	done
done
