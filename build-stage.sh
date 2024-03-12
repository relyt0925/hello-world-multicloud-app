#!/usr/bin/env bash
dnf install git  -y
curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
ibmcloud login --apikey "${IAM_APIKEY}" -r us-south -c 837bf8218846470cad3ecf8bf7dcc43b
git clone https://github.com/relyt0925/hello-world-multicloud-app.git
cd hello-world-multicloud-app
GIT_HEAD_COMMIT=$(git rev-parse HEAD)
make dockerbuild
