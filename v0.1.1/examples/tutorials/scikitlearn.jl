ENV["PYTHON"] = ""
using Pkg
Pkg.build("PyCall")

# Load the modules into the current context
using
    PyCall,     # for PyObjects
    JLD2,       # for saving and loading
    PyCallJLD2  # for telling JLD2 how to save and load PyObjects

using
    ScikitLearn,            # for @sk_import
    ScikitLearn.Pipelines   # for Pipeline

# Import some scikit-learn modules
@sk_import decomposition: PCA
@sk_import linear_model: LinearRegression

pca = PCA()
lm = LinearRegression()

X=rand(10, 3); y=rand(10);

pip = Pipeline([("PCA", pca), ("LinearRegression", lm)])

fit!(pip, X, y)   # fit to some dataset

score_1 = score(pip, X, y)

# Name the file to save and load to
model_file = "models.jld2"
# Save the pipeline
JLD2.save(model_file, "pip", pip)

pip_2 = JLD2.load(model_file, "pip")

score_2 = score(pip_2, X, y)

score_1 == score_2

rm(model_file)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl
