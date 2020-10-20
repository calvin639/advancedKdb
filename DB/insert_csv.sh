#!/bin/bash

#Get vars
source vars.sh

q csv.q -instance 1 \
    -file $1 \
    -tbl $2 \
    -p $csv_port \
    -svc $csv \
    -c 2001 2001 \

