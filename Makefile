.PHONY: dockerbuild
dockerbuild:
	@podman login us.icr.io --username "iamapikey" --password-stdin <<< "${IAM_APIKEY}"
	podman build -t ${FULL_IMAGE_TAG} .
	podman push --sign-by tylerlisowski ${FULL_IMAGE_TAG}

