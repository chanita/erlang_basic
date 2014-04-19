-module(test).

-export([ 
	hello/0, hello/1,  
	sum/1,
	count/1,
	sum_tail/2,
	sum2/1,
	average/1,
	command/1,
	double_list/1,
	map/2,
	foldr/2,
	foldr2/3,
	foldl/2,
	process_loop/0
]).

double_list([]) -> [];
double_list([H|T]) -> 
	[H*2 | double_list(T)].

map(_, []) -> [];
map(F, [H|T]) -> [ F(H) | map(F, T)].


foldr(F, [X,Y]) -> F(X,Y);
foldr(F,[H|T]) -> F(H , foldr(F,T)).

foldr2(F, Acc, [Y]) -> F(Y, Acc);
foldr2(F, Acc, [H|T]) -> foldr2( F, F(H,Acc), T ).

foldl(F, [X,Y]) -> F(X,Y);
foldl(F, [H1, H2 |T]) ->
	F(F(H1,H2), foldl(F,T)).

process_loop() ->
	receive
		Message ->
			io:format("~p Receive : ~s~n",[self(), Message]),
			process_loop()
	end.

list_process(List) ->
	receive
		{put, Val} ->
			NewList = [Val | List],
			list_proess(NewList);
	
		print ->
			io:format("~p~n", [List]),
			list_process(List);
		{Caller, pop} ->
			[Val | NewList] = List,
			Caller ! Val,
			list_process(NewList)
	end.

command(Message) ->
	case Message of 
		{average, L } -> average(L);
		{sum, L} -> sum(L)
	end.

hello() -> 
    io:format( "Hello World.~n").

hello(joe) ->
    io:format("Hello Joe.~n");

hello(mike) ->
    io:format("Hello Mike.~n").

sum_tail([], Accumulator) -> Accumulator;
sum_tail([H|T], Accumulator) ->
	sum_tail(T, (Accumulator+H)).

sum2(L) -> sum_tail(L,0).

sum([]) -> 0;
sum([H|T]) -> H+ sum(T).

count([]) -> 0;
count([_H|T]) -> 	
	count(T)+1.
	
	
average(L) ->
	if 
		L =/= [] ->
			sum(L) / count(L);
		L =:= [1] ->
			1;
		true ->
			error
	end. 
	
