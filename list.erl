-module(list).
-compile(export_all).

% Excercise 3-5
% Filter integers smaller than or equal N
filter([], _) -> [];
filter([H|T], N) ->
	if
		H =< N -> [H] ++ filter(T, N);
		true -> filter(T, N)
	end.

% Other way to do exercise 3-5
filter2_rec(H, [H2|T], N) when H =< N ->
	[H] ++ filter2_rec(H2, T, N);
filter2_rec(H, _, N) when H > N -> [].

filter2([H|T], N) ->
	filter2_rec(H, T, N).

% Reverse a list
reverse([]) -> [];
reverse([H|T]) ->
	reverse(T) ++ [H].

% Concatenate and flatten a list
concatenate([]) -> [];
concatenate(List) when not is_list(List) -> [List];
concatenate(List) when is_list(List) ->
	[H|T] = List,
	concatenate(H) ++ concatenate(T).

% Exercise 3-6
% Quicksort algorithm
quicksort([]) -> [];
quicksort([P|T]) ->
	quicksort_pivot(P, T, left) ++ [P] ++ quicksort_pivot(P, T, right).

quicksort_pivot(_, [], _) -> [];
quicksort_pivot(P, [H|T], Side) ->
	if
		(Side == left) and (H =< P) -> R = [H] ++ quicksort_pivot(P, T, Side);
		(Side == right) and (H > P) -> R = [H] ++ quicksort_pivot(P, T, Side);
		true -> R = quicksort_pivot(P, T, Side)
	end,
	quicksort(R).

