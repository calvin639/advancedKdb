#!/bin/bash

#Get vars
source vars.sh

rlwrap q cep.q -instance 1 \
    -logfile $logfile \
    -p $cep_port \
    -svc CEP \
    -tables quote trade \
    -q \
    #2>&1 | tee $LOG_PATH/CEP_$DATE.log   
