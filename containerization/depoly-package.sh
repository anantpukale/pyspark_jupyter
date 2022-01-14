
source config/config.sh

#kubectl create -f 'config/01-namespace.yaml'

cd helm

helm repo add --username=$REPO_USER  --password=$REPO_PWD $CHART_REPO_NAME $CHART_REPO

helm install $CHART_REPO_NAME service-intelligence/service-intelligence --version $chartVersion --namespace gladiators  -f aiops/values.yaml

helm repo add apache-airflow https://airflow.apache.org

helm install airflow apache-airflow/airflow --namespace prod -f airflow/values.yaml
