-module(echo).
-export([start/0, print/1, loop/0, stop/0]).

% Exercise 4-1
% An echo server

start() ->
	register(echo, spawn(echo, loop, [])).	

loop() -> 
	receive
		{From, Msg} ->
			From ! {self(), Msg}, 
			loop();
		stop ->
			true 
	end.

print(Term) ->
	echo ! {self(), Term},
	receive 
		{_From, Msg} ->
			io:format("Rebut ~p~n", [Msg])
	end.


stop() ->
	echo ! stop.

