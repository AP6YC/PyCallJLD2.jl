"""
    test_sets.jl

# Description
The main collection of tests for the `PyCallJLD2.jl` package.
This file loads common utilities and aggregates all other unit tests files.
"""

# -----------------------------------------------------------------------------
# PREAMBLE
# -----------------------------------------------------------------------------

## Load the modules into the current context
using
    # Pkg,        # for rebuilding PyCall
    PyCall,     # for PyObjects
    JLD2,       # for saving and loading
    PyCallJLD2  # this package

# -----------------------------------------------------------------------------
# ADDITIONAL DEPENDENCIES
# -----------------------------------------------------------------------------

using
    Logging,
    Test

# -----------------------------------------------------------------------------
# UNIT TESTS
# -----------------------------------------------------------------------------

# Build the PyCall environment for all tests
# ENV["PYTHON"] = ""
# Pkg.build("PyCall")

# Init the Python module the way that it would be loaded and stored in a Julia module
const lm = PyNULL()
# copy!(lm, pyimport_conda("sklearn.linear_model", "sklearn"))
copy!(lm, pyimport_conda("sklearn.linear_model", "scikit-learn"))

@testset "PyCall Save and Load" begin
    # Create some PyObjects
    m1 = lm.LinearRegression()
    m2 = lm.ARDRegression()

    # Model name
    model_file = "models.jld2"

    # Wrap saving and loading to make sure of cleanup
    try
        # Save
        JLD2.save(model_file, "mods", [m1, m2])

        # Load
        models = JLD2.load(model_file, "mods")
        # Test assertions
        @assert typeof(models) == typeof([m1, m2])
        @assert typeof(models[1]) == typeof(m1)
        @assert typeof(models[2]) == typeof(m2)

    finally
        # Cleanup
        rm(model_file)

    end
end
