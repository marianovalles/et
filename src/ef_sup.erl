%% @license GNU General Public License (GPL) Version 3
%% @doc OTP supervisor helper module.
-module (ef_sup).

-export ([child/1, child/2, child/3, child/4, child/5, child/6]).
-export ([spec/0, spec/1, spec/2, spec/3, spec/4]).

%% @doc TODO - Document!
-define (DEFAULT_TYPE, worker).

%% @doc TODO - Document!
-define (DEFAULT_RESTART, temporary).

%% @doc TODO - Document!
-define (DEFAULT_SHUTDOWN, 5000).


%% @doc TODO - Document!
spec() ->
    spec([]).

%% @doc TODO - Document!
spec(Children) ->
    spec(Children, _RestartStrategy = one_for_all).

%% @doc TODO - Document!
spec(Children, RestartStrategy) ->
    spec(Children, RestartStrategy, _MaxR = 0).

%% @doc TODO - Document!
spec(Children, RestartStrategy, MaxR) ->
    spec(Children, RestartStrategy, MaxR, _MaxT = 1).

%% @doc TODO - Document!
spec(Children, RestartStrategy, MaxR, MaxT) ->
    {ok, {{RestartStrategy, MaxR, MaxT}, Children}}.



%% @doc TODO - Document!
child(Module) ->
    child(Module, Module).

%% @doc TODO - Document!
child(Module, Type) when Type == worker orelse Type == supervisor ->
    child(Module, Module, ?DEFAULT_RESTART, ?DEFAULT_SHUTDOWN, Type);

%% @doc TODO - Document!
child(Id, StartFunc) ->
    child(Id, StartFunc, ?DEFAULT_RESTART).

%% @doc TODO - Document!
child(Id, StartFunc, Restart) ->
    child(Id, StartFunc, Restart, ?DEFAULT_SHUTDOWN).

%% @doc TODO - Document!
child(Id, StartFunc, Restart, Shutdown) ->
    child(Id, StartFunc, Restart, Shutdown, ?DEFAULT_TYPE).

%% @doc TODO - Document!
child(Id, StartFunc0, Restart, Shutdown, Type) ->
    StartFunc = {Module, _, _} = make_mfa(StartFunc0),
    child(Id, StartFunc, Restart, Shutdown, Type, _Modules = [Module]).

%% @doc TODO - Document!
child(Id, StartFunc, Restart, Shutdown, Type, Modules) ->
    {Id, make_mfa(StartFunc), Restart, Shutdown, Type, Modules}.



%% @doc TODO - Document!
make_mfa(Module) when is_atom(Module) ->
    make_mfa({Module, start_link});

%% @doc TODO - Document!
make_mfa({Module}) ->
    make_mfa(Module);

%% @doc TODO - Document!
make_mfa({Module, Fun}) ->
    make_mfa({Module, Fun, []});

%% @doc TODO - Document!
make_mfa(MFA) -> MFA.
