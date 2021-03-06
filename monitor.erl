-module(monitor).
-compile(export_all).

start_critic() ->
  spawn(?MODULE, restarter, []).

judge(Band, Album) ->
  Ref = make_ref(),
  critic ! {self(), Ref, {Band, Album}},
  receive
    {Ref, Criticism} -> Criticism
  after 2000 ->
    timeout
  end.


critic() ->
  receive
    {From, Ref, {"Rage Against the Turning Machine", "Unit Testify"}} ->
      From ! {Ref, "They are great!"};
    {From, Ref, {"System of the downtime", "Memoize"}} ->
      From ! {Ref, "They're not Johhny Crash but they're good."};
    {From, Ref, {"Johnny Crash", "The Token Ring of Fire"}} ->
      From ! {Ref, "Simply incredible!"};
    {From, Ref, {_Band, _Album}} ->
      From ! {Ref, "They are terrible!"}
    end,
    critic().

  start_critic2() ->
      spawn(?MODULE, restarter, []).

  restarter() ->
      process_flag(trap_exit, true),
      Pid = spawn_link(?MODULE, critic2, []),
      register(critic, Pid),
      receive
          {'EXIT', Pid, normal} -> % not a crash
              ok;
          {'EXIT', Pid, shutdown} -> % manual shutdown, not a crash
              ok;
          {'EXIT', Pid, _} ->
              restarter()
      end.

  judge2(Band, Album) ->
      Ref = make_ref(),
      critic ! {self(), Ref, {Band, Album}},
      receive
          {Ref, Criticism} -> Criticism
      after 2000 ->
          timeout
      end.

  critic2() ->
      receive
          {From, Ref, {"Rage Against the Turing Machine", "Unit Testify"}} ->
              From ! {Ref, "They are great!"};
          {From, Ref, {"System of a Downtime", "Memoize"}} ->
              From ! {Ref, "They're not Johnny Crash but they're good."};
          {From, Ref, {"Johnny Crash", "The Token Ring of Fire"}} ->
              From ! {Ref, "Simply incredible."};
          {From, Ref, {_Band, _Album}} ->
              From ! {Ref, "They are terrible!"}
      end,
      critic2().
