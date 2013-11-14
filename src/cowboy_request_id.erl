-module(cowboy_request_id).

-export([execute/2]).
-export([init/0]).
-export([init/1]).

-export([get/1]).

execute(Req, Env) ->
  Fun = init([]),
  Fun(Req, Env).

init() ->
  init([]).

init(Options) ->
  Header = fast_key:get(header, Options, <<"x-request-id">>),
  Generator = fast_key:get(generator, Options, fun() -> uuid:to_string(uuid:uuid4()) end),
  fun (Req, Env) ->
    {RequestID, Req3} = case cowboy_req:header(Header, Req) of
      {undefined, Req2} ->
        {Generator(), Req2};
      {ID, Req2} ->
        {ID, Req2}
    end,
    Req4 = cowboy_req:set_meta(request_id, RequestID, Req3),
    {ok, Req4, Env}
  end.

get(Req) ->
  {RequestID, _} = cowboy_req:meta(request_id, Req),
  RequestID.
