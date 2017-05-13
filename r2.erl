-module(r2).
-compile(export_all).

%% map

map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F,T)].

%% map tail end recursive

tmap(F, L) -> lists:reverse(tmap(F, L, [])).

tmap(_, [], Acc) -> Acc;
tmap(F, [H|T], Acc) -> tmap(F, T, [F(H)|Acc]).

%% filter

filter(Pred, L) -> lists:reverse(filter(Pred, L, [])).

filter(_, [], Acc) -> Acc;
filter(Pred, [H|T], Acc) ->
  case Pred(H) of
    true -> filter(Pred, T, [H|Acc]);
    false -> filter(Pred, T, Acc)
  end.


%% reduce / fold

reduce(_,Start,[]) -> Start;
reduce(F,Start,[H|T]) -> reduce(F,F(H,Start),T).
