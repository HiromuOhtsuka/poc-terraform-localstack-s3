# poc-terraform-locakstack-s3
## prepare
### .env-file
```sh
$ cat <<EOF > .env-file
AWS_ACCESS_KEY_ID=dummy
AWS_SECRET_ACCESS_KEY=dummy
EOF
```

### make bucket
```sh
$ make localstack
# wait for localstack is up
$ make make_bucket
```

## apply
```sh
$ make apply
```

## plan
```sh
$ make plan
```

## fmt
```sh
$ make fmt
```

## list-bucket
```sh
$ make list_bucket
```

## clean
```sh
$ make clean # localstack container is removed
```
