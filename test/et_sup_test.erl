-module (et_sup_test).
-include_lib ("etest/include/etest.hrl").
-compile (export_all).


% et_sup:child/2-6.
test_child() ->
    Mfa0 = {module, start_link, []},
    ChildSpec = {id, Mfa0, temporary, 5000, worker, [module]},
    % Expect et_sup:child to be able to handle any kind of Mfa variant.
    MfaVariants = [module, {module}, {module, start_link}, Mfa0],

    Specs = lists:flatten([[
        % Test spec generation for any point in the cascade.
        et_sup:child(id, Mfa),
        et_sup:child(id, Mfa, temporary),
        et_sup:child(id, Mfa, temporary, 5000),
        et_sup:child(id, Mfa, temporary, 5000, worker),
        et_sup:child(id, Mfa, temporary, 5000, worker, [module])
    ] || Mfa <- MfaVariants ]),

    [?assert_equal(ChildSpec, Spec) || Spec <- Specs].


% et_sup:child/1-2.
test_short_child() ->
    Mfa0 = {module, start_link, []},
    ChildSpec = {module, Mfa0, temporary, 5000, worker, [module]},
    Specs = [
        % Test spec generation for super short child-specs.
        et_sup:child(module),
        et_sup:child(module, worker)
    ],
    [?assert_equal(ChildSpec, Spec) || Spec <- Specs].


% et_sup:spec/0-4.
test_spec() ->
    SupSpec = {ok, {{one_for_all, 0, 1}, []}},

    Specs = [
        % Test spec generation for any point in the cascade.
        et_sup:spec(),
        et_sup:spec([]),
        et_sup:spec([], one_for_all),
        et_sup:spec([], one_for_all, 0),
        et_sup:spec([], one_for_all, 0, 1)
    ],

    [?assert_equal(SupSpec, Spec) || Spec <- Specs].
