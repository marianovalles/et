%% @doc Alias for `atom_to_binary`.
-define (a2b (Atom), atom_to_binary(Atom, utf8)).

%% @doc Alias for atom_to_list.
-define (a2l (Atom), atom_to_list(Atom)).

%% @doc Convert an atom, which includes nothing but an integer (e.g. '42')
%%      into the integer itself.
-define (a2i (Atom), ?l2i(?a2l(Atom))).


%% @doc Alias for `list_to_atom`.
-define (l2a (String), list_to_atom(String)).

%% @doc Alias for list_to_binary.
-define (l2b (String), list_to_binary(String)).

%% @doc Alias for `list_to_integer`.
-define (l2i (String), list_to_integer(String)).


%% @doc Alias for binary_to_list.
-define (b2l (Binary), binary_to_list(Binary)).

%% @doc Convert a binary-encoded integer into a 'real' integer.
-define (b2i (Binary), ?l2i(?b2l(Binary))).


%% @doc Alias for `integer_to_list`.
-define (i2l (Integer), integer_to_list(Integer)).

%% @doc Convert an integer into a binary which includes the int's
%%      string representation.
-define (i2b (Integer), ?l2b(?i2l(Integer))).


%% @doc Alias for `float_to_list`.
-define (f2l (Float), float_to_list(Float)).

%% @doc Convert a float into an integer by rounding.
-define (f2i (Float), round(Float)).

%% @doc Convert a float into a binary with the floats string representation.
-define (f2b (Float), ?l2b(?f2l(Float))).


%% @doc Alias for `tuple_to_list`.
-define (t2l (Tuple), tuple_to_list(Tuple)).

%% @doc Alias for `list_to_tuple`.
-define (l2t (List), list_to_tuple(List)).

%% @doc Reverses the contents of the given tuple.
-define (tR (Tuple), ?l2t(lists:reverse(?t2l(Tuple)))).
