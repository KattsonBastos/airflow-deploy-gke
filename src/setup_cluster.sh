
setup_cluster(){
   # set project

  echo "### Creating Cluster.."
  gcloud config set project k-practices

  # gcloud services list --available | grep container
  gcloud services enable container.googleapis.com

  gcloud container clusters create airflow-cluster \
  --machine-type n1-standard-2 \
  --num-nodes 1 \
  --region "us-east1"

  # authenticate kubectl
  echo "### Getting creds kb"
  gcloud container clusters get-credentials airflow-cluster --region "us-east1"

  # create a namespace
  kubectl create namespace airflow

  # deploy airfflow
  helm repo add apache-airflow https://airflow.apache.org

  # list repo
  helm repo list

  # forward port
  # kubectl port-forward svc/airflow-webserver 8080:8080 -n airflow

  echo "### Adding SSH"

  mkdir ~/.ssh

  #mv ./id_rsa.pub ~/.ssh

  kubectl create secret generic airflow-gke-git-secret --from-file=gitSshKey=/home/gitpod/.ssh/id_rsa.pub -n airflow

  # deploy
  echo "### Deploying"
  helm upgrade airflow apache-airflow/airflow -n airflow -f values.yaml --debug --timeout 10m30s

    # create yaml config
    #helm show values apache-airflow/airflow > values.yaml

    # help upgrade
    # helm upgrade --install airflow apache-airflow/airflow -n airflow  \
    #   -f values.yaml \
    #   --debug

    # if error ocurs
    # kubectl create secret generic airflow-postgresql -n airflow --from-literal=password='postgres' --dry-run=client -o yaml | kubectl apply -f -
}


case $1 in
  setup_cluster)
    setup_cluster
    ;;
  *)
    echo "Usage: $0 {setup_cluster}"
    ;;
esac