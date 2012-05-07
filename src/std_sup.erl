%% @license GNU General Public License (GPL) Version 3
%% @doc OTP supervisor module for .
-module (std_sup).

% OPT supervisor callbacks.
-behaviour (supervisor).
-export ([start_link/0, init/1]).

-export ([child/2, child/3, child/4, child/5, child/6]).


%% @doc Creates a std supervisor process as part of a supervision tree.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).


%% @doc Callback; Builds std's main supervisor spec.
init([]) -> ignore.



%% @doc TODO - Document!
child(Id, StartFunc) ->
    child(Id, StartFunc, temporary).

%% @doc TODO - Document!
child(Id, StartFunc, Restart) ->
    child(Id, StartFunc, Restart, _Shutdown = 5000).

%% @doc TODO - Document!
child(Id, StartFunc, Restart, Shutdown) ->
    child(Id, StartFunc, Restart, Shutdown, _Type = worker).

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
