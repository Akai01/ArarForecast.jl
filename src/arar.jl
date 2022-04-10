"""
arar(y::TimeArray, h::Int, freq::DataType)

Forecasting using ARAR algorithm.

Return A matrix of forecast values and prediction intervals

# Arguments
- `y::TimeArray`: An TimeArray with only one value column.
- `h::Int`: Forecast horizon as an integer.
- `freq::DataType`: A DataType from Dates, e.g. Dates.Day or Dates.Month.

# Examples
```julia-repl
julia> arar(data, 12, Month)

```
"""
function arar(y::TimeArray, h::Int, freq::DataType)
  future_dates = range(maximum(timestamp(y)) + freq(1); step=freq(1), length=h)
  y = dropdims(values(y), dims = 2)
  Y = y
  @assert length(y) >= 40 "Series is too short for arar"
  Ψ = [1]

  for k in collect(1:3) 
    n = length(y)
    # memory shortening 
    ϕ = map(τ -> (sum(y[(τ + 1):n] .* 
    y[1:(n - τ)])/sum(y[1:(n - τ)].^2)), 1:15) 
    err = map(τ -> (sum((y[(τ + 1):n] - 
    ϕ[τ]*y[1:(n - τ)]).^2)/sum(y[(τ + 1):n].^2)), 1:15)
    τ = argmin(err)
    if err[τ] <= 8/n || (ϕ[τ] >= 0.93 && τ > 2)
      y = y[(τ + 1):n] - ϕ[τ] * y[1:(n - τ)]
      Ψ = [Ψ;zeros(τ)] .- ϕ[τ] .* [zeros(τ); Ψ]
    elseif ϕ[τ] >= 0.93
      A = zeros(2, 2)
      A[1, 1] = sum(y[2:(n - 1)].^2)
      A[1, 2] = sum(y[1:(n - 2)] .* y[2:(n - 1)])
      A[2, 1] = sum(y[1:(n - 2)] .* y[2:(n - 1)])
      A[2, 2] = sum(y[1:(n - 2)].^2)
      b = (sum(y[3:n] .* y[2:(n - 1)]), sum(y[3:n] .* y[1:(n - 2)]))
      ϕ = ((A' * A) ^ -1) * A'*collect(b)
      y = y[3:n] - ϕ[1] * y[2:(n - 1)] - ϕ[2] * y[1:(n - 2)]
      Ψ = (Ψ, [0], [0]) .- (ϕ[1] .* (0, Ψ, 0) ).- ϕ[2] .* (0, 0, Ψ)
    else
      break
  
    end
  end

S = y
Sbar = mean(S)
X = S .- Sbar
max_lag = 40
n = length(X)
xbar = Statistics.mean(X)
gamma = map(i -> sum((X[1:(n - i)] .- xbar) .* (X[(i + 1):n] .- xbar))/n, 0:max_lag)
y = Y
A = reshape(repeat([gamma[1]], 16), (4,4))
b = zeros(4)
best_σ2 = Inf
m = 26
best_lag = []
best_phi = []

for i in 2:(m-2) 
    for j in (i + 1):(m-1) 
        for k in (j + 1):m
            A[1, 2] = A[2, 1] = gamma[i]
            A[1, 3] = A[3, 1] = gamma[j]
            A[2, 3] = A[3, 2] = gamma[j - i + 1]
            A[1, 4] = A[4, 1] = gamma[k]
            A[2, 4] = A[4, 2] = gamma[k - i + 1]
            A[3, 4] = A[4, 3] = gamma[k - j + 1]
            b[1] = gamma[2]
            b[2] = gamma[i + 1]
            b[3] = gamma[j + 1]
            b[4] = gamma[k + 1]

            ϕ = ((A' * A) ^ -1) * A'*collect(b)

            σ2 = gamma[1] .- ϕ[1] .* gamma[2] .- ϕ[2] .* 
            gamma[i + 1] .- ϕ[3] .* gamma[j + 1] .- ϕ[4] .* gamma[k + 1]
            
            if σ2 < best_σ2
                best_σ2 = σ2
                best_phi = ϕ
                best_lag = (1, i, j, k)
            end
        end
        
    end
    
end

i = best_lag[2]
j = best_lag[3]
k = best_lag[4]
ϕ = best_phi
σ2 = best_σ2

xi = [Ψ; zeros(k)] .- 
ϕ[1] * [[0]; Ψ; zeros(k-1)] .- 
ϕ[2] * [zeros(i); Ψ; zeros(k - i)] .- 
ϕ[3] * [zeros(j); Ψ; zeros(k - j)] .-
ϕ[4] * [zeros(k); Ψ]

n = length(y)
k = length(xi)
y = [y; zeros(h)]
c = (1 - sum(ϕ)) .* Sbar

meanfc = map(i-> y[n + i] = - sum(xi[2:k] .* y[n + i + 1 .- (2:k)]) .+ c, 1:h)
y = y[1:n]
if h > k
  xi = append!(xi, zeros(h - k))
end
τ = zeros(h)
τ[1] = 1

if h > 1
  for j in 1:(h-1)
    τ[j + 1] = -sum((τ[1:j] .* xi[sort(((1:j) .+ 1), rev = true)]))
  end

end

se = Statistics.sqrt!(σ2 .* map(j -> sum(τ[1:j].^2), 1:h))

data = (datetime = future_dates, Point_Forecast = meanfc, Upper95 = meanfc + 1.96 .* se, Upper80 = meanfc + 1.28 .* se, Lower95 = meanfc - 1.96 .* se, Lower80 = meanfc - 1.28 .* se)
out = TimeArray(data; timestamp = :datetime)

return out

end