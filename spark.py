#!/usr/bin/env python
# coding: utf-8

# In[16]:


NAMESPACE = "spark1"
DRIVER_HOST = "spark-notebook"
DRIVER_PORT = "29413"
DRIVER_SERVICE_ACCOUNT= "spark-sa"


# In[18]:


import pyspark
from pyspark import SparkContext, SparkConf
from pyspark.sql import SparkSession

conf1 = SparkConf().setAppName('sparktest').setMaster('k8s://https://kubernetes.default.svc.cluster.local:443')
conf1.set("spark.kubernetes.namespace", NAMESPACE)
conf1.set("spark.kubernetes.authenticate.caCertFile","/var/run/secrets/kubernetes.io/serviceaccount/ca.crt")
conf1.set("spark.kubernetes.authenticate.oauthTokenFile","/var/run/secrets/kubernetes.io/serviceaccount/token")
conf1.set("spark.kubernetes.authenticate.driver.serviceAccountName",DRIVER_SERVICE_ACCOUNT)
conf1.set("spark.executor.instances","2")
conf1.set("spark.kubernetes.container.image","docker.io/anantpukale/spark:3.1.1-with-pyspark-hadoop3.2-test2")
conf1.set("spark.driver.host", DRIVER_HOST+"."+NAMESPACE+".svc.cluster.local")
conf1.set("spark.driver.port",DRIVER_PORT)


# In[21]:


sc = SparkContext(conf=conf1)


# In[22]:


spark = SparkSession(sc)      


# In[4]:


data = [1, 2, 3, 4, 5]
distData = sc.parallelize(data)
distData.sum()


# In[6]:


sc.stop()


# In[ ]:





# In[23]:




