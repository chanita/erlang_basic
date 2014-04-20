-module(server).

-export([parent/0, start/0, child/1]).

start() ->
	spawn(?MODULE, parent, []).
parent() ->
	process_flag(trap_exit, true),
	P1 = spawn_link(?MODULE, child, [none]),
	P2 = spawn_link(?MODULE, child, [P1]),
	P3 = spawn_link(?MODULE, child, [P2]),

	receive
		{'EXIT', KILLID, _ } ->
			io:format("~p~n", [KILLID]),
			parent()
	end.

child(none) ->
	receive

	after 5000 ->
		exit("DIE")
	end;

child(Link) ->
	link(Link),
	receive

	after 5000 ->
		exit("DIE")
	end.
