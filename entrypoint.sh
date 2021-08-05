#!/bin/sh
set -eux

terraform init -backend-config="endpoint=${S3_ENDPOINT}"
terraform $@
