#list the projects and details in CSV format to output directory
gcloud projects list --format="csv(projectId,name,projectNumber)" > ./output/project_list.csv
#make all scripts in input_script directory executable
chmod +x ./input_Scripts/ > ./temp/files.txt
#read each file in input_script and execute it then, put the script result in output directory in csv format
ls ./temp/files.txt | while read LINE
do
	for WORD in $LINE; do
		WORD1=$(echo ${WORD} | awk '{ print substr( $0, 1, length($0)-3) }')
		./input_script/${WORD} > ./output/${WORD1}.csv
	done
done
rm ./output.zip
#after all results are in output directory. Make output directory to a zip file and autmatically download to our local machine. 
zip -r output.zip ./output
cloudshell download output.zip
