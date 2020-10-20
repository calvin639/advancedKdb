#!/bin/bash
#Get vars
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$THIS_DIR/vars.sh"

echo Will shut down RDB2 SVC

kill -9 `ps -ef | grep -e start_rdb2.sh | awk '{print $2}'`
