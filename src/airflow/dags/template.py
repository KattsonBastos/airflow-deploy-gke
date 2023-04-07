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
    schedule_interval='0 12 * * 1-5',
    default_args=default_args,
    catchup=False,
    tags=['template']
)
def template_dag():
    init = DummyOperator(task_id="init")

    end = DummyOperator(task_id="end")

    init >> end


dag = template_dag()