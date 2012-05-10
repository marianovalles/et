-module (std_config_tests).
-include_lib ("eunit/include/eunit.hrl").
-compile (export_all).


get_test_() ->
    [% Should throw if Param missing from env and no Default provided.
     ?_assertException(throw, {error, {std.config, undefined, [foo]}},
        std.config:get(foo)),
     % Should return Default if Param missing from env.
     ?_assertEqual(bar, std.config:get(std, bar))].


app_get_test_() ->
    application:set_env(std_test, baz, bang),
    [% Should throw if Param missing from specified app's env and no Default.
     ?_assertException(throw, {error, {std.config, undefined, [std_test, bar]}},
        std.config:app_get(std_test, bar)),
     % Should return Default if Param missing from app's env.
     ?_assertEqual(bar, std.config:app_get(std_test, foo, bar)),
     % Should return present values.
     ?_assertEqual(bang, std.config:app_get(std_test, baz))].
