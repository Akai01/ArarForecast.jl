
"""
`plot(object::Forecast, ylab::Str="Value", xlab::Str="Date")`

Plot a Forecast Object

return a Forecast plot

# Arguments
`object::Forecast` A Forecast object
`ylab::Str` y axis lable
`xlab::Str` x axis lable

"""

function plot(object::Forecast, ylab::String="Value", xlab::String="Date")
    label = "Historical Data"
    p = Plots.plot(object.y, label = label, ylab = ylab, xlab = xlab, legend=:topleft, title = object.method)
    p = Plots.plot(p, object.mean, linestyle = :dot)
    p = Plots.plot(p, object.upper, linestyle = :dot, label = :none, ribbon = values(object.upper) .- values(object.mean))
    p = Plots.plot(p, object.lower, linestyle = :dot, label = :none, ribbon = values(object.lower) .- values(object.mean))
    return p
end