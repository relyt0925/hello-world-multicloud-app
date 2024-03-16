#!/usr/bin/env bash
dnf install git make gettext  -y
mknod /dev/fuse c 10 229
chmod 666 /dev/fuse
sed -i "s/^mount_program.*/#mount_program/g" /etc/containers/storage.conf
sed -i "s/^mountopt.*/#mountopt/g" /etc/containers/storage.conf
curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
ibmcloud login --apikey "${IAM_APIKEY}" -r us-south -c 837bf8218846470cad3ecf8bf7dcc43b
ibmcloud plugin install container-service -f
git clone https://github.com/relyt0925/hello-world-multicloud-app.git
cd hello-world-multicloud-app
export GIT_HEAD_COMMIT=$(git rev-parse HEAD)
echo "$SIGNING_PRIV_KEY_64" | base64 -d > /tmp/priv.key
gpg --import /tmp/priv.key
rm -f /tmp/priv.key
export PIPELINE_IMAGE_URL="us.icr.io/tylerlisnamespace/hello-world-multicloud-app:${GIT_HEAD_COMMIT}"
export FULL_IMAGE_TAG="$PIPELINE_IMAGE_URL"
make dockerbuild
envsubst < deployment/deployment.yaml > deployment/templated-deployment.yaml
ibmcloud sat config version create --name "$GIT_HEAD_COMMIT" --config hello-world-multicloud-app --file-format yaml --read-config deployment/templated-deployment.yaml

