#!/bin/bash

#Source variable folder
source vars.sh

./stop_base.sh
./stop_tp.sh 
./stop_rdb1.sh 
./stop_cep.sh
./stop_rdb2.sh 
