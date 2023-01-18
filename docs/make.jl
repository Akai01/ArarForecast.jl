using ArarForecast
using Documenter

DocMeta.setdocmeta!(ArarForecast, :DocTestSetup, :(using ArarForecast); recursive=true)

makedocs(;
    modules=[ArarForecast],
    authors="Resul Akay <resulakay1@gmail.com> and contributors",
    repo="https://github.com/akai01/ArarForecast.jl/blob/{commit}{path}#{line}",
    sitename="ArarForecast.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://akai01.github.io/ArarForecast.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/akai01/ArarForecast.jl",
    devbranch="main",
)
