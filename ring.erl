-module(ring).
-export([start/3,stop/1,loop/1]).

% Exercise 4-2
% The process ring

start(M, N, Message) ->
	% Create nodes
	NodesPids = nodes_creator(1, none, N),
	% Connect the ring. Link first node with last node
	[FirstNode|_] = NodesPids,
	LastNode = lists:last(NodesPids),
	FirstNode ! {change_next_pid, self(), LastNode},
	receive
		{ok} -> 
			error_logger:info_msg("Next pid changed to ~p on process ~p~n", [LastNode, FirstNode])
	end,
	% Send first message
	FirstNode ! {self(), 1, M*N+1, Message},
	NodesPids.

stop([]) -> done;
stop([H|T]) ->
	H ! terminate,
	stop(T).

nodes_creator(Id, _, N) when Id > N -> [];
nodes_creator(Id, NextPid, N) ->
	Pid = spawn(?MODULE, loop, [NextPid]),
	error_logger:info_msg("Spawned process ~p(~p); Next pid ~p...~n", [Pid, Id, NextPid]),
	[Pid] ++ nodes_creator(Id+1, Pid, N).

loop(NextPid) ->
	receive 
		{change_next_pid, From, NewNextPid} ->
    		error_logger:info_msg("Changing next pid to ~p from process ~p~n", [NewNextPid, self()]),
			From ! {ok},
			loop(NewNextPid);
		{_From, MaxCount, MaxCount, _Message} -> false;
		{From, Count, MaxCount, Message} ->
            error_logger:info_msg("Message '~p' received. [Count ~p][MyPid ~p][From ~p][Sending to ~p]~n", [Message, Count, self(), From, NextPid]),
			NextPid ! {self(), Count+1, MaxCount, Message},
			loop(NextPid);
		terminate -> true
	end.