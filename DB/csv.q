\l Qframework.q
\l schema.q
.log.info"Finished importing libraries";

.log.info"Connecting to BASE process"
.alias.add[`BASE;51001];
.connections.add[`BASE];
//Get handles from BASE process
.connections.get_base_handles[];

//Get file and table name given
file:first `$(.Q.opt .z.x)`file;
tbl:first `$(.Q.opt .z.x)`tbl;
//Meta of the tbl
colType:upper exec t from meta tbl;

//Get the datai
.log.info"Getting data from csv file";
data:(colType;enlist",")0:file;

//Insert data to TP
.log.info"Sending data to tp";
.tp.send[`TP;tbl;data];
.log.info raze"Finished sending data to, (string tbl),". - Rows inserted :: ",string count data;
//
