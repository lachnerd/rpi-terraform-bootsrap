#!/bin/bash
start=`date +%s`
echo "========================================="
echo "terraform - INIT - START"
echo "========================================="
echo
mkdir ./output
export TF_LOG=WARN
export TF_LOG_PATH="./output/terraform.log"
terraform init
echo "========================================="
echo "terraform - INIT - FINSIH"
echo "========================================="

echo "========================================="
echo "terraform - APPLY - START"
echo "========================================="
echo
terraform apply
echo "========================================="
echo "terraform - APPLY - FINSIH"
echo "========================================="
end=`date +%s`
runtime=$((end-start))
echo "Laufzeit ${runtime} s"