-module (ef_sup_test).
-include_lib ("etest/include/etest.hrl").
-compile (export_all).


% ef_sup:child/2-6.
test_child() ->
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

    [?assert_equal(ChildSpec, Spec) || Spec <- Specs].


% ef_sup:child/1-2.
test_short_child() ->
    Mfa0 = {module, start_link, []},
    ChildSpec = {module, Mfa0, temporary, 5000, worker, [module]},
    Specs = [
        % Test spec generation for super short child-specs.
        ef_sup:child(module),
        ef_sup:child(module, worker)
    ],
    [?assert_equal(ChildSpec, Spec) || Spec <- Specs].


% ef_sup:spec/0-4.
test_spec() ->
    SupSpec = {ok, {{one_for_all, 0, 1}, []}},

    Specs = [
        % Test spec generation for any point in the cascade.
        ef_sup:spec(),
        ef_sup:spec([]),
        ef_sup:spec([], one_for_all),
        ef_sup:spec([], one_for_all, 0),
        ef_sup:spec([], one_for_all, 0, 1)
    ],

    [?assert_equal(SupSpec, Spec) || Spec <- Specs].
