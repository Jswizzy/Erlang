-module(r).
-compile(export_all).

%% reverse
rev([]) -> [];
rev([H|T]) -> rev(T)++[H].

%%  reverse tail
t_rev(L) -> t_rev(L,[]).

t_rev([],Acc) -> Acc;
t_rev([H|T],Acc) -> t_rev(T, [H|Acc]).

%% factorial
fac(N) when N == 0 -> 1;
fac(N) when N >  0 -> N*fac(N-1).

%% tail_fac
tail_fac(N) -> tail_fac(N,1).

tail_fac(0, Acc) -> Acc;
tail_fac(N, Acc) when N > 0 -> tail_fac(N-1, N*Acc).

%% length
len([]) -> 0;
len([_|T]) -> len(T) + 1.

%% lenght tail
t_len(L) -> t_len(L,0).

t_len([], Acc) -> Acc;
t_len([_|T], Acc) -> t_len(T,Acc+1).

%% sublist
sublist(_,0) -> [];
sublist([],_) -> [];
sublist([H|T],N) when N > 0 -> [H|sublist(T,N-1)].

%% sublist tail
t_sub(L,N) -> t_rev(t_sub(L,N,[])).

t_sub(_,0,Sl) -> Sl;
t_sub([],_,Sl) -> Sl;
t_sub([H|T],N,Sl) when N > 0 ->
  t_sub(T,N-1,[H|Sl]).

%% zip
zip([],_) -> [];
zip(_,[]) -> [];
zip([X|Xs],[Y|Ys]) -> [{X,Y}|zip(Xs,Ys)].

t_zip(L1,L2) -> t_rev(t_zip(L1,L2,[])).

t_zip(_,[],List) -> List;
t_zip([],_,List) -> List;
t_zip([H1|T1],[H2|T2],List) -> t_zip(T1,T2,[{H1,H2}|List]).
