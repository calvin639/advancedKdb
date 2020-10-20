#!/bin/bash

#Get vars
source vars.sh

q tp.q -instance 1 \
    -logfile $logfile \
    -p $tp_port \
    -svc $tpsvc \
    -c 2001 2001 \
    -q \
    #2>&1 | tee $LOG_PATH/TickerPlant_$DATE.log 
