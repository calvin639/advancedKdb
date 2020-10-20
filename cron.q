//Fake some data and set up a timer to flush it to clients
.cron.trade:{[]
    data:flip (5#.z.d; 5?.z.t; 5#`APPL`AMZ`BMW`FROG; 5?10.0; 5?100; 5?`NYC`LDN`SING`DUB);
    .tp.upd[`trade; data];
    };

.cron.quote:{[]
    data:flip (5?`APPL`AMZ`BMW`FROG; 5?10.0; 5?100);
    .tp.upd[`quote; data];
    };

.cron.flush:{[]
    //Send trade data to all subscribers
    trade_subs: exec distinct client from .pub.tbl where topic=`trade;
    .tp.send[ ; `trade; select from trade] each trade_subs;
    //Remove data from TP
    delete from `trade;
    //Do the same for quote tbl
    quote_subs: exec distinct client from .pub.tbl where topic=`quote;
    .tp.send[ ; `quote; select from quote] each quote_subs;
    delete from `quote;
    //Same for agg tbl
    agg_subs:exec distinct client from .pub.tbl where topic=`aggtbl;
    .tp.send[;`aggtbl;select from aggtbl]each agg_subs;
    };

.cron.log:{[]
    //Send a report of the number of messages we have send to the RT for each table
    .log.info "Updates for the trade table recieved so far today : ",string .tp.count[`trade];
    .log.info "Updates for the quote table recieved so far today : ",string .tp.count[`quote];
    };
sec:1000;
minute:sec*60;
hour:minute*60;
day:hour*24;
.cron.tbl:([id:1 2 3 4i]frequency: 5000 2000 1000 60000; func:`.cron.trade`.cron.quote`.cron.flush`.cron.log; last_update:4#.z.t);

.cron.ID:1i;
.z.ts:{[]
    runs: exec func from .cron.tbl where .z.t>(last_update+frequency);
    update last_update:.z.t from `.cron.tbl where .z.t>(last_update+frequency);
    {x[]} each runs;
    if[svc=`TP;
	if[.z.d>.u.d; .u.d:.z.d; .tp.eod[]]];
    };

\t 100
    
