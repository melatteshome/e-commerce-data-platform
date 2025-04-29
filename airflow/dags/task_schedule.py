from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.email import EmailOperator
from datetime import datetime

default_args = {
    'start_date': datetime(2024, 1, 1),
    'retries': 1,
}

with DAG(
    dag_id='ecommerce_dbt_pipeline',
    schedule_interval='0 6 * * *',  # Run every day at 6AM
    default_args=default_args,
    catchup=False,
    tags=['ecommerce', 'dbt'],
) as dag:

    # Step 1: Load Raw Data (Imagine this happens upstream already)

    # Step 2: Run dbt models
    run_dbt_models = BashOperator(
        task_id='run_dbt_models',
        bash_command='cd /path/to/dbt_project && dbt run'
    )

    # Step 3: Run specific dbt model (optional)
    run_sales_model = BashOperator(
        task_id='run_sales_model',
        bash_command='cd /path/to/dbt_project && dbt run --select daily_sales'
    )

    # Step 4: Notify success
    notify_success = BashOperator(
        task_id='notify_success',
        bash_command='echo "DBT Models Ran Successfully!"'
    )

    # Set task dependencies
    run_dbt_models >> run_sales_model >> notify_success
