#!/bin/bash
echo "Running ValidateService..."

sudo systemctl restart httpd.service

curl -f http://localhost || exit 1
