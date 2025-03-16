#!/bin/bash

# exit when any command fails
set -e

if [ ! -f .env ]; then
  echo "Exiting: Could not find .env file!"
  exit 1
fi

set -a
source .env
set +a

if [ "ENABLE_CORS" = "true" ]; then
  curl -X PUT http://"$COUCHDB_USER":"$COUCHDB_PASS"@localhost:5984/_node/_local/_config/httpd/enable_cors -d '"true"'
  curl -X PUT http://admin:password@localhost:5984/_node/_local/_config/cors/origins -d '"$ALLOWED_ORIGINS"'
fi

echo "Running Fauxton at https://$DOMAIN/_api/_utils/"

echo "All Done!"
