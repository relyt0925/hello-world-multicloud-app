#!/usr/bin/env bash
envsubst  < deployment/deployment.yaml > deployment/tmp-deployment.yaml
mv -f deployment/tmp-deployment.yaml deployment/deployment.yaml
