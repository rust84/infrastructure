# infrastructure
terraform for vmware infrastructure

# build vm template

packer build -var-file='variables.json' .\ubuntu-18.04-amd64.json

# deploy

terraform apply
