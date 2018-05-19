#!/bin/bash

BUCKET=$1
FILE=$2
FILE_JSON=$3

if [ -z "$BUCKET" ]; then
	echo "ERROR: No bucket specified"; exit 1
fi

if [ -z "$FILE" ]; then
	echo "ERROR: Input file was not specified"; exit 1
fi

if [ -z "$FILE_JSON" ]; then
	echo "ERROR: Json corresponding to input file was not specified"; exit 1
fi


echo "bucket:   ""$BUCKET"
echo "file:   ""$FILE"
echo "file_json:   ""$FILE_JSON"
echo "------------"
echo "file_filename:   ""$FILE_FILENAME"
echo "file_json_filename:   ""$FILE_JSON_FILENAME"


FILE_JSON_FILENAME=$(basename -- "$FILE_JSON")
FILE_FILENAME=$(basename -- "$FILE")

python /usr/local/bin/flatten-nested-json.py "$FILE_JSON" > /tmp/"$FILE_JSON_FILENAME"


aws s3api put-object --bucket "$BUCKET" --key "$FILE_FILENAME" --body "$FILE"
aws s3api put-object --bucket "$BUCKET" --key "$FILE_JSON_FILENAME" --body /tmp/"$FILE_JSON_FILENAME"

