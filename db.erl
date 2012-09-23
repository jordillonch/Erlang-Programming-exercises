-module(db).
-compile(export_all).

% Exercise 3-4
% Database handling using lists
%
% db:new() ⇒ Db.
% db:destroy(Db) ⇒ ok.
% db:write(Key, Element, Db) ⇒ NewDb.
% db:delete(Key, Db) ⇒ NewDb.
% db:read(Key, Db) ⇒ {ok, Element} | {error, instance}.
% db:match(Element, Db) ⇒ [Key1, ..., KeyN].

new() ->
	[].

destroy(_) ->
	ok.

write(Key, Element, Db) ->
	Db ++ [{Key, Element}].

delete(Key, Db) ->
	{R, Element} = read(Key, Db),
	if
		R == error -> R;
		R == ok -> Db -- [{Key, Element}]
	end.

search(Key, {Key, Element}, _) -> {ok, Element}; 
search(_, _, []) -> {error, not_found};
search(Key, {_, _}, Db) ->
	[{Key2, Element2}|T] = Db,
	search(Key, {Key2, Element2}, T).

read(Key, Db) ->
	search(Key, {false, false}, Db).

match(_, []) -> [];
match(Element, Db) ->
	[{Key2, Element2}|T] = Db,
	if
		Element == Element2 -> [Key2] ++ match(Element, T);
		true -> match(Element, T)
	end.

