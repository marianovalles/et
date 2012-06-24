%% @license GNU General Public License (GPL) Version 3
%% @doc Application configuration retrieval.
-module (et_config).
-export ([
    get/1, get/2, app_get/2, app_get/3]).


%% @doc Attempts to get the given key from the current app's environment,
%%      throws an exception of the form {et_config, undefined, Param}
%%      otherwise.
get(Param) ->
    ensure_param([Param]).


%% @doc Attempts to retrieve Param from the calling processes's application
%%      environment, returns Default otherwise.
get(Param, Default) ->
    env_or_default([Param], Default).


%% @doc Attempts to retrieve Param from the App's environment,
%%      throws an exception of the form {et_config, undefined, Param}
%%      otherwise.
app_get(App, Param) ->
    ensure_param([App, Param]).


%% @doc Attempts to retrieve `Param` from the specified application's
%%      environment, returns `Default` otherwise.
app_get(App, Param, Default) ->
    env_or_default([App, Param], Default).



%% @doc Attempts to retrieve `Param` from the calling processes's application
%% environment, throws an exception of the form {et_config, undefined, Param}
%% otherwise.
env_or_default(Args, Default) ->
    case erlang:apply(application, get_env, Args) of
        {ok, Value} -> Value;
        _ -> Default
    end.


%% @doc Either retrieves the environment variable defined through `Args` or
%% throws (error) an exception of the form {et_config, undefined, Param}
%% otherwise.
ensure_param(Args) ->
    case env_or_default(Args, undef__) of
        undef__ -> error({et_config, undefined, Args});
        Value -> Value
    end.
