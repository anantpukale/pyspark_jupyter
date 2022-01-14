
source config/config.sh

echo $REPO_PWD | docker login $REPO --username $REPO_USER --password-stdin 

cd helm

helm repo add --username=$REPO_USER --password=$REPO_PWD \
	$CHART_REPO_NAME $CHART_REPO

helm package aiops -d "aiops"  --app-version $appVersion \
	--version $chartVersion


helm cm-push --username=$REPO_USER --password=$REPO_PWD \
	aiops/$CHART_REPO_NAME-$chartVersion.tgz $CHART_REPO

docker logout $REPO_URL
rm aiops/$CHART_REPO_NAME-$chartVersion.tgz
#helm repo remove $CHART_REPO_NAME
