# ---
# title: PyCallJLD2 and ScikitLearn.jl
# id: scikit-learn
# date: 2023-7-21
# cover: ../assets/Scikit_learn_logo_small.svg
# author: "[Sasha Petrenko](https://github.com/AP6YC)"
# julia: 1.9
# description: This demo provides an example of how to run the PyCallJLD2 package for saving and loading ScikitLearn.jl objects with JLD2.
# ---

# ## Overview

# This demo shows how to use `PyCallJLD2.jl` to save models from [`ScikitLearn.jl`](https://github.com/cstjean/ScikitLearn.jl).

# ## Setup

# First, you must have your `PyCall` environment setup in the correct way.
# Here, we will point to the default Python installation internal to Julia
ENV["PYTHON"] = ""
using Pkg
Pkg.build("PyCall")


#

# TODO
