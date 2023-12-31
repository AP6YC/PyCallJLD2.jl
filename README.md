[![pycalljld2-header](https://github.com/AP6YC/FileStorage/blob/main/PyCallJLD2/header.png?raw=true)][docs-dev-url]

This package is to [JLD2][jld2] what [PyCallJLD][pycalljld] is to [JLD][jld], implementing a serializer for saving and loading [PyCall][pycall] [`PyObject`][pyobject-readme]s with JLD2.

Please see the official [documentation][docs-dev-url] for usage and contribution guidelines.

| **Documentation** | **Coverage** | **CI Status** | **Releases** |
|:-----------------:|:------------:|:-------------:|:-----------:|
| [![Dev][docs-dev-img]][docs-dev-url] | [![Codecov][codecov-img]][codecov-url] | [![CI Status][ci-img]][ci-url] | [![Zenodo][zenodo-img]][zenodo-url] |
| [![Stable][docs-stable-img]][docs-stable-url] | [![Coveralls][coveralls-img]][coveralls-url] | [![Documentation][doc-status-img]][doc-status-url] | [![version][version-img]][version-url] |
| **Dependents** | **Issues** | **JuliaHub Status** | **Downloads** |
| [![deps][deps-img]][deps-url] | [![GitHubIssues][issues-img]][issues-url] | [![JuliaHub][pkgeval-img]][pkgeval-url] | [![Downloads][downloads-img]][downloads-url] |

[version-img]: https://juliahub.com/docs/General/PyCallJLD2/stable/version.svg
[version-url]: https://juliahub.com/ui/Packages/General/PyCallJLD2

[deps-img]: https://juliahub.com/docs/General/PyCallJLD2/stable/deps.svg
[deps-url]: https://juliahub.com/ui/Packages/General/PyCallJLD2?t=2

[downloads-img]: https://shields.io/endpoint?url=https://pkgs.genieframework.com/api/v1/badge/PyCallJLD2
[downloads-url]: https://pkgs.genieframework.com?packages=PyCallJLD2

[issues-img]: https://img.shields.io/github/issues/AP6YC/PyCallJLD2.jl
[issues-url]: https://github.com/AP6YC/PyCallJLD2.jl/issues

[zenodo-img]: https://zenodo.org/badge/DOI/10.5281/zenodo.8333905.svg
[zenodo-url]: https://doi.org/10.5281/zenodo.8333905

[pkgeval-img]: https://juliahub.com/docs/PyCallJLD2/pkgeval.svg
[pkgeval-url]: https://juliahub.com/ui/Packages/PyCallJLD2

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://AP6YC.github.io/PyCallJLD2.jl/stable

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://AP6YC.github.io/PyCallJLD2.jl/dev

[doc-status-img]: https://github.com/AP6YC/PyCallJLD2.jl/actions/workflows/Documentation.yml/badge.svg
[doc-status-url]: https://github.com/AP6YC/PyCallJLD2.jl/actions/workflows/Documentation.yml

[ci-img]: https://github.com/AP6YC/PyCallJLD2.jl/workflows/CI/badge.svg
[ci-url]: https://github.com/AP6YC/PyCallJLD2.jl/actions?query=workflow%3ACI

[codecov-img]: https://codecov.io/gh/AP6YC/PyCallJLD2.jl/branch/main/graph/badge.svg
[codecov-url]: https://codecov.io/gh/AP6YC/PyCallJLD2.jl

[coveralls-img]: https://coveralls.io/repos/github/AP6YC/PyCallJLD2.jl/badge.svg?branch=main
[coveralls-url]: https://coveralls.io/github/AP6YC/PyCallJLD2.jl?branch=main

[pyobject-readme]: https://github.com/JuliaPy/PyCall.jl#pyobject
[pycall]: https://github.com/JuliaPy/PyCall.jl
[jld]: https://github.com/JuliaIO/JLD.jl/
[pycalljld]: https://github.com/JuliaPy/PyCallJLD.jl
[jld2]: https://github.com/JuliaIO/JLD2.jl
[pickle-dumps]: https://docs.python.org/3.8/library/pickle.html#pickle.dumps

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Usage](#usage)
- [Attribution](#attribution)
  - [Authors](#authors)
  - [Packages](#packages)
  - [License](#license)

## Usage

Please see the [documentation][docs-dev-url] for full usage.

To save and load `JLD2`, load `PyCall`, `JLD2`, and `PyCallJLD2` in the same scope as where you intend to use the `JLD2.save` and `JLD2.load` functions.
If you are coming from `PyCallJLD`, simply replace `JLD` with `JLD2` everywhere in your usage.

The following example is take from [PyCallJLD][pycalljld] for direct comparison:

```julia
using PyCall, JLD2, PyCallJLD2

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

Just as in [PyCallJLD][pycalljld], these objects are saved with [`pickle.dumps`][pickle-dumps].

## Attribution

### Authors

The following authors are responsible for authoring this package:

- Sasha Petrenko <sap625@mst.edu> @AP6YC

### Packages

This package is heavily based upon the [`PyCallJLD.jl`][pycalljld] package; the funky-monkey-wrenching of PyCall `ccall`s, pointers, and other low-level tomfoolery would have been arcane and indecipherable without this prior work.
This package merely modifies its internal usage to match the modified [`JLD2`][jld2] API for custom serialization.

### License

This package uses the [MIT License](LICENSE).
