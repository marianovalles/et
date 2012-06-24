%% @license GNU General Public License (GPL) Version 3
%% @doc Type transformation module.
-module (et_types).
-include ("et_types.hrl").
-compile (export_all).


to_int(Integer) when is_integer(Integer) -> Integer;
to_int(Binary)  when is_binary(Binary)   -> ?b2i(Binary);
to_int(Float)   when is_float(Float)     -> ?f2i(Float);
to_int(Atom)    when is_atom(Atom)       -> ?a2i(Atom);
to_int(String)  when is_list(String)     -> ?l2i(String).

to_ints(Values) -> [to_int(Value) || Value <- Values].


to_string(Integer) when is_integer(Integer) -> ?i2l(Integer);
to_string(Binary)  when is_binary(Binary)   -> ?b2l(Binary);
to_string(Float)   when is_float(Float)     -> ?f2l(Float);
to_string(Atom)    when is_atom(Atom)       -> ?a2l(Atom);
to_string(String)  when is_list(String)     -> String.

to_strings(Values) -> [to_string(Value) || Value <- Values].


to_atom(String)  when is_list(String)     -> ?l2a(String);
to_atom(Atom)    when is_atom(Atom)       -> Atom.

to_atoms(Values) -> [to_atom(Value) || Value <- Values].


to_binary(Integer) when is_integer(Integer) -> ?i2b(Integer);
to_binary(Binary)  when is_binary(Binary)   -> Binary;
to_binary(Float)   when is_float(Float)     -> ?f2b(Float);
to_binary(Atom)    when is_atom(Atom)       -> ?a2b(Atom);
to_binary(String)  when is_list(String)     -> ?l2b(String).

to_binaries(Values) -> [to_binary(Value) || Value <- Values].
