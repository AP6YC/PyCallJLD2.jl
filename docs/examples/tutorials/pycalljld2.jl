# ---
# title: PyCallJLD2 Tutorial
# id: pycalljld2-tutorial
# date: 2023-7-21
# cover: ../assets/julialang_logo_icon.png
# author: "[Sasha Petrenko](https://github.com/AP6YC)"
# julia: 1.9
# description: This demo provides a quick example of how to run the PyCallJLD2 package for saving and loading PyCall objects with JLD2.
# ---

# ## Overview

# This demo shows how to get started with `PyCallJLD2.jl`.
# Because its usage is very similar, much of the code is taken directly from the example for [`PyCallJLD`](https://github.com/JuliaPy/PyCallJLD.jl) as a direct comparison.

# ## Setup

# First, you must have your `PyCall` environment setup in the correct way.
# Here, we will point to the default Python installation internal to Julia
ENV["PYTHON"] = ""
using Pkg
Pkg.build("PyCall")

# Next, we load our dependencies.
# To use this package, you must load `PyCall`, `JLD2`, and `PyCallJLD2` in the context that you intend to do model saving and loading:

## Load the modules into the current context
using
    PyCall,     # for PyObjects
    JLD2,       # for saving and loading
    PyCallJLD2  # for telling JLD2 how to save and load PyObjects

# ## Create some `PyObject`s

# Next, we load a scikit-learn module with the `@pyimport` macro
@pyimport sklearn.linear_model as lm

# We can finally create some Python objects:
m1 = lm.LinearRegression()

# and
m2 = lm.ARDRegression()

# ## Save and Load

# We should first declare where we are saving the file rather than typing it out repeatedly:
model_file = "models.jld2"

# To save, we use the normal `JLD2.save` usage:
JLD2.save(model_file, "mods", [m1, m2])

# To load, we also use the normal `JLD2.load` usage:
models = JLD2.load(model_file, "mods")

# And voila!
# We have back our two models, ready for use.

# !!! note
#     When loading the object, you must be sure that the definition for the unpacked data is in the current workspace (i.e., if you change terminal sessions here, you must remember to reimport `@pyimport sklearn.linear_model as lm` before loading the model file).

# For the sake of this script, we will clean up after ourselves and remove the model:
rm(model_file)
