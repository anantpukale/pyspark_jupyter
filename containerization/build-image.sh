#/bin/sh

source config/config.sh

echo $REPO_PWD | docker login $REPO --username $REPO_USER --password-stdin

while getopts v: flag
do
    case "${flag}" in
        v) version=${OPTARG};;
    esac
done


rm -rf ../containerization/aiops-ml-core
#rm -rf ../containerization/setup.py
rm -rf ../containerization/jars


#Build depenedant jars through maven
mkdir jars
cp pom.xml jars/
cd jars
mvn install
cd ..

#Build aiops ml wheel package file.
mkdir aiops-ml-core
chmod -R 777 aiops-ml-core
cp -r ../aiops-ml-core ../containerization/
#cp ../setup.py ../containerization/setup.py
cp ../README.md ../containerization/README.md
python3  setup.py bdist_wheel -universal

#Build docker image with above wheel and jar files
IMG="$USER/jupyter-pyspark:$version"
docker build -t ${REPO}/${IMG} -f dockerfiles/jupyter-pyspark.Dockerfile .
docker push ${REPO}/${IMG}

IMG="$USER/aiops-pyspark:$version"
docker build -t ${REPO}/${IMG} -f dockerfiles/aiops-pyspark.Dockerfile .
docker push ${REPO}/${IMG}

#Clean up the space
rm -rf dist/
rm -rf ../containerization/aiops-ml-core
#rm -rf ../containerization/setup.py
rm -rf ../containerization/jars
rm -rf build
rm -rf work


