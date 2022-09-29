"""
accuracy(actual::Forecast, predicted::Vector)

Accuracy Measures of a Forecast Object

return a list of error metrics

# Arguments
- `actual::Forecast`: A Forecast object
- `predicted::Vector`: A vector of predicted values

"""

function accuracy(predicted::Forecast, actual::Vector)
    predicted = predicted.mean
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
function accuracy(predicted::Vector, actual::Vector)
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    out = errorss(actual, predicted)
    return out
end