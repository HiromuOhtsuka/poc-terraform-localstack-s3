FROM hashicorp/terraform:1.0.4

COPY entrypoint.sh /entrypoint.sh

WORKDIR /terraform

ENTRYPOINT [ "/entrypoint.sh" ]
