#!/bin/bash

dnf install python3.11-pip -y
pip3.11 install boto3 botocore
ansible-pull -i localhost, https://github.com/chowdary709/infra-ansible main.yml -e role_name=${role_name}




