# set project
gcloud config set project k-practices

# gcloud services list --available | grep container
gcloud services enable container.googleapis.com

gcloud container clusters create airflow-cluster \
--machine-type n1-standard-4 \
--num-nodes 1 \
--region "us-east1"

# authenticate kubectl
gcloud container clusters get-credentials airflow-cluster --region "us-east1"

# create a namespace
kubectl create namespace airflow

# deploy airfflow
helm repo add apache-airflow https://airflow.apache.org

# list repo
helm repo list

# forward port
# kubectl port-forward svc/airflow-webserver 8080:8080 -n airflow

# deploy
helm upgrade --install airflow apache-airflow/airflow -n airflow --debug

# create yaml config
helm show values apache-airflow/airflow > values.yaml

# help upgrade
helm upgrade --install airflow apache-airflow/airflow -n airflow  \
  -f values.yaml \
  --debug

# if error ocurs
kubectl create secret generic airflow-postgresql -n airflow --from-literal=password='postgres' --dry-run=client -o yaml | kubectl apply -f -

gcloud components install gke-gcloud-auth-plugin
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
