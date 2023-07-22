# [Package Guide](@id package-guide)

To save and load `JLD2`, load `PyCall`, `JLD2`, and `PyCallJLD2` in the same scope as where you intend to use the `JLD2.save` and `JLD2.load` functions.
If you are coming from `PyCallJLD`, simply replace `JLD` with `JLD2` everywhere in your usage.

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
