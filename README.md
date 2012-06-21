## erlang-toolkit/et

`et`, short for erlang-toolkit, is a collection of general-purpose Erlang library modules.


## Installation

Install `et` by adding it as a [rebar](https://github.com/basho/rebar)
dependency:

```erlang
% In your rebar.config:
{deps, [
    {et, "", {git, "git://github.com/erlang-toolkit/et.git"}}
]}.
```

Afterwards, run `rebar get-deps` to sync your dependencies.
