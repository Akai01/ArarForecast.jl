module ArarForecast

using Statistics
using TimeSeries
using Dates

import Statistics: Normal
import Statistics: quantile

include("arar.jl")
include("accuracy.jl")
include("plot.jl")
include("level_multiplier.jl")

export arar
export accuracy
export plot

end