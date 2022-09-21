module ArarForecast

using Statistics
using TimeSeries
using Dates

include("arar.jl")
include("accuracy.jl")
include("plot.jl")

export arar
export accuracy
export plot

end