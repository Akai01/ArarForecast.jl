push!(LOAD_PATH,"../src/")
using ArarForecast
using Pkg; 
Pkg.add("Documenter")
using Documenter
makedocs(
         sitename = "ArarForecast.jl",
         modules  = [ArarForecast],
         pages=[
                "Home" => "index.md"
               ])
deploydocs(;
    repo="github.com/akai01/ArarForecast.jl",
)