#!/bin/bash

#Get vars
source vars.sh

rlwrap q rdb.q -instance 2 \
    -logfile $logfile \
    -p $rdb2_port \
    -svc RDB2 \
    -c 2001 2001 \
    -tables aggtbl \
    -hdb $HDB_DIR \
    -q \
    #2>&1 | tee $LOG_PATH/RDB_2_$DATE.log 
    
