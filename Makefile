REPOSITORY = poc-terraform-localstack-s3

localstack:
	docker run --rm -it -d -p 4566:4566 -p 4571:4571 --name localstack_s3 -e SERVICES=s3 localstack/localstack:0.12.16

make_bucket:
	$(eval CONTAINER_IP := `docker inspect --format '{{ .NetworkSettings.IPAddress }}' localstack_s3`)
	docker run --rm -it --env-file=.env-file amazon/aws-cli:2.1.29 s3 mb s3://test --endpoint-url="http://$(CONTAINER_IP):4566"

list_bucket:
	$(eval CONTAINER_IP := `docker inspect --format '{{ .NetworkSettings.IPAddress }}' localstack_s3`)
	docker run --rm -it --env-file=.env-file amazon/aws-cli:2.1.29 s3 ls --endpoint-url="http://$(CONTAINER_IP):4566"

build_docker_image:
	docker build -t local/$(REPOSITORY)-terraform .

fmt:
	docker run --rm -it -v $(PWD):/terraform -w /terraform hashicorp/terraform:1.0.4 fmt --recursive

plan: build_docker_image
	$(eval CONTAINER_IP := `docker inspect --format '{{ .NetworkSettings.IPAddress }}' localstack_s3`)
	docker run --rm -it --env-file=.env-file -e S3_ENDPOINT="http://$(CONTAINER_IP):4566" -e TF_VAR_s3_endpoint="http://$(CONTAINER_IP):4566" -v $(PWD):/terraform local/$(REPOSITORY)-terraform plan

apply: build_docker_image
	$(eval CONTAINER_IP := `docker inspect --format '{{ .NetworkSettings.IPAddress }}' localstack_s3`)
	docker run --rm -it --env-file=.env-file -e S3_ENDPOINT="http://$(CONTAINER_IP):4566" -e TF_VAR_s3_endpoint="http://$(CONTAINER_IP):4566" -v $(PWD):/terraform local/$(REPOSITORY)-terraform apply -auto-approve

clean:
	docker rm -f localstack_s3
