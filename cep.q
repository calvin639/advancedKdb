\l schema.q
\l Qframework.q
.log.info"Finished importing libraries";
//Add basics
port:system"p";
aggtbl:([sym:`$()]max_price:`float$(); min_price:`float$(); trade_vol:`long$(); avg_size:`float$(); last_price:`float$());
.pub.tbl:([]topic:`$(); client:`$());
tbls:`$(.Q.opt .z.x)`tables;
.log.info"Adding BASE Connection";
.alias.add[`BASE;51001];
.alias.add[`CEP;port];
.connections.add[`BASE];
.connections.get_base_handles[];
.log.info"Finished connecting to BASE process";
//.rt.update:{[topic; data] topic upsert data};
aggtbl:([sym:`$()]max_price:`float$(); min_price:`float$(); trade_vol:`long$(); avg_size:`float$(); last_price:`float$());
.rt.subscribe[`TP; svc; ] each tbls;

//Add the TP as a publish client
.pub.upd[(`aggtbl; `TP)];
//Make the TP subscribe to the agg tbl
0N! "Forcing Sub";
//.rt.force_subscribe[`TP;`CEP;`aggtbl];
0N! "Forced Sub";
.cron.flush:{[]
    agg_subs: exec distinct client from .pub.tbl where topic=`aggtbl;
    .tp.send[ ; `aggtbl; aggtbl] each agg_subs;
    };

.z.ts:{[]
    t:select max_price:max price, min_price:min price, trade_vol:sum size, avg_size:avg size by sym from trade;
    q:select sym,last_price:price from quote;
    tbl:q lj t;
    .rt.update[`aggtbl; tbl];
    .cron.flush[];
    :tbl;
    };
.log.info "Set up finished, strting timer";
\t 5000
