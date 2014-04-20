-module(genserver).
-behavior(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

-record(state,{}).

start_link() ->
	gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init([]) ->
	{ok, #state{}}.

handle_call(Request, _From, State) ->
	case Request of
		get_all ->
			{reply, State, State};
		pop ->
			[Val|NewState] = State,
			{reply,Val, NewState};
		_Else ->
			{reply, {return, Request}, State}
	end.

handle_cast(Request, State) ->
	case Request of
		{push, Val} ->
			NewState = [Val|State]	
			{noreply, State}. %state ใหม่
		_Else -> 
			{noreply, State}
	end.

handle_info(_Info, State) ->
	{noreply, State}.

terminate(_Reason, _State) ->
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.
