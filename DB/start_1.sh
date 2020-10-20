#!/bin/bash

#Source variable folder
source vars.sh

./start_base.sh 2>&1 | tee $LOG_PATH/BASE_$DATE.log &
./start_tp.sh 2>&1 | tee $LOG_PATH/TP_PRAC.log &
