#!/bin/bash

HELM_SCRIPT_PATH=/tmp/get_helm.sh
curl -fsSL -o "$HELM_SCRIPT_PATH" https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 "$HELM_SCRIPT_PATH"
sudo $HELM_SCRIPT_PATH
