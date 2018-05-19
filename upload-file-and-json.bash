#!/bin/bash

BUCKET=$1
FILE=$2
FILE_JSON=$3

if [ -z "$FILE" ]; then
	echo "ERROR: Input file was not specified"; exit 1
fi

if [ -z "$FILE_JSON" ]; then
	echo "ERROR: Json corresponding to input file was not specified"; exit 1
fi

FILE_JSON_FILENAME=$(basename -- "$FILE_JSON")
FILE_FILENAME=$(basename -- "$FILE")

python /usr/local/bin/flatten-nested-json.py "$FILE_JSON" > /tmp/"$FILE_JSON_FILENAME"


aws s3api put-object --bucket "$BUCKET" --key "$FILE_FILENAME" --body "$FILE"
aws s3api put-object --bucket "$BUCKET" --key "$FILE_JSON_FILENAME" --body /tmp/"$FILE_JSON_FILENAME"

