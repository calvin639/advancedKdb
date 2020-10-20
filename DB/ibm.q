\l schema.q

//Create a new update function that just takes IBM trades
.rt.update:{[topic;data]
	if[not topic in `trade;:0];
	if[0<count data:data where data[;2]=/:`BMW;.log.handle@enlist(`.rt.update; topic; data)]
	};

//Get log file
.log.path:(.Q.opt .z.x)`logpath;
.log.file:(.Q.opt .z.x)`logfile;
.log.file:hsym `$raze .log.path,"/",.log.file;
//Make a new log file related to IBM
.log.new_file:hsym `$ssr[string .log.file;"TP";"TP_IBM"];
//Open a handle to new file and initiate
.log.new_file set ();
.log.handle:hopen .log.new_file;

//Replay old file and cause a new IBM log file to be created
-11!.log.file;
\\
