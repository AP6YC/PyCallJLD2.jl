using Documenter
using PyCallJLD2

makedocs(
    sitename = "PyCallJLD2",
    format = Documenter.HTML(),
    modules = [PyCallJLD2]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
