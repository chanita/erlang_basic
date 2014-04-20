-module(training).

-export([loop/0,
	loop2/0]).

loop() ->
	receive
		%_ ->
		%	die
		{link, PID} ->
			link(PID),
			loop();
		die ->
			exit("DIE")
			%We don't need 'die' here, as we don't loop when we get die
	end.

loop2() ->
	process_flag(trap_exit, true),
	receive
		{link, PID} ->
			link(PID),
			loop();
		die ->
			exit("DIE");
		ExitMessage ->
			io:format("~p~n", [ExitMessage]),
			loop2()
	end.
