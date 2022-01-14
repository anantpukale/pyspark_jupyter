FROM ustr-harbor-1.na.uis.unisys.com/service-intelligence/base-jupyter-pyspark:3.1.2.v1

ENV NB_PREFIX /

RUN echo $SPARK_HOME

ENV PYTHONPATH="$PYTHONPATH:${SPARK_HOME}/python"
ENV PATH="/usr/local/spark/bin:${PATH}"

COPY jars/target/aiops-kubeflow-UC1-1.0-jar-with-dependencies.jar $SPARK_HOME/jars/

#ENV AZURE_TENANT_ID="8d894c2b-238f-490b-8dd1-d93898c5bf83"
#ENV AZURE_CLIENT_ID="854600d3-f5d9-45d7-9ff2-17d851f2831a"
#ENV AZURE_CLIENT_SECRET="DY5vxs5PCrhE4fi~pHLpQtLQVv-SmhhNx4"

ENV home "/home/jovyan"

COPY dist/aiops_ml_core-1.0-py3-none-any.whl ${home}/

RUN  pip install ${home}/aiops_ml_core-1.0-py3-none-any.whl

ADD dockerfiles/requirement.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt

ADD aiops-ml-core work/aiopsmlcore
RUN rm -rf work/*checkpoint.ipynb
RUN rm -rf ${home}/aiops_ml_core-1.0-py3-none-any.whl && \
    rm -rf /home/jovyan/requirement.txt

COPY certs/aiops-mlcluster.cf.unisys-1.com_Oct25-2021.crt /home/jovyan/aiops-mlcluster.cf.unisys-1.com_Oct25-2021.crt
COPY certs/aiops-mlcluster.cf.unisys.com_Oct25-2021.key /home/jovyan/aiops-mlcluster.cf.unisys.com_Oct25-2021.key

RUN apt update && apt install -y  telnet
RUN python -c "import nltk;nltk.download('punkt')" && \
    python -c "import nltk;nltk.download('wordnet')" && \
    python -c "import nltk;nltk.download('stopwords')"  


USER root

CMD ["sh","-c", "jupyter notebook --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=30503 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX} --NotebookApp.allow_password_change=True --certfile=/home/jovyan/aiops-mlcluster.cf.unisys-1.com_Oct25-2021.crt --keyfile /home/jovyan/aiops-mlcluster.cf.unisys.com_Oct25-2021.key "]

