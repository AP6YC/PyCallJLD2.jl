"""
    PyCallJLD2.jl

# Description
Definition of the `PyCallJLD2.jl` package module.

# Attribution

## Authors
- Sasha Petrenko <petrenkos@mst.edu>

## Packages
This package is inspired by and built off of the work at [`PyCallJLD.jl`](https://github.com/JuliaPy/PyCallJLD.jl).
"""

"""
The top-level module for the `PyCallJLD2.jl` package.

# Imports

The following names are imported by the package as dependencies:
$(IMPORTS)

# Exports

The following names are exported and available when `using` the package:
$(EXPORTS)
"""
module PyCallJLD2

# -----------------------------------------------------------------------------
# DEPENDENCIES
# -----------------------------------------------------------------------------

# Full usings (which supports comma-separated import notation)
using
    DocStringExtensions,    # Docstring macros, etc.
    Pkg,                    # For version.jl (Pkg.TOML.parsefile)
    PyCall,                 # PyObject, pyimport, etc.
    JLD2                    # For overloading writeas, wconvert, and rconvert

# -----------------------------------------------------------------------------
# INCLUDES
# -----------------------------------------------------------------------------

# All of the aggregated code for the package
include("lib/lib.jl")

# -----------------------------------------------------------------------------
# EXPORTS
# -----------------------------------------------------------------------------

export

    PYCALLJLD2_VERSION

end
