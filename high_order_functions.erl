-module(high_order_functions).
-export([print_integers/1, filter_integers/2, filter_even/1, concatenate/1, sum/1]).

% Exercises 9-1

% print out integers between 1 and N
% high_order_functions:print_integers(10).
print_integers(N) ->
	lists:map(fun(Int) -> io:format("~p~n", [Int]) end, lists:seq(1, N)).

% given a list of integers and integer, will return all integers smaller than or equal to that integer
% high_order_functions:filter_integers([1,2,3,4,5,6,7,8], 3).
filter_integers(List, N) ->
	lists:filter(fun(Int) -> Int =< N end, List).

% print out the even integers
% high_order_functions:filter_even([1,2,3,4,5,6,7,8]).
filter_even(List) ->
	Evens = lists:filter(fun(Int) -> Int rem 2 == 0 end, List),
	lists:map(fun(Int) -> io:format("~p~n", [Int]) end, Evens).

% give a list of lists and concatenate them
% high_order_functions:concatenate([[1,2,3], [4,4], [5]]).
concatenate(List) ->
	lists:foldl(fun(El, Acc) -> Acc ++ El end, [], List).

% give a list of integers and return sum of them
% high_order_functions:sum([1,2,3,4,5]).
sum(List) ->
	lists:foldl(fun(El, Acc) -> El + Acc end, 0, List).


