Advanced CMPT - Calvin Wright

Exercise 1
For the tp set up I based the logic from my own experince and less so on the kdb tick architecture available online. 

Q Scripts:
1: Qframework - This holds logic that all q sessions use.
2: to - This is tp scecific logic.
3: rdb - RDB scecific logic.
4: schema - Schemas to be loaded in by TP and RDB.
5: cron - Logic for generating data on a timer, plus eod check.
6: eod - Logic to save a hdb partition for each table in the rdb at eod.
7: ibm - Logic for extracting IBM specific data and creating a new tp log file.

Shell Sctipts:
1: There is a start and stop sctipt for each of the mandatory q processes: tp,rdb1/2, cep.
2: There is also a BASE process which holds info on what q processes are running, ports, handles etc. So then new process only need to know about BASE to
find all their connections.
3: All processes can be started using start_all.sh.
4: All processes can be stopped using stop_all.sh.
5: Start up info is held in vars.sh. You can change port ranges, log directort and other details here. 
6: insert_csv.sh - This file can be run after starting up BASE, TP and RDB. It will load in the csv file.
7: make_IBM_log.sh - This can be run to create a new tp log from most recent, extracting only the IBM data. 

Exercise 2 
- Answers in the word doc.
- Also the tables were re created in a directory called advances_errors to get answers.

Exercise 3
1.
I chose a python sctipts as I have previously worked with python before. 
Navigate to the python directory and run the python_kdb_connection notebook. 

2.
I chose Java for this exercise as I had seen some java client set up before but overall had little knowledge and mainly used examples from kdb git. 
Navigate to the JAVA directory and run csvload.java.

3.
Navigate to HTML dir. Run the start_webQ.sh script. It will start 2 q processes, generator and a subscriber. 
Then will jump into the html dir and run a python script to start a web page that runs locally. 
You can then go to the web page on http://localhost:1234

