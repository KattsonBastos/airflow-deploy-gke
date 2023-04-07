# IMPORTING
# airflow
from airflow                  import DAG
from airflow.operators.python import PythonOperator

# general
from datetime import datetime, timedelta


# this function is basically the task
def print_hello():
    print('Hello from GKE!')

# creating the dag. It will be passed later to each task as \
## an argument to the 'dag' parameter
dag = DAG(
    dag_id = 'hello_world',
    description='Hello World DAG',
    schedule_interval=timedelta(seconds=20), # the interval in which the dag will be executed
    start_date=datetime(2023,4,6), # its a timestemp mainly used in the attempt t obackfill
    catchup=False # interval in which the DAG will try to execute again past paused runs
)

# python operator for the above function
hello_operator = PythonOperator(
    task_id='hello_task',
    python_callable=print_hello, # <-- here comes the 'hello' function we created
    dag=dag # <-- that's were the dag object we created comes in
)

# just calling our task
hello_operator