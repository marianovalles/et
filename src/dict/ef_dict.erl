%% @license GNU General Public License (GPL) Version 3
-module (ef_dict).
-compile (export_all).


%% @doc Creates a new dictionary in the default representation.
new() ->
    % Pick erlang's `dict` as the default representation, since it outperforms
    % orddict, proplists and gb_trees.
    new(dict).


% Create a new dictionary using erlang's `dict`.
new(dict) -> dict:new();

% Create a new dictionary using erlang's `orddict`.
new(orddict) -> ef_orddict:new();

% Create a new dictionary using erlang's `gb_trees`.
new(gb_tree) -> ef_tree:new();

% Create a new dictionary using erlang's `proplists`.
new(proplist) -> ef_proplist:new().
