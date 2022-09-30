"""
accuracy(actual::Forecast, predicted::ArarForecast.Forecast)

Accuracy Measures of a Forecast Object

return a list of error metrics

# Arguments
- `actual::Forecast`: A Forecast object
- `predicted::ArarForecast.Forecast`: A Forecast object

"""

function accuracy(predicted::ArarForecast.Forecast, actual::TimeArray)
    @assert size(predicted.mean,2) == 1 "Only univariate time series are allowed"
    @assert size(actual,2) == 1 "Only univariate time series are allowed"
    predicted = dropdims(values(predicted.mean); dims = 2)
    actual = dropdims(values(actual); dims = 2)
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    out = errorss(actual, predicted)
    return out
end

"""
accuracy(actual::Vector, predicted::Vector)

Accuracy Measures of a Forecast Object

return A vector of absolute error

# Arguments
- `actual::Vector`: A vector of actual values
- `predicted::Vector`: A vector of predicted values

# Examples
```julia-repl
julia> actual = [3,5,6,7,8]
julia> pred = [7, 3, 4,5,1]

julia> accuracy(actual, pred)

```

"""
function accuracy(predicted::TimeArray, actual::TimeArray)
    @assert size(predicted,2) == 1 "Only univariate time series are allowed"
    @assert size(actual,2) == 1 "Only univariate time series are allowed"
    predicted = dropdims(values(predicted); dims = 2)
    actual = dropdims(values(actual); dims = 2)
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    out = errorss(actual, predicted)
    return out
end