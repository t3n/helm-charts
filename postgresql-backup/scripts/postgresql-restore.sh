#!/bin/sh -e

# The following variables must be set.
# DB_HOST=localhost
# DB_USER=root
# DB_PASS=password
# DB_NAME='--all-databases'
# GSBUCKET=bucketname
# FILENAME=filename
#
# The following line prefixes the backups with the defined directory. it must be blank or end with a /
# GSPATH=
#
# Change this if command is not in $PATH
# postgresqlPATH=
# GSUTILPATH=
#
# Change this if you want temporary file to be created in specific path
# TMP_PATH=

gcloud auth activate-service-account --key-file=/etc/gcloud/key.json
printf "\\nGetting latest Backup..."
"${GSUTILPATH}gsutil" cp "gs://${GSBUCKET}/${GSPATH}day/${FILENAME}_*.db.gz" "${TMP_PATH}${FILENAME}.db.gz"
printf "\\nUncompressing the SQL-Dump..."
gunzip "${TMP_PATH}${FILENAME}.db.gz"
printf "\\nImporting the SQL-Dump"
"${PGRESTOREPATH}pg_restore" -c -d postgresql://${DB_USER}:${DB_PASS}@${DB_HOST}/${DB_NAME} ${TMP_PATH}${FILENAME}.db
if [ ! -z "$SANITIZE_ENABLED" ]; then
	printf "\\nExecuting sanitize SQL-Commands"
	"${PGRESTOREPATH}pg_restore" -c -d postgresql://${DB_USER}:${DB_PASS}@${DB_HOST}/${DB_NAME} "/tmp/sanitize.sql"
	printf "\\nFinished executing Sanitize"
else
	printf "\\nSanitize is disabled"
fi
