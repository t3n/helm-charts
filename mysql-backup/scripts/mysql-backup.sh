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
# MYSQLDUMPPATH=
# GSUTILPATH=
#
# Change this if you want temporary file to be created in specific path
# TMP_PATH=

DATESTAMP=$(date +"_%Y-%m-%d")
DAY=$(date +"%d")
DAYOFWEEK=$(date +"%A")

if [ "$DAY" = "01" ]; then
	PERIOD=month
elif [ "$DAYOFWEEK" = "Sunday" ]; then
	PERIOD=week
else
	PERIOD=day
fi

printf "Selected period: %s\\n" "$PERIOD"
gcloud auth activate-service-account --key-file=/etc/gcloud/key.json
printf "\\nStarting backing up the database to a file...\\n"
"${MYSQLDUMPPATH}mysqldump" --quick --no-tablespaces --default-character-set="${DB_CHARSET}" --host="${DB_HOST}" --user="${DB_USER}" --password="${DB_PASS}" "${DB_NAME}" > "${TMP_PATH}${FILENAME}${DATESTAMP}.sql"
printf "Done backing up the database to a file.\\n\\nStarting compression...\\n"
gzip "${TMP_PATH}${FILENAME}${DATESTAMP}.sql"
printf "Done compressing the backup file.\\n\\nRemoving old backup (2 %ss ago)...\\n" "$PERIOD"
"${GSUTILPATH}gsutil" rm -R "gs://${GSBUCKET}/${GSPATH}previous_${PERIOD}/" || true
printf "Old backup removed.\\n\\nMoving the backup from past %s to another folder...\\n" "$PERIOD"
"${GSUTILPATH}gsutil" mv "gs://${GSBUCKET}/${GSPATH}${PERIOD}/" "gs://${GSBUCKET}/${GSPATH}previous_${PERIOD}" || true
printf "Past backup moved.\\n\\nUploading the new backup...\\n"
"${GSUTILPATH}gsutil" cp "${TMP_PATH}${FILENAME}${DATESTAMP}.sql.gz" "gs://${GSBUCKET}/${GSPATH}${PERIOD}/"
printf "New backup uploaded.\\n\\nAll done."
