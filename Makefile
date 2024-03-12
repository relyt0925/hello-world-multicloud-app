.PHONY: dockerbuild
dockerbuild:
	@podman login us.icr.io --username "iamapikey" --password-stdin <<< "${IAM_APIKEY}"
	podman build -t us.icr.io/tylerlisnamespace/hello-world-multicloud-app:${GIT_HEAD_COMMIT} .
	podman push --sign-by lisowski@us.ibm.com us.icr.io/tylerlisnamespace/hello-world-multicloud-app:${GIT_HEAD_COMMIT}

