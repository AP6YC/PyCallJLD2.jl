"""
    make.jl

# Description
This file builds the documentation for the `PyCallJLD2.jl` package
using Documenter.jl and other tools.
"""

# -----------------------------------------------------------------------------
# DEPENDENCIES
# -----------------------------------------------------------------------------

using
    Documenter,
    DemoCards,
    Logging,
    Pkg

# -----------------------------------------------------------------------------
# SETUP
# -----------------------------------------------------------------------------

# Common variables of the script
PROJECT_NAME = "PyCallJLD2"
DOCS_NAME = "docs"

# Fix GR headless errors
ENV["GKSwstype"] = "100"

# Get the current workind directory's base name
current_dir = basename(pwd())
@info "Current directory is $(current_dir)"

# If using the CI method `julia --project=docs/ docs/make.jl`
#   or `julia --startup-file=no --project=docs/ docs/make.jl`
if occursin(PROJECT_NAME, current_dir)
    push!(LOAD_PATH, "../src/")
# Otherwise, we are already in the docs project and need to dev the above package
elseif occursin(DOCS_NAME, current_dir)
    Pkg.develop(path="..")
# Otherwise, building docs from the wrong path
else
    error("Unrecognized docs setup path")
end

# Include the local package
using PyCallJLD2

# using JSON
if haskey(ENV, "DOCSARGS")
    for arg in split(ENV["DOCSARGS"])
        (arg in ARGS) || push!(ARGS, arg)
    end
end

# -----------------------------------------------------------------------------
# GENERATE
# -----------------------------------------------------------------------------

# Generate the demo files
# this is the relative path to docs/
demopage, postprocess_cb, demo_assets = makedemos("examples")

assets = [
    joinpath("assets", "favicon.ico"),
]

# if there are generated css assets, pass it to Documenter.HTML
isnothing(demo_assets) || (push!(assets, demo_assets))

# Make the documentation
makedocs(
    modules=[PyCallJLD2],
    format=Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
        assets = assets,
    ),
    pages=[
        "Home" => "index.md",
        "Tutorial" => [
            "Guide" => "man/guide.md",
            demopage,
            # "Examples" => "man/examples.md",
            # "Modules" => "man/modules.md",
            "Contributing" => "man/contributing.md",
            # "Index" => "man/full-index.md",
            # "Internals" => "man/dev-index.md",
        ],
    ],
    repo="https://github.com/AP6YC/PyCallJLD2.jl/blob/{commit}{path}#L{line}",
    sitename="PyCallJLD2.jl",
    authors="Sasha Petrenko",
    # assets=String[],
)

# 3. postprocess after makedocs
postprocess_cb()

# a workdaround to github action that only push preview when PR has "push_preview" labels
# issue: https://github.com/JuliaDocs/Documenter.jl/issues/1225
# function should_push_preview(event_path = get(ENV, "GITHUB_EVENT_PATH", nothing))
#     event_path === nothing && return false
#     event = JSON.parsefile(event_path)
#     haskey(event, "pull_request") || return false
#     labels = [x["name"] for x in event["pull_request"]["labels"]]
#     return "push_preview" in labels
#  end

# -----------------------------------------------------------------------------
# DEPLOY
# -----------------------------------------------------------------------------

deploydocs(
    repo="github.com/AP6YC/PyCallJLD2.jl.git",
    devbranch="develop",
    # push_preview = should_push_preview(),
)
