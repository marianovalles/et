-module (ef_config_tests).
-include_lib ("eunit/include/eunit.hrl").
-compile (export_all).


get_test_() ->
    [% Should throw if Param missing from env and no Default provided.
     ?_assertException(throw, {error, {ef_config, undefined, [foo]}},
        ef_config:get(foo)),
     % Should return Default if Param missing from env.
     ?_assertEqual(bar, ef_config:get(std, bar))].


app_get_test_() ->
    application:set_env(ef_test, baz, bang),
    [% Should throw if Param missing from specified app's env and no Default.
     ?_assertException(throw, {error, {ef_config, undefined, [ef_test, bar]}},
        ef_config:app_get(ef_test, bar)),
     % Should return Default if Param missing from app's env.
     ?_assertEqual(bar, ef_config:app_get(ef_test, foo, bar)),
     % Should return present values.
     ?_assertEqual(bang, ef_config:app_get(ef_test, baz))].
