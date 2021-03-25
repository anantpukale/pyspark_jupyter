# pyspark_jupyter
The above deployment file will deploy an jupyter notebook with pyspark library.
# kubectl appy -f deployment.yaml
Get the ip from exposed jupyter service by executing command 
# kubectl get svc -$NAMESPACE 
port is 8888 for jupyter notebook.
Execute the spark.py code in jupyter notebook to check the spark job being scaled on executors.
