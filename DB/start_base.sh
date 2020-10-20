#!/bin/bash

#This process is the bas process that keeps details on others for connections
#Get vars
source vars.sh

q Qframework.q -instance 1 \
	-p $Qport \
	-svc BASE \
	-c 2001 2001 \
	-q \
	#2>&1 | tee $LOG_PATH/BASE_$DATE.log
