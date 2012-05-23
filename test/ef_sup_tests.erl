-module (ef_sup_tests).
-include_lib ("eunit/include/eunit.hrl").
-compile (export_all).


child_test_() ->
    Mfa0 = {module, start_link, []},
    ChildSpec = {id, Mfa0, temporary, 5000, worker, [module]},
    % Expect ef_sup:child to be able to handle any kind of Mfa variant.
    MfaVariants = [module, {module}, {module, start_link}, Mfa0],

    Specs = lists:flatten([[
        % Test spec generation for any point in the cascade.
        ef_sup:child(id, Mfa),
        ef_sup:child(id, Mfa, temporary),
        ef_sup:child(id, Mfa, temporary, 5000),
        ef_sup:child(id, Mfa, temporary, 5000, worker),
        ef_sup:child(id, Mfa, temporary, 5000, worker, [module])
    ] || Mfa <- MfaVariants ]),

    [?_assertEqual(ChildSpec, Spec) || Spec <- Specs].


short_child_test_() ->
    Mfa0 = {module, start_link, []},
    ChildSpec = {module, Mfa0, temporary, 5000, worker, [module]},
    Specs = [
        % Test spec generation for super short child-specs.
        ef_sup:child(module),
        ef_sup:child(module, worker)
    ],
    [?_assertEqual(ChildSpec, Spec) || Spec <- Specs].


spec_test_() ->
    SupSpec = {ok, {{one_for_all, 0, 1}, []}},

    Specs = [
        % Test spec generation for any point in the cascade.
        ef_sup:spec(),
        ef_sup:spec([]),
        ef_sup:spec([], one_for_all),
        ef_sup:spec([], one_for_all, 0),
        ef_sup:spec([], one_for_all, 0, 1)
    ],

    [?_assertEqual(SupSpec, Spec) || Spec <- Specs].
