```@meta
DocTestSetup = quote
    using PyCallJLD2, Dates
end
```

# PyCallJLD2.jl

---

These pages serve as the official documentation for the `PyCallJLD2.jl` Julia package.

The purpose of this package is to provide an interface for saving [`PyCall.PyObject`](https://github.com/JuliaPy/PyCall.jl)s with [`JLD2`](https://github.com/JuliaIO/JLD2.jl).

This project is heavily inspired by [`PyCallJLD`]([`PyCallJLD`](https://github.com/JuliaPy/PyCallJLD.jl)).

## Manual Outline

This documentation is split into the following sections:

```@contents
Pages = [
    "man/guide.md",
    "../examples/index.md",
    "man/contributing.md",
]
Depth = 1
```

## Documentation Build

This documentation was built using [Documenter.jl](https://github.com/JuliaDocs/Documenter.jl) with the following version and OS:

```@example
using PyCallJLD2, Dates # hide
println("PyCallJLD2 v$(PYCALLJLD2_VERSION) docs built $(Dates.now()) with Julia $(VERSION) on $(Sys.KERNEL)") # hide
```
