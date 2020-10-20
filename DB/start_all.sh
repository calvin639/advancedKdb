#!/bin/bash

#Source variable folder
source vars.sh

./start_base.sh 2>&1 | tee $LOG_PATH/BASE_$DATE.log &
./start_tp.sh 2>&1 | tee $LOG_PATH/TP_$DATE.log &
sleep 1
./start_rdb1.sh 2>&1 | tee $LOG_PATH/RDB_1_$DATE.log &
sleep 1
./start_cep.sh 2>&1 | tee $LOG_PATH/CEP_$DATE.log &
sleep 1
./start_rdb2.sh 2>&1 | tee $LOG_PATH/RDB_2_$DATE.log &
