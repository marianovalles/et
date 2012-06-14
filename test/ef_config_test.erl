-module (ef_config_test).
-include_lib ("etest/include/etest.hrl").
-compile (export_all).


% ef_config:get/1, ef_config:get/2.
test_get() ->
    % Should throw if Param missing from env and no Default provided.
    ?assert_throw({error, {ef_config, undefined, [foo]}}, ef_config:get(foo)),

    % Should return Default if Param missing from env.
    ?assert_equal(bar, ef_config:get(std, bar)).


% ef_config:app_get/2, ef_config:app_get/3.
test_app_get() ->
    application:set_env(ef_test, baz, bang),

    % Should throw if Param missing from specified app's env and no Default.
    ?assert_throw({error, {ef_config, undefined, [ef_test, bar]}},
        ef_config:app_get(ef_test, bar)),

    % Should return Default if Param missing from app's env.
    ?assert_equal(bar, ef_config:app_get(ef_test, foo, bar)),

    % Should return present values.
    ?assert_equal(bang, ef_config:app_get(ef_test, baz)).
