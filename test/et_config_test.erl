-module (et_config_test).
-include_lib ("etest/include/etest.hrl").
-compile (export_all).


% et_config:get/1, et_config:get/2.
test_get() ->
    % Should throw if Param missing from env and no Default provided.
    ?assert_error({et_config, undefined, [foo]}, et_config:get(foo)),

    % Should return Default if Param missing from env.
    ?assert_equal(bar, et_config:get(std, bar)).


% et_config:app_get/2, et_config:app_get/3.
test_app_get() ->
    application:set_env(et_test, baz, bang),

    % Should throw if Param missing from specified app's env and no Default.
    ?assert_error({et_config, undefined, [et_test, bar]},
        et_config:app_get(et_test, bar)),

    % Should return Default if Param missing from app's env.
    ?assert_equal(bar, et_config:app_get(et_test, foo, bar)),

    % Should return present values.
    ?assert_equal(bang, et_config:app_get(et_test, baz)).
