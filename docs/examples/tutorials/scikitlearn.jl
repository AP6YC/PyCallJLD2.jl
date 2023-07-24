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
# This script borrows heavily from the [saving models to disk](https://cstjean.github.io/ScikitLearn.jl/dev/man/jld/) example in `ScikitLearn.jl` documentation to illustrate how this package can be used as a drop-in for using `JLD2.jl` instead of `JLD.jl`.

# ## Setup

# First, you must have your `PyCall` environment setup in the correct way.
# Here, we will point to the default Python installation internal to Julia and make sure to rebuild the PyCall package to point to it
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

# Because we are showing how to save and load `ScikitLearn.jl` objects, we will also load that package and other dependencies:

using
    ScikitLearn,            # for @sk_import
    ScikitLearn.Pipelines   # for Pipeline

# ## Create some `ScikitLearn.jl` `PyObject`s

# Now we use the `ScikitLearn.jl` API to load scikit-learn modules:

## Import some scikit-learn modules
@sk_import decomposition: PCA
@sk_import linear_model: LinearRegression

# We can instantiate the modules:

pca = PCA()
lm = LinearRegression()

# and make up some random training data:

X=rand(10, 3); y=rand(10);

# and create a pipeline from one model to another:

pip = Pipeline([("PCA", pca), ("LinearRegression", lm)])

# Just to illustrate the statefulness of the model, let us fit the pipeline to our random dataset:

fit!(pip, X, y)   # fit to some dataset

# and see how it fares on the same data:

score_1 = score(pip, X, y)

# ## Save and Load

# Now we will save the model with the `JLD2.save` interface:

## Name the file to save and load to
model_file = "models.jld2"
## Save the pipeline
JLD2.save(model_file, "pip", pip)

# And we can load the same module into another variable in this context:
pip_2 = JLD2.load(model_file, "pip")

# Finally, lets calculate the score again for the loaded model:

score_2 = score(pip_2, X, y)

# and verify that the score is the same as before

score_1 == score_2

# And voila!
# The answers are the same because we retained the stateful information of the pipeline during saving and loading.

# !!! note
#     When loading the object, you must be sure that the definition for the unpacked data is in the current workspace (i.e., if you change terminal sessions here, you must remember to reimport `@sk_import ...` before loading the model file).

# For the sake of this script, we will clean up after ourselves and remove the model:
rm(model_file)
