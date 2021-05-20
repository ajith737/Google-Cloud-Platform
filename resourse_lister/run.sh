gcloud projects list --format="csv(projectId,name,projectNumber)" > ./output/project_list.csv
chmod +x ./input_Scripts/ > ./temp/files.txt
ls ./temp/files.txt | while read LINE
do
	for WORD in $LINE; do
		WORD1=$(echo ${WORD} | awk '{ print substr( $0, 1, length($0)-3 }`)
		./input_script/${WORD} > ./output/${WORD1}.csv
	done
done
rm ./output.zip
zip -r output.zip ./output
cloudshell download output.zip
