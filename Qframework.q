//This is the process that will set up connections between other processes.

init_block:{[]
    //Find your SVC
    svc::first `$(.Q.opt .z.x)`svc;
    .alias.dict:()!();
    .alias.add:{[alias;port].alias.dict[alias]:port};
    .alias.get_alias:{[k] :first .alias.dict[k];};

    .log.info:{0N! raze (string .z.t), "   LOG INFO :: " ,string x};
    .log.error:{0N! raze (string .z.t), "   LOG ERROR :: " ,string x};

    .rt.force_subscribe:{[client; me; topic] 
        client_port: .alias.get_alias[client];
        h:$[client in .connections.handles[`svc]; first exec handle from .connections.handles where svc=client; .connections.add[client] ];
        @[h;(`.rt.subscribe;me;client;topic)];
        };

    .connections.handles:([]svc:`$(); port:`long$(); handle:`int$());
    .connections.add:{[SVC]
        port: .alias.get_alias[SVC];
        h:hopen port; 
        data:(SVC; port; h);
        `.connections.handles upsert data;
        :h;
        };
    .connections.exec:{[svc;cmd]
	h:first exec handle from .connections.handles where svc=svc;
	t:h cmd;
	.log.info"completed command on connection : ",string svc;
	:t;
	};
    .connections.get_base_handles:{
	cmd:"select svc,port from .connections.handles";
	handleTbl:.connections.exec[`BASE;cmd];
	handleTbl:delete from handleTbl where svc in exec svc from .connections.handles;
	handleTbl:update handle:hopen each port from handleTbl;
	`.connections.handles upsert handleTbl;
	};

    //TickerPlant
    .tp.send:{[SVC; topic; data]
        //if[not (meta topic)~meta data; .log.error "Wrong data types in data : "(string topic),"  ",string client; :0];
        h:$[SVC in .connections.handles[`svc]; first exec handle from .connections.handles where svc=SVC; .connections.add[SVC] ];
        tbl_available: topic in h"tables[]";
        if[not tbl_available; .log.error "Subscriber (",(string client),") does not have appropriate tbl : ",string topic; :0];
        h(`.rt.update; topic; data);
        };
    
    .tp.upd:{[topic; data]
        topic upsert data;
        .log.handle@enlist(`.rt.update; topic; data);
        .tp.count[topic]+:count data;
        };


    //Initialize ticker plant log file
    .log.path:(.Q.opt .z.x)[`logfile];
    .log.file:hsym `$(raze .log.path ,"/TP_", (string .z.d),".log");
    //.log.handle:hopen .log.file;
    //if[0h = type key .log.handle; .log.file set ()];

    .pub.tbl:([]topic:`$(); client:`$());
    .pub.upd:{[vals]
        `.pub.tbl upsert vals;
        .log.info "New subscription successful";
        };
    
    .z.po:{
	port:@[x;(system;"p")];
	svc:x"svc";
	data:(svc;port;x);
	`.connections.handles upsert data;
	.log.info "Added connection from SVC : ",string svc;
	};

    .z.pc:{ 
        clients:exec distinct svc from .connections.handles where handle=x;
        delete from `.connections.handles where handle = x;
        delete from `.pub.tbl where client in clients;
        .log.info "Removed client from pub tbl : ",raze string clients; 
        };

    //RDB
    .rt.subscribe:{[SVC; me; tbl]
        h:$[SVC in .connections.handles[`svc]; first exec handle from .connections.handles where svc=SVC; .connections.add[SVC] ];
        h(`.pub.upd; (tbl; me));
        };
    
    .rt.update:{[topic; data] 
        if[not topic in tables[]; :0]; 
        topic upsert data;
        };

    0N! "init_block complete";
    };

init_block[];
.log.info"This process is a : ",string svc;
