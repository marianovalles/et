%% @license GNU General Public License (GPL) Version 3
%% @doc OTP application callback module.
-module (std_app).

% OPT application callbacks.
-behaviour (application).
-export ([start/2, stop/1]).


%% @doc Called upon starting std;
%%      Starts std's main supervisor.
start(_StartType, _StartArgs) ->
    std_sup:start_link().


% @doc Callback; Returns just `ok`.
stop(_State) -> ok.
