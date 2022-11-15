using ArarForecast
using TimeSeries
using Distributions
using Dates
using Test

@testset "ArarForecast.jl" begin
    ts_dta = (value = rand(Distributions.Normal(73,0.73),73), 
    date = Date(2011, 3, 1):Month(1):Date(2017, 3, 1));
    ts_dta = TimeArray(ts_dta; timestamp = :date)

    ts_dta_test = (value = rand(Distributions.Normal(73,0.73),7), 
    date = Date(2017, 4, 1):Month(1):Date(2017, 10, 1));
    
    ts_dta_test = TimeArray(ts_dta_test; timestamp = :date)
    
    fc = arar(;y = ts_dta, h = 7, freq = Month, level = [80, 95]);
    @test mean(fc.mean) ≈ 73 atol= 3
    @test accuracy(fc, ts_dta_test)[1] .≈ 0.374 atol= 0.1
end
