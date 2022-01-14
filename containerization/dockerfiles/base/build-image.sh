#/bin/sh

REPO_PWD="1bQwsrHPw3mmxaGLCrwGl2OtsQSKpNjz"
REPO="ustr-harbor-1.na.uis.unisys.com"
#REPO="docker.io"
REPO_USER=robot'$'service-intelligence+si_build
USER="service-intelligence"
#USER="anantpukale"
echo $REPO_PWD | docker login $REPO --username $REPO_USER --password-stdin

while getopts v: flag
do
    case "${flag}" in
        v) version=${OPTARG};;
    esac
done


#IMG="$USER/base-jupyter-pyspark:$version"
#docker build -t ${REPO}/${IMG} -f base-jupyter-pyspark.Dockerfile .
#docker push ${REPO}/${IMG}

IMG="$USER/base-aiops-pyspark:$version"
docker build -t ${REPO}/${IMG} -f base-aiops-pyspark.Dockerfile .
docker push ${REPO}/${IMG}
