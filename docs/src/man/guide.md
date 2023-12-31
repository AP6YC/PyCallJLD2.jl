# [Package Guide](@id package-guide)

To work with the `PyCallJLD2.jl` package, you should know:

- [How to install the package](@ref installation)
- [How to use the package](@ref basic-usage)

## [Installation](@id installation)

The `PyCallJLD2.jl` package can be installed using the Julia package manager.
From the Julia REPL, type `]` to enter the Pkg REPL mode and run

```julia-repl
julia> ]
(@v1.9) pkg> add PyCallJLD2
```

Alternatively, it can be added to your environment in a script with

```julia
using Pkg
Pkg.add("PyCallJLD2")
```

If you wish to have the latest changes between releases, you can directly add the GitHub repo at an arbitrary branch (such as `develop`) as a dependency with

```julia-repl
julia> ]
(@v1.9) pkg> add https://github.com/AP6YC/PyCallJLD2.jl#develop
```

## [Basic Usage](@id basic-usage)

To save and load `JLD2`, load `PyCall`, `JLD2`, and `PyCallJLD2` in the same scope as where you intend to use the `JLD2.save` and `JLD2.load` functions.
If you are coming from `PyCallJLD`, simply replace `JLD` with `JLD2` everywhere in your usage:

```julia
# Import all of your dependencies
import PyCall, JLD2, PyCallJLD2
```

and use the `JLD2` API to save:

```julia
JLD2.save("model_file.jld2", "model_name", model)
```

or load:

```julia
JLD2.load("model_file.jld2", "model_name")
```

!!! note
    When loading the model back, you must be sure that the definition for the unpacked data is in the current workspace (i.e., if you change terminal sessions here, you must remember to reimport `@pyimport ...` before loading the model file).

The following example is take from [PyCallJLD](https://github.com/JuliaPy/PyCallJLD.jl) for direct comparison:

```julia
# Load all dependencies in the context where we plan on saving and loading
using PyCall, JLD2, PyCallJLD2

# Import the scikit-learn linear model module
@pyimport sklearn.linear_model as lm

# Create some Python objects
m1 = lm.LinearRegression()
m2 = lm.ARDRegression()

# Save them to models.jld2
JLD2.save("models.jld2", "mods", [m1, m2])

# Load them back
models = JLD2.load("models.jld2", "mods")

# Do a dance🕺
```

Just as in [PyCallJLD](https://github.com/JuliaPy/PyCallJLD.jl), these objects are saved with [`pickle.dumps`](https://docs.python.org/3.8/library/pickle.html#pickle.dumps).

!!! note
    Please see the [Examples](@ref examples) page to see this usage in action with `PyCall.jl` and `ScikitLearn.jl`.
