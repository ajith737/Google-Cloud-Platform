echo "ProjectId,ProjectName,FirewallRuleName,Network,direction,Priority,Allow,Deny,Disabled"
for PROJECT in $(\
	gcloud projects list \
	--format="value(projectId)")
do
	PROJECTNAME=$(gcloud projects list --format="csv[no-heading](name)" --filter="projectId=${PROJECT}")
	gcloud compute firewall-rules list --project=${PROJECT} --format="csv[no-heading](NAME,NETWORK,DIRECTION,PRIORITY,ALLOW,DENY,DISABLED)" > ./temp/firewall_rules.txt
	
	cat ./temp/firewall_rules.txt | while read LINE
	do
		echo "${PROJECT},${PROJECTNAME},${LINE}"
	done
done
