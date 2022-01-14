FROM docker.io/jupyter/pyspark-notebook:spark-3.1.2

USER root

RUN apt-get update && apt-get install -y libgtk2.0-dev && \
    rm -rf /var/lib/apt/lists/*

RUN /opt/conda/bin/conda update -n base -c defaults conda && \
    /opt/conda/bin/conda install python=3.8.3 && \
    /opt/conda/bin/conda install anaconda-client

RUN conda install -c conda-forge fbprophet && \
    conda install -c conda-forge kats==0.1.0 && \
    conda install -c conda-forge tslearn==0.5.2

ADD requirement.txt /root
RUN pip install -r /root/requirement.txt

RUN conda install nbclassic==0.3.2

