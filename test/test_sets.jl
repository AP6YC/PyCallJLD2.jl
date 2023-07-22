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
    Pkg,        # for rebuilding PyCall
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
ENV["PYTHON"] = ""
Pkg.build("PyCall")

# Init the Python module the way that it would be loaded and stored in a Julia module
const lm = PyNULL()
copy!(lm, pyimport_conda("sklearn.linear_model", "sklearn"))

@testset "PyCall" begin
    # Import some modules
    # @pyimport sklearn.linear_model as lm

    # Create some PyObjects
    m1 = lm.LinearRegression()
    m2 = lm.ARDRegression()

    # Modle name
    model_file = "models.jld2"

    # Save
    JLD2.save(model_file, "mods", [m1, m2])

    # Load
    models = JLD2.load(model_file, "mods")

    # Cleanup
    rm(model_file)
end
