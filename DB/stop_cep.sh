#!/bin/bash
#Get vars
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$THIS_DIR/vars.sh"

echo Will shut down CEP SVC

kill -9 `ps -ef | grep -e "-svc CEP -tables " | awk '{print $2}'`
