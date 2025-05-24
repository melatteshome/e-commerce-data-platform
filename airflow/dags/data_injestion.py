# from airflow import DAG
# from datetime import datetime
# from airflow.operators.bash import BashOperator
# from airflow.utils.dates import days_ago

# default_args = {
#     'owner': 'melat',
#     'start_date': days_ago(1),
#     'retries': 1,
# }

# with DAG(
#     dag_id='data_injestion',
#     default_args=default_args,
#     schedule_interval='@daily',  
#     catchup=False,
#     description ='injestes our data into the database'
#     start_date= datetime()
# ) as dag:


