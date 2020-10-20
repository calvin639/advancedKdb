#!/bin/bash
#Get vars
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$THIS_DIR/vars.sh"

echo Will shut down TP SVC

kill -9 `ps -ef | grep -e "-svc TP -c 2001 2001" | awk '{print $2}'`
