#!/bin/bash
set -euo pipefail

: "${ENV:? ENV musi być ustawiony przed startem skryptu}"
: "${AURORA=false}"
: "${S3=false}"
: "${RABBITMQ=false}"
: "${SECRETMANAGER=false}"

echo "Start deploymentu dla środowiska ${ENV^^}"
echo "Aurora = ${AURORA,,}"
echo "S3 = ${S3,,}"
echo "RabbitMQ = ${RABBITMQ,,}"
echo "SecretManager = ${SECRETMANAGER,,}"

# Deployment functions for each environment
deploy_prod(){
    cd prod/
    do_init
    do_plan
    do_apply
    }

deploy_stage(){
    cd stage/  
    do_init
    do_plan
    do_apply
    }

deploy_dev(){
    cd dev/
    do_init
    do_plan
    do_apply
    }

# Terraform commands
do_init(){
    terraform init
}

do_plan(){
    terraform plan \
    --var "create_bucket=${S3,,}" \
    --var "create_rabbitmq=${RABBITMQ,,}" \
    --var "create_secret_manager=${SECRETMANAGER,,}" \
    --var "create_aurora=${AURORA,,}" -out=plan.tfplan
}

do_apply(){
    terraform apply plan.tfplan -auto-approve
}

# Main script logic
if [[ "${ENV^^}" == "PROD" ]]; then
	deploy_prod
fi
if [[ "${ENV^^}" == "STAGE" ]]; then
	deploy_stage
fi
if [[ "${ENV^^}" == "DEV" ]]; then
	deploy_dev
fi

