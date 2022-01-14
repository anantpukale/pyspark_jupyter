#FROM ustr-harbor-1.na.uis.unisys.com/service-intelligence/aiops-pyspark:3.1.2
FROM ustr-harbor-1.na.uis.unisys.com/service-intelligence/aiops-pyspark:3.1.2
RUN echo $SPARK_HOME

USER root
ENV home "/root"

#RUN apt-get install -y python3-pip

#RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
#RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda
#ENV PATH=$PATH:/miniconda/condabin:/miniconda/bin

#RUN conda install python=3.8.3 
RUN conda install -c conda-forge fbprophet && \
    conda install -c conda-forge kats==0.1.0 && \
    conda install -c conda-forge tslearn==0.5.2

RUN python -c "from fbprophet import Prophet"
#RUN conda install pandas=1.2.5
#RUN ls /usr/bin
ADD requirement.txt ${home}
RUN python3 -m pip install --upgrade pip && \
    pip install -r ${home}/requirement.txt

#RUN whereis python

#ADD test.py /root/
#RUN python /root/test.py

