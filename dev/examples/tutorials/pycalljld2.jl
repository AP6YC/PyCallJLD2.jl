ENV["PYTHON"] = ""
using Pkg
Pkg.build("PyCall")

# Load the modules into the current context
using
    PyCall,     # for PyObjects
    JLD2,       # for saving and loading
    PyCallJLD2  # for telling JLD2 how to save and load PyObjects

@pyimport sklearn.linear_model as lm

m1 = lm.LinearRegression()

m2 = lm.ARDRegression()

model_file = "models.jld2"

JLD2.save(model_file, "mods", [m1, m2])

models = JLD2.load(model_file, "mods")

rm(model_file)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

