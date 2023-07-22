"""
    test_sets.jl

# Description
The main collection of tests for the `PyCallJLD2.jl` package.
This file loads common utilities and aggregates all other unit tests files.
"""

# -----------------------------------------------------------------------------
# PREAMBLE
# -----------------------------------------------------------------------------

using PyCallJLD2

# -----------------------------------------------------------------------------
# ADDITIONAL DEPENDENCIES
# -----------------------------------------------------------------------------

using
    Logging,
    Test

# -----------------------------------------------------------------------------
# DrWatson tests
# -----------------------------------------------------------------------------

@testset "Boilerplate" begin
    @assert 1 ==  1
end
