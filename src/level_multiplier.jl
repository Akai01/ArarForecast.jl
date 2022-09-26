function level_multiplier(level::Vector)
out = quantile.(Normal(0, 1), .5 .+ level/200)
return(out)
end