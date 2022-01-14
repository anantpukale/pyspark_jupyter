#FROM ustr-harbor-1.na.uis.unisys.com/service-intelligence/aiops-pyspark:3.1.2
FROM ustr-harbor-1.na.uis.unisys.com/service-intelligence/base-aiops-pyspark:3.1.2.v1
RUN echo $SPARK_HOME

RUN useradd -ms /bin/bash aiops
USER aiops
ENV home "/home/aiops"
ENV PYTHONPATH="$PYTHONPATH:${SPARK_HOME}/python"
ENV PATH="/usr/local/spark/bin:${PATH}:${home}/.local/bin"

COPY jars/target/aiops-kubeflow-UC1-1.0-jar-with-dependencies.jar $SPARK_HOME/jars/

USER root
COPY dist/aiops_ml_core-1.0-py3-none-any.whl ${home}/

RUN python3 -m pip install --upgrade pip && \
    pip install ${home}/aiops_ml_core-1.0-py3-none-any.whl

RUN python3 -c "import nltk;nltk.download('punkt')" && \
    python3 -c "import nltk;nltk.download('wordnet')" && \
    python3 -c "import nltk;nltk.download('stopwords')"

RUN pip install pandas==1.3.4

ADD dockerfiles/requirement.txt /root/
RUN pip install -r /root/requirement.txt

#ENV AZURE_TENANT_ID="8d894c2b-238f-490b-8dd1-d93898c5bf83"
#ENV AZURE_CLIENT_ID="854600d3-f5d9-45d7-9ff2-17d851f2831a"
#ENV AZURE_CLIENT_SECRET="DY5vxs5PCrhE4fi~pHLpQtLQVv-SmhhNx4"

RUN rm -rf ${home}/aiops_ml_core-2.0-py3-none-any.whl
