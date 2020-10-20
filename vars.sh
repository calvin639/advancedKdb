#!/bin/bash

HOME_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE_DIR=$(echo "$DIRECTORY" | cut -d "/" -f2)
export DATA_DIR="$HOME_DIR/DB"
export HDB_DIR="$DATA_DIR/HDB"

export tpsvc=TP
export rdb1=RDB1
export rdb2=RDB2
export cep=CEP

#Set ports, choose port where next 5 are also available fro Qport
export Qport=51001
export tp_port=$(($Qport+1))
export rdb1_port=$(($Qport+2))
export rdb2_port=$(($Qport+3))
export cep_port=$(($Qport+4))
export ibm_port=$(($Qport+5))
export csv_port=$(($Qport+6))

export DATE=`date +\%Y-\%m-\%dT\%H.\%M.\%S.\%N`
export LOG_PATH="$HOME_DIR/logging/"`date +%Y-%m-%d`
mkdir -p $LOG_PATH

export logfile="$HOME_DIR/logging/txn"
#mkdir -p $logfile 

