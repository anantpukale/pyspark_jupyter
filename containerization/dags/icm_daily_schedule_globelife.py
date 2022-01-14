from airflow import DAG
from datetime import datetime, timedelta
from airflow.contrib.operators.kubernetes_pod_operator import KubernetesPodOperator
from airflow.operators.dummy_operator import DummyOperator
from airflow.kubernetes.volume import Volume
from airflow.kubernetes.volume_mount import VolumeMount
from kubernetes.client import models as k8s
import pytz
from nameoffile import utility

IST = pytz.timezone('Asia/Kolkata')

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2021, 12, 27),
    'email': ['airflow@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 0,
    'retry_delay': timedelta(minutes=5)
}

opration='ICM_daily_schedule'
customer = '_regeneron'
name= opartion + customer

dag = DAG(name , default_args=default_args, schedule_interval='0 6 * * *',catchup=False)


last = DummyOperator(task_id='run_this_last', dag=dag)
operator = utility.utility(command_path='', operator_name='', customer='')
operator >> last
#passing.set_upstream(start)
