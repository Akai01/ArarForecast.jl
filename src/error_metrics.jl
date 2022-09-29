function errorss(actual, predicted)
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    out = (me = me(actual, predicted), mae = mae(actual, predicted), 
    mape = mape(actual, predicted), mdae = mdae(actual, predicted), 
    rmse = rmse(actual, predicted))
    return out
end

"""
ae(actual::Vector{}, predicted::Vector{})

Absolute Error

return A vector of absolute error

# Arguments
- `actual::Vector{}`: A vector of actual values
- `predicted::Vector{}`: A vector of predicted values

# Examples
```julia-repl
julia> actual = [3,5,6,7,8]
julia> pred = [7, 3, 4,5,1]

julia> ae(acc, pred)

```

"""
function ae(actual::Vector{}, predicted::Vector{})
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    return abs.(actual .- predicted)
end

"""
ape(actual::Vector{}, predicted::Vector{})

Absolute Percent Error

return A vector of absolute percent error

# Arguments
- `actual::Vector{}`: A vector of actual values
- `predicted::Vector{}`: A vector of predicted values

# Examples
```julia-repl
julia> actual = [3,5,6,7,8]
julia> pred = [7, 3, 4,5,1]

julia> ape(acc, pred)
```

"""
function ape(actual::Vector{}, predicted::Vector{})
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    return ae(actual, predicted) ./ abs.(actual)
end
"""
me(actual::Vector{}, predicted::Vector{})

Mean Error

return A vector of mean error

# Arguments
- `actual::Vector{}`: A vector of actual values
- `predicted::Vector{}`: A vector of predicted values

# Examples
```julia-repl
julia> actual = [3,5,6,7,8]
julia> pred = [7, 3, 4,5,1]

julia> me(actual, pred)

```
"""
function me(actual::Vector{}, predicted::Vector{})
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    return Statistics.mean.([actual-predicted])
end

"""
mae(actual::Vector{}, predicted::Vector{})

Mean Absolute Error

return A vector of mean absolute error

# Arguments
- `actual::Vector{}`: A vector of actual values
- `predicted::Vector{}`: A vector of predicted values

# Examples
```julia-repl
julia> actual = [3,5,6,7,8]
julia> pred = [7, 3, 4,5,1]

julia> mae(acc, pred)

```
"""
function mae(actual::Vector{}, predicted::Vector{})
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    return Statistics.mean.([ae(actual, predicted)])
end


"""
mape(actual::Vector{}, predicted::Vector{})

Mean Absolute Percent Error

return A vector of mean absolute percent error

# Arguments
- `actual::Vector{}`: A vector of actual values
- `predicted::Vector{}`: A vector of predicted values

# Examples
```julia-repl
julia> actual = [3,5,6,7,8]
julia> pred = [7, 3, 4,5,1]

julia> mape(acc, pred)

```
"""
function mape(actual::Vector{}, predicted::Vector{})
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    return Statistics.mean.([ape(actual, predicted)])
end

"""
mdae(actual::Vector{}, predicted::Vector{})

Median Absolute Error

return A vector of median absolute error

# Arguments
- `actual::Vector{}`: A vector of actual values
- `predicted::Vector{}`: A vector of predicted values

# Examples
```julia-repl
julia> actual = [3,5,6,7,8]
julia> pred = [7, 3, 4,5,1]

julia> mdae(acc, pred)

```
"""
function mdae(actual::Vector{}, predicted::Vector{})
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    return Statistics.median.([ae(actual, predicted)])
end


"""
se(actual::Vector{}, predicted::Vector{})

Squared Error

return A vector of squared error

# Arguments
- `actual::Vector{}`: A vector of actual values
- `predicted::Vector{}`: A vector of predicted values

# Examples
```julia-repl
julia> actual = [3,5,6,7,8]
julia> pred = [7, 3, 4,5,1]

julia> mse(actual, pred)

```
"""
function se(actual, predicted)
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    return (actual-predicted).^2
end



"""
mse(actual::Vector{}, predicted::Vector{})

Mean Squared Error

return A vector of mean squared error

# Arguments
- `actual::Vector{}`: A vector of actual values
- `predicted::Vector{}`: A vector of predicted values

# Examples
```julia-repl
julia> actual = [3,5,6,7,8]
julia> pred = [7, 3, 4,5,1]

julia> mse(acc, pred)

```
"""
function mse(actual::Vector{}, predicted::Vector{})
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    return Statistics.mean(se(actual, predicted))
end

"""
rmse(actual::Vector{}, predicted::Vector{})

Root Mean Squared Error

return A vector of root mean squared error

# Arguments
- `actual::Vector{}`: A vector of actual values
- `predicted::Vector{}`: A vector of predicted values

# Examples
```julia-repl
julia> actual = [3,5,6,7,8]
julia> pred = [7, 3, 4,5,1]

julia> rmse(actual, pred)

```
"""
function rmse(actual::Vector{}, predicted::Vector{})
    @assert length(actual) == length(predicted) "Length of actual and prediction must be the same"
    return Statistics.sqrt.(mse(actual, predicted))
end