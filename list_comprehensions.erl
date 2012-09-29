-module(list_comprehensions).
-export([integers_list_divisible/2, only_integers/1, intersection/2, difference/2]).

% Exercises 9-2

% create a set of integers between 1 and 10 than are divisible by 3
% list_comprehensions:integers_list_divisible(10, 3).
integers_list_divisible(N, Divisible) ->
	[X || X <- lists:seq(1, N), X rem Divisible == 0].

% remove all non integers in a lists
% list_comprehensions:only_integers([1,hello, 100, boo, "boo", 9]).
only_integers(List) ->
	[X || X <- List, is_integer(X)].

% intersection of two 
% list_comprehensions:intersection([1,2,3,4,5], [4,5,6,7,8]).
intersection(List1, List2) ->
	[Y || X <- List1, Y <- List2, X==Y].

% symmetric difference of the two lists
% list_comprehensions:difference([1,2,3,4,5], [4,5,6,7,8]).
difference(List1, List2) ->
	Intersection = intersection(List1, List2),
	(List1 -- Intersection) ++ (List2 -- Intersection).


