//EoD process
\l Qframework.q
.log.info"Finished importing libraries";
.log.info"Connecting to BASE process"
.alias.add[`BASE;51001];
.connections.add[`BASE];
//Get handles from BASE process
.connections.get_base_handles[];

//
.connections.exec[;".rdb.eod[]"]each `RDB_1`RDB_2;
