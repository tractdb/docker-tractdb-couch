#!/bin/bash

# Apply our secrets and put local.ini in the correct location
python3 tmp/applysecrets.py

# Launch our server, making it the process to ensure Docker behaves
# http://www.projectatomic.io/docs/docker-image-author-guidance/
exec couchdb
