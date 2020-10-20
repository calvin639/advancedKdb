\l schema.q
\l Qframework.q
\l cron.q
.log.info"Finished importing libraries";

//Set tp variables
.tp.count:tables[]!(count tables[])#0;
port:system"p";
aggtbl:([sym:`$()]max_price:`float$(); min_price:`float$(); trade_vol:`long$(); avg_size:`float$(); last_price:`float$());
tbls:tables[];
.pub.tbl:([]topic:`$(); client:`$());
.pub.upd:{[vals] 
    `.pub.tbl upsert vals;
    .log.info "New subscription successful";
    };

//Initialize ticker plant log file
.log.setLogFile:{
	.log.info"Setting log file path";
	.log.path:(.Q.opt .z.x)`logfile;
	.log.file:hsym `$raze .log.path ,"/TP_", (string .z.d),".log";
	.log.info"Opening handle to log file";
	if[0h = type key .log.file; .log.file set ()];
	.log.handle:hopen .log.file;
	.log.info"Successfully connected to log file";
	};
.log.setLogFile[];

//Connect to BASE
.log.info"Connecting to BASE process";
.alias.add[`BASE;51001];
.alias.add[`TP;port];
tp:.alias.get_alias[`TP];

//EOD 
.u.d:.z.d;
.tp.eod:{
	.log.info"Sending EOD message to RDBs";
 	rdbs:exec handle from .connections.handles where svc like "RDB*";
	{@[x;(`.rdb.eod;::)]}each rdbs;
	.log.info"Cutting a new log file for : ",string .z.d;
	//Send new data to new tplog file
	.log.setLogFile[];
	.log.info"EOD complete. It's a brand new day!";
	};

.connections.add[`BASE];
.log.info"TP set up complete";
