-module(broadcast).

-export([server/1, client/1]).

%Server = spawn(broadcast, server, [[]]).
%Client1 = spawn(broadcast, client, [Server]).
%Client2 = spawn(broadcast, client, [Server]).
%Client3 = spawn(broadcast, client, [Server]).

client(Server) ->
	receive
		{connected, ServerPID} ->
			client(ServerPID);
		{notify, Message} ->
			io:format("P id:~p ,Receive Message : ~s~n", [self(),Message]),
			client(Server);
		{broadcast, Message} ->
			Server ! { message, Message},
			client(Server)
	end.
server(Clients) ->
	receive
		{connect, Client} ->
			NewClients = [Client| Clients],
			Client ! {connected, self()},
			server(NewClients);
		{message, Message} ->
			lists:foreach(
				fun(Client) ->
					Client ! {notify, Message}
				end,
				Clients
				),
				server(Clients)
	end.
