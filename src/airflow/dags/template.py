# importing libraries

## general libraries
from datetime import datetime, timedelta

## airflow libraries
from airflow.decorators import dag
from airflow.operators.dummy import DummyOperator


# declaring dag
default_args = {
	"owner": "Kattson Bastos",
	"retries": 1,
	"retries_delay": 0
}

@dag(
    dag_id="template_dag",
    start_date=datetime(2023,4,1),
    max_active_runs=1,
    scheduler_interval=timedelta(hours=24),
    default_args=default_args,
    catchup=false,
    tags=['template']
)
def load_data():
	init = DummyOperator(task_id="init")


dag = tempalte_dag()