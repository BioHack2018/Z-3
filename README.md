## projekt Fileharbour - system archiwizacji danych ngs

### Budowanie obrazu docker
```
docker build . -t intelliseq/fileharbour:latest
```

### Konfiguracja i uruchomienie
```
export AWS_ACCESS_KEY_ID=[key];
export AWS_SECRET_ACCESS_KEY=[key];
docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=us-east-1 harbour:latest s3 ls
```

### Upload pliku
```
#upload
docker run -v "$PWD/data/":/tmp/data/ -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=us-east-1 harbour:latest s3api put-object --bucket biohack-bucket --key 1.vcf --body /tmp/data/1.vcf
```

### Wylistowanie wszystkich plików
```
#list-object
docker run -v "$PWD/data/":/tmp/data/ -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=us-east-1 harbour:latest s3api list-objects --bucket biohack-bucket
```

### Pobranie tagów dla pliku
```
#get-object-tagging
docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=us-east-1 harbour:latest s3api get-object-tagging --bucket biohack-bucket --key 1.vcf
```

### Dodanie tagów
```
#put-object-tagging (OVERRIDE)
# a) tag-value purely in command

docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=us-east-1 harbour:latest s3api put-object-tagging --bucket biohack-bucket --key 1.vcf --tagging '{ "TagSet": [{"Key": "test_foo","Value": "foo_1"},{"Key": "test_bar","Value": "bar_1"}]}'

# b) tag-value from file 

echo '{"TagSet": [{"Key": "test_foo","Value": "foo"},{    "Key": "test_bar","Value": "bar"}]}' > tag-example-file-1.json
docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=us-east-1 harbour:latest s3api put-object-tagging --bucket biohack-bucket --key 1.vcf --tagging "$(<tag-example-file-1.json)"
```
### Pobranie URL
```
docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=us-east-1 harbour:latest s3 presign s3://biohack-bucket/tuba3d.bam --expires-in 6000
docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=us-east-1 harbour:latest s3 presign s3://biohack-bucket/tuba3d.bam.bai --expires-in 6000
```

### Upload pliku wraz z json
```
docker run -v "$PWD/data/":/tmp/data/ -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=us-east-1 --entrypoint "/usr/local/bin/upload-file-and-json.bash" harbour:latest biohack-bucket /tmp/data/test_up.txt /tmp/data/test_up.json
```
