projekt Archiwizacja danych

```
docker build . -t harbour:latest
```

```
export AWS_ACCESS_KEY_ID=[key];
export AWS_SECRET_ACCESS_KEY=[key];
docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=us-east-1 harbour:latest s3 ls
```

```
#upload
docker run -v "$PWD/data/":/tmp/data/ -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=us-east-1 harbour:latest s3api put-object --bucket biohack-bucket --key 1.vcf --body /tmp/data/1.vcf
```

```
#list-object
docker run -v "$PWD/data/":/tmp/data/ -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=us-east-1 harbour:latest s3api list-objects --bucket biohack-bucket
```
