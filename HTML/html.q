\p 5001

//Websocket funcs
.z.ws:{value x};
.z.wc: {delete from `subs where handle=x};


//Must have below schema defined on localhost 5090
//Table definitions
//Just do trade for now
trade:flip `time`sym`price`size!"tsfi"$\:();

upd:insert;

 subs:2!flip `handle`func`params!"is*"$\:();
.z.w: hopen 5090;

//Functions to be called through WebSocket
loadPage:{ getSyms[.z.w]; sub[`getTrades;enlist `]};
filterSyms:{ sub[`getTrades;x]};
getSyms:{ (neg[x]) .j.j `func`result!(`getSyms;distinct trade`sym)};
getTrades:{
  filter:$[all raze null x;distinct trade`sym;raze x];
  res: 0!select last price,last size by sym,last time from trade where sym in filter;
  `func`result!(`getTrades;res)};

//Subscribe to something
sub:{`subs upsert(.z.w;x;enlist y)};

//Publish data according to subs table
pub:{
  row:(0!subs)[x];
  (neg row[`handle]) .j.j (value row[`func])[row[`params]]
  };

//Set timer
.z.ts:{
	data:(.z.t;rand`APPLE`GOOG`AMZ`Kx`FakeyMcFake;rand 10.0;rand 1000);
	`trade upsert data;
	pub each til count subs
	};
\t 1000
