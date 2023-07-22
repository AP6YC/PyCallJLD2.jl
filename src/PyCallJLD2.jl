"""
    PyCallJLD2.jl

# Description
Definition of the `PyCallJLD2.jl` package module.

# Authors
- Sasha Petrenko <petrenkos@mst.edu>
"""

"""
A module encapsulating the experimental driver code for the OAR project.

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
    PyCall,                 # PyObject, pyimport, etc.
    JLD2                    # For overloading writeas, wconvert, and rconvert

# -----------------------------------------------------------------------------
# INCLUDES
# -----------------------------------------------------------------------------

# Package version constant
include("version.jl")

# DocStringExtensions templates, etc.
include("docstrings.jl")

# -----------------------------------------------------------------------------
# CONSTANTS
# -----------------------------------------------------------------------------

"""
Pointer to the correct Python pickle `dumps` object.
"""
const dumps = PyNULL()

"""
Pointer to the correct Python pickle `loads` object.
"""
const loads = PyNULL()

"""
Lock during pycalls (see https://github.com/JuliaPy/PyCall.jl/issues/882).
"""
const PYLOCK = Ref{ReentrantLock}()

# -----------------------------------------------------------------------------
# STRUCTS
# -----------------------------------------------------------------------------

"""
Serialization wrapper type for PyObjects to be saved with JLD2.
"""
struct PyObjectSerialization
    """
    Byte representation of the serialized PyObject data.
    """
    repr::Vector{UInt8}
end

# -----------------------------------------------------------------------------
# FUNCTIONS
# -----------------------------------------------------------------------------

# Runs once when the package during Import or Using
function __init__()
    # Point to the correct pickle module for Python 2/3
    pickle = pyimport(PyCall.pyversion.major ≥ 3 ? "pickle" : "cPickle")
    copy!(dumps, pickle.dumps)
    copy!(loads, pickle.loads)
    # Construct the lock for locking pycall operations
    PYLOCK[] = ReentrantLock()
end

"""
Definition of the reentrant lock for PyCall functions
"""
pylock(f::Function) = Base.lock(f, PYLOCK[])

# OVERLOAD: tells JLD2 to write PyObjects as serialized objects
JLD2.writeas(::Type{PyObject}) = PyObjectSerialization

# OVERLOAD: tells JLD2 that this is how to convert a PyObject into a serialized verion
function JLD2.wconvert(::Type{PyObjectSerialization}, pyo::PyObject)
    # pickle.dumps the PyObject
    b = pylock() do
        PyCall.PyBuffer(pycall(dumps, PyObject, pyo))
    end

    # From PyCallJLD:
    # We need a `copy` here because the PyBuffer might be GC'ed after we've
    # left this scope, but see
    # https://github.com/JuliaPy/PyCallJLD.jl/pull/3/files/17b052d018f79905baf855b40e440d2cacc171ae#r115525173
    serialized = pylock() do
        PyObjectSerialization(
            copy(
                unsafe_wrap(
                    Array,
                    Ptr{UInt8}(pointer(b)),
                    sizeof(b)
                )
            )
        )
    end

    # Return the copied and wrapped serialized pickle
    return serialized
end

# OVERLOAD: tells JLD2 how to turn a serialized object back into a Julia PyOject
function JLD2.rconvert(::Type{PyObject}, pyo_ser::PyObjectSerialization)
    # Reconstruct the serialized pickle object
    reconstructed = pylock() do
        pycall(
            loads,
            PyObject,
            PyObject(
                PyCall.@pycheckn ccall(
                    @pysym(PyCall.PyString_FromStringAndSize),
                    PyPtr,
                    (Ptr{UInt8}, Int),
                    pyo_ser.repr,
                    sizeof(pyo_ser.repr)
                )
            )
        )
    end

    # Return the reconstructed object
    return reconstructed
end

# -----------------------------------------------------------------------------
# EXPORTS
# -----------------------------------------------------------------------------

export

    PYCALLJLD2_VERSION

end
