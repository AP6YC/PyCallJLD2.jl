"""
    lib.jl

# Description
Aggregates all types and functions that are used throughout the `PyCallJLD2.jl` package..

# Authors
- Sasha Petrenko <petrenkos@mst.edu>
"""

# -----------------------------------------------------------------------------
# INCLUDES
# -----------------------------------------------------------------------------

# Package version constant
include("version.jl")

# DocStringExtensions templates, etc.
include("docstrings.jl")

# API implementation
include("pycalljld2.jl")
