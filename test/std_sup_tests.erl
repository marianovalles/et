-module (std_sup_tests).
-include_lib ("eunit/include/eunit.hrl").
-compile (export_all).


child_test_() ->
    Mfa0 = {module, start_link, []},
    ChildSpec = {id, Mfa0, temporary, 5000, worker, [module]},
    % Expect std.sup:child to be able to handle any kind of Mfa variant.
    MfaVariants = [module, {module}, {module, start_link}, Mfa0],

    Specs = lists:flatten([[
        % Test spec generation for any point in the cascade.
        std.sup:child(id, Mfa),
        std.sup:child(id, Mfa, temporary),
        std.sup:child(id, Mfa, temporary, 5000),
        std.sup:child(id, Mfa, temporary, 5000, worker),
        std.sup:child(id, Mfa, temporary, 5000, worker, [module])
    ] || Mfa <- MfaVariants ]),

    [?_assertEqual(ChildSpec, Spec) || Spec <- Specs].


spec_test_() ->
    SupSpec = {ok, {{one_for_all, 0, 1}, []}},

    Specs = [
        % Test spec generation for any point in the cascade.
        std.sup:spec(),
        std.sup:spec([]),
        std.sup:spec([], one_for_all),
        std.sup:spec([], one_for_all, 0),
        std.sup:spec([], one_for_all, 0, 1)
    ],

    [?_assertEqual(SupSpec, Spec) || Spec <- Specs].
