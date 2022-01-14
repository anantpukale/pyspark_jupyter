import setuptools
import sys

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

#version=sys.argv[3]
#sys.argv.remove(version)
version=1.0

setuptools.setup(
    name="aiops-ml-core",
    version=version,
    author="CloudForte-AIOps",
    author_email="CloudForte-AIOps",
    description="Python package for CloudForte-AIOps",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="",
    project_urls={
        "Bug Tracker": "",
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    package_dir={"": "aiops-ml-core"},
    packages=setuptools.find_packages(where="aiops-ml-core"),
    python_requires=">=3.6"
    #install_requires = ['numpy', 'pandas','pyspark','adal','sklearn','fbprophet']
)
