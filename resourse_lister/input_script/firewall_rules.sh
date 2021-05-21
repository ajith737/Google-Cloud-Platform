echo "ProjectId,ProjectName,FirewallRuleName,Network,direction,Priority,Allow,Deny,Disabled"
#  get each projectId
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)")
do
	PROJECTNAME=$(gcloud projects list --format="csv[no-heading](name)" --filter="projectId=${PROJECT}") #get Project name
	gcloud compute firewall-rules list --project=${PROJECT} --format="csv[no-heading](NAME,NETWORK,DIRECTION,PRIORITY,ALLOW,DENY,DISABLED)" > ./temp/firewall_rules.txt  #gets the firewall_rule details in csv format and store in temp folder.
	
	cat ./temp/firewall_rules.txt | while read LINE
	do
		echo "${PROJECT},${PROJECTNAME},${LINE}"  #prints projectId, projectName, and firewall_rules stored in temp folder.
	done
done
