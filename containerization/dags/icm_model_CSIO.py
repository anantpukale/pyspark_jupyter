from airflow import DAG
from datetime import datetime, timedelta
from airflow.contrib.operators.kubernetes_pod_operator import KubernetesPodOperator
from airflow.operators.dummy_operator import DummyOperator
from airflow.kubernetes.volume import Volume
from airflow.kubernetes.volume_mount import VolumeMount
from kubernetes.client import models as k8s
import pytz
IST = pytz.timezone('Asia/Kolkata')

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2021, 12, 29),
    'email': ['airflow@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 0,
    'retry_delay': timedelta(minutes=5)
}

dag = DAG('ICM_Model_CSIO', default_args=default_args, schedule_interval=timedelta(hours=48),catchup=False)


last = DummyOperator(task_id='run_this_last', dag=dag)
namespace='airflow'
passing = KubernetesPodOperator(namespace=namespace,
                          image="ustr-harbor-1.na.uis.unisys.com/service-intelligence/jupyter-pyspark:3.1.2.v31",
                          cmds=["sh","-c", "ipython /home/jovyan/work/DAGS_Airflow/Modeling.ipynb"],
                          labels={"notebook-name": "jupyter"},
                          service_account_name="spark-sa",
                          name="ICM_Modeling_CSIO",
                          env_vars={'CUSTOMER': 'CSIO', 'SCOPE':'uat', 'NameSpace': namespace},
                          image_pull_policy='Always',
                          image_pull_secrets="service-intel-harbor",
                          volumes=[k8s.V1Volume( name='spark-data', persistent_volume_claim=k8s.V1PersistentVolumeClaimVolumeSource(claim_name='aiops-spark-pvc'))],
               		  volume_mounts=[ k8s.V1VolumeMount(mount_path='/home/jovyan/work', name='spark-data', sub_path=None, read_only=False)],
                          task_id="aiops-icm-modeling-CSIO",
                          get_logs=True,
                          dag=dag
                          )

passing >> last
#passing.set_upstream(start):x

