-module (et_types_test).
-include ("et_types.hrl").
-include_lib ("etest/include/etest.hrl").
-compile (export_all).


test_to_int() ->
    ?assert_equal(42, et_types:to_int(42)),
    ?assert_equal(42, et_types:to_int(<<"42">>)),
    ?assert_equal(42, et_types:to_int(42.234)),
    ?assert_equal(42, et_types:to_int('42')),
    ?assert_equal(42, et_types:to_int("42")).


test_to_string() ->
    ?assert_equal("42", et_types:to_string(42)),
    ?assert_equal("42", et_types:to_string('42')),
    ?assert_equal("42", et_types:to_string(<<"42">>)),
    ?assert_equal("42", et_types:to_string("42")),
    ?assert_equal("4.22340000000000017621e+01",
        et_types:to_string(42.234)).


test_to_atom() ->
    ?assert_equal('42', et_types:to_atom('42')),
    ?assert_equal('42', et_types:to_atom("42")).


test_to_binary() ->
    ?assert_equal(<<"42">>, et_types:to_binary(42)),
    ?assert_equal(<<"42">>, et_types:to_binary('42')),
    ?assert_equal(<<"42">>, et_types:to_binary(<<"42">>)),
    ?assert_equal(<<"42">>, et_types:to_binary("42")),
    ?assert_equal(<<"4.22340000000000017621e+01">>,
        et_types:to_binary(42.234)).
