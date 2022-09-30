function level_multiplier(level::Int)
out = Distributions.quantile.(Distributions.Normal(0, 1), 0.5 .+ level / 200)
return(out)
end