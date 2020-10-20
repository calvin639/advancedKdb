#!/bin/bash

#Get vars
source vars.sh

q ibm.q -instance 1 \
    -logpath $logfile \
    -logfile $1 \
    -p $ibm_port \
    -svc $ibmsvc \
    -c 2001 2001 \
    #-q \

