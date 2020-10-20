#!/bin/bash

#Get vars
source vars.sh

q rdb.q -instance 1 \
    -logfile $logfile \
    -p $rdb1_port \
    -svc RDB1 \
    -c 2001 2001 \
    -tables quote trade \
    -hdb $HDB_DIR \
    -q \
    #2>&1 | tee $LOG_PATH/RDB_1_$DATE.log 
