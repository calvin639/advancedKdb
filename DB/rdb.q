\l schema.q
\l Qframework.q
.log.info"Finished importing libraries";
.log.info"Connecting to BASE process"
.alias.add[`BASE;51001];
.connections.add[`BASE];
//Get handles from BASE process
.connections.get_base_handles[];

ints:first `$(.Q.opt .z.x)`instance;
.rt.tbls:tbls:`$(.Q.opt .z.x)`tables;
.rt.hdb:first `$(.Q.opt .z.x)`hdb;
.log.info"This RDB is for tables :",raze string each .rt.tbls;
if[ints=`2; aggtbl:([sym:`$()]max_price:`float$(); min_price:`float$(); trade_vol:`long$(); avg_size:`float$(); last_price:`float$())];
.log.info"Subscribing to TP tables";
.rt.subscribe[`TP; svc; ] each .rt.tbls;
.log.info"Finished Subscribing to TP tables";

.cron.log:{[t]
    //Send a report of the number of messages we have send to the RT for each table
    .log.info "Update for the ",(string t),"  table";
    if[t in `aggtbl`quote;:select from t];
    if[t=`trade;:select by sym from t];
    };

//Replay today's log
.tp.handle:first exec handle from .connections.handles where svc=`TP;
.log.file:.tp.handle".log.file";
.log.info raze"Replaying log file :: ",string .log.file;
-11!.log.file;
.log.info"Completed log replay";

//Set EoD process
.rdb.eod:{
    .log.info"End of Day!";
    hdb:hsym .rt.hdb;
    .log.info"Writing partition : ",string hdb;
    .Q.dpft[hdb;.z.d-1;`sym;]each .rt.tbls; 
    .log.info"Finished writing partition; Now deleting from tables";
    {delete from x}each .rt.tbls;
    .log.info"Data deleted from RDB : ",string svc;
    };


.log.info"Setting timere";
//Set timer
.cron.tbl:([id:enlist 1i]frequency:enlist 60000; func:enlist `.cron.log; last_update:enlist .z.t);
.z.ts:{[tbls]
    runs: exec func from .cron.tbl where .z.t>(last_update+frequency);
    update last_update:.z.t from `.cron.tbl where .z.t>(last_update+frequency);
    {x each tbls} each runs
    };

\t 100
