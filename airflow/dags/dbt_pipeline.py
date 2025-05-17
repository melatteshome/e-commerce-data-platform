from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'melat',
    'start_date': days_ago(1),
    'retries': 1,
}

with DAG(
    dag_id='dbt_postgres_pipeline',
    default_args=default_args,
    schedule_interval='@daily',  
    catchup=False,
) as dag:

    # Run dbt
    dbt_run = BashOperator(
        task_id='run_dbt_models',
        bash_command='cd e-commerce-data-platform/dbt_transformation/ && dbt run',
    )


    dbt_run 
