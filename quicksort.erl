-module(quicksort).
-compile(export_all).

%% quicksort

quicksort([]) -> [];
quicksort([Pivot|Rest]) ->
  {Smaller, Larger} = partition(Pivot,Rest,[],[]),
  quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).

partition(_,[],Smaller,Larger) -> {Smaller,Larger};
partition(Pivot, [H|T], Smaller, Larger) ->
  if H =< Pivot -> partition(Pivot, T, [H|Smaller], Larger);
     H > Pivot  -> partition(Pivot, T, Smaller, [H|Larger])
end.

%% quicksort tail
tail_qsort([]) -> [];
tail_qsort(L=[_|_]) ->
    tail_qsort(L, []).

tail_qsort([], Acc) -> Acc;
tail_qsort([Pivot|Rest], Acc) ->
    tail_partition(Pivot, Rest, {[], [Pivot], []}, Acc).

tail_partition(_, [], {Smaller, Equal, Larger}, Acc) ->
    tail_qsort(Smaller, Equal ++ tail_qsort(Larger, Acc));
tail_partition(Pivot, [H|T], {Smaller, Equal, Larger}, Acc) ->
    if H < Pivot ->
           tail_partition(Pivot, T, {[H|Smaller], Equal, Larger}, Acc);
       H > Pivot ->
           tail_partition(Pivot, T, {Smaller, Equal, [H|Larger]}, Acc);
       H == Pivot ->
           tail_partition(Pivot, T, {Smaller, [H|Equal], Larger}, Acc)
    end.
