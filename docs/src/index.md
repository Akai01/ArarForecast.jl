# ArarForecast.jl
*Forecasting using Arar Algorithm*

## Installation


    using Pkg
    Pkg.add("ArarForecast")
        
     # dev version
    Pkg.add(url = "https://github.com/Akai01/ArarForecast.jl.git")

## Usage 

#### Load packages

    using CSV
    using Downloads
    using DataFrames
    using TimeSeries
    using Dates
    using ArarForecast

#### Load the data

    dta = CSV.File(Downloads.download("https://raw.githubusercontent.com/Akai01/example-time-series-datasets/main/Data/AirPassengers.csv")) |> DataFrame;

#### Create a TimeArray

    data = (date = dta[:,"ds"], data = dta[:, "y"]);
    data = TimeArray(data; timestamp = :date);

There are different ways to create a `TimeArray` see
[TimeSeries.jl](https://juliastats.org/TimeSeries.jl/latest/timearray/)
package.

#### Forecasting

    fc = arar(data, 12, Month)

    ## 12×5 TimeArray{Float64, 2, Date, Matrix{Float64}} 1961-01-31 to 1961-12-31
    ## │            │ Point_Forecast │ Upper95  │ Upper80  │ Lower95  │ Lower80  │
    ## ├────────────┼────────────────┼──────────┼──────────┼──────────┼──────────┤
    ## │ 1961-01-31 │ 466.1915       │ 486.7582 │ 479.6228 │ 445.6248 │ 452.7602 │
    ## │ 1961-02-28 │ 426.3592       │ 449.5853 │ 441.5272 │ 403.1331 │ 411.1912 │
    ## │ 1961-03-31 │ 463.614        │ 489.4384 │ 480.4789 │ 437.7895 │ 446.749  │
    ## │ 1961-04-30 │ 509.5108       │ 536.8182 │ 527.3442 │ 482.2035 │ 491.6775 │
    ## │ 1961-05-31 │ 516.2016       │ 544.5864 │ 534.7386 │ 487.8169 │ 497.6647 │
    ## │ 1961-06-30 │ 594.0837       │ 623.2017 │ 613.0995 │ 564.9658 │ 575.0679 │
    ## │ 1961-07-31 │ 693.9735       │ 723.6112 │ 713.3287 │ 664.3358 │ 674.6182 │
    ## │ 1961-08-31 │ 670.4816       │ 700.4859 │ 690.0762 │ 640.4772 │ 650.8869 │
    ## │ 1961-09-30 │ 564.4617       │ 594.727  │ 584.2268 │ 534.1964 │ 544.6966 │
    ## │ 1961-10-31 │ 518.5135       │ 549.7526 │ 538.9145 │ 487.2743 │ 498.1124 │
    ## │ 1961-11-30 │ 434.7389       │ 465.992  │ 455.1491 │ 403.4857 │ 414.3287 │
    ## │ 1961-12-31 │ 485.5744       │ 516.8683 │ 506.0112 │ 454.2805 │ 465.1376 │

That’s it. It is easy to use and fast and the accuracy is comparable
with ARIMA or Prophet. No hyper-parameter tuning needed.

## How does the ARAR algorithm Work?

### Memory Shortening

The ARAR algorithm applies a memory-shortening transformation if the
underlying process of a given time series ${Y_{t}, t = 1, 2, ..., n}$ is
"long-memory" then it fits an autoregressive model.

The algorithm follows five steps to classify ${Y_{t}}$ and take one of
the following three actions:

-   L: declare ${Y_{t}}$ as long memory and form ${Y_{t}}$ by
    ${\tilde{Y}_{t} = Y_{t} - \hat{\phi}Y_{t - \hat{\tau}}}$
-   M: declare ${Y_{t}}$ as moderately long memory and form ${Y_{t}}$ by
    ${\tilde{Y}_{t} = Y_{t} - \hat{\phi}_{1}Y_{t -1} - \hat{\phi}_{2}Y_{t -2}}$
-   S: declare ${Y_{t}}$ as short memory.


If ${Y_{t}}$ declared to be $L$ or $M$ then the series ${Y_{t}}$ is
transformed again until. The transformation process continuous until the
transformed series is classified as short memory. However, the maximum
number of transformation process is three, it is very rare a time series
require more than 2 \cite{ITSM}.

The algorithm:

1.  For each$\tau = 1, 2, ..., 15$, we find the value $\hat{\phi(\tau)}$
    of \hat{\phi} that minimizes
    $ERR(\phi, \tau) = \frac{\sum_{t=\tau +1 }^{n} [Y_{t} - \phi Y_{t-\tau}]^2 }{\sum_{t=\tau +1 }^{n} Y_{t}^{2}}$
    then define $Err(\tau) = ERR(\hat{\phi(\tau), \tau})$ and choose the
    lag $\hat{\tau}$ to be the value of $\tau$ that minimizes
    $Err(\tau)$.
2.  If $Err(\hat{\tau}) \leq 8/n$, ${Y_{t}}$ is a long-memory series.
3.  If $\hat{\phi}( \hat{\tau} ) \geq 0.93$ and $\hat{\tau} > 2$,
    ${Y_{t}}$ is a long-memory series.
4.  If $\hat{\phi}( \hat{\tau} ) \geq 0.93$ and $\hat{\tau} = 1$ or
    $2$,${Y_{t}}$ is a long-memory series.
5.  If $\hat{\phi}( \hat{\tau} ) < 0.93$, ${Y_{t}}$ is a short-memory
    series

### Subset Autoregressive Model

In the following we will describe how ARAR algorithm fits an
autoregressive process to the mean-corrected series
$X_{t} = S_{t}- {\bar{S}}$, $t = k+1, ..., n$ where
${S_{t}, t = k + 1, ..., n}$ is the memory-shortened version of
${Y_{t}}$ which derived from the five steps we described above and
$\bar{S}$ is the sample mean of $S_{k+1}, ..., S_{n}$.

The fitted model has the following form:

$X_{t} = \phi_{1}X{t-1} + \phi_{1}X_{t-l_{1}} + \phi_{1}X_{t- l_{1}} + \phi_{1}X_{t-l_{1}} + Z$

where $Z \sim WN(0, \sigma^{2})$. The coefficients $\phi_{j}$ and white
noise variance $\sigma^2$ can be derived from the Yule-Walker equations
for given lags $l_1, l_2,$ and $l_3$:
```math
\begin{equation*}
\begin{bmatrix}
1 & \hat{\rho}(l_1 - 1) & \hat{\rho}(l_2 - 1) & \hat{\rho}(l_3 - 1)\\
\hat{\rho}(l_1 - 1) &1 & \hat{\rho}(l_2 - l_1) & \hat{\rho}(l_3 - l_1)\\
\hat{\rho}(l_2 - 1) & \hat{\rho}(l_2 - l_1) & 1 & \hat{\rho}(l_2 - l_2)\\
\hat{\rho}(l_3 - 1) & \hat{\rho}(l_3 - l_1) & \hat{\rho}(l_3 - l_1) & 1
\end{bmatrix}
\begin{bmatrix}
\phi_{1} \\
\phi_{l_1} \\
\phi_{l_2}\\
\phi_{l_3}
\end{bmatrix} = 
\begin{bmatrix}
\hat{\rho}(1) \\
\hat{\rho}(l_1) \\
\hat{\rho}(l_2)\\
\hat{\rho}(l_3)
\end{bmatrix}
\end{equation*}
```
and
$\sigma^2 = \hat{\gamma}(0) [1-\phi_1\hat{\rho}(1)] - \phi_{l_1}\hat{\rho}(l_1)] - \phi_{l_2}\hat{\rho}(l_2)] - \phi_{l_3}\hat{\rho}(l_3)]$,
where $\hat{\gamma}(j)$ and $\hat{\rho}(j), j = 0, 1, 2, ...,$ are the
sample autocovariances and autocorelations of the series $X_{t}$.

The algorithm computes the coefficients of $\phi(j)$ for each set of
lags where $1<l_1<l_2<l_3 \leq m$ where m chosen to be 13 or 26. The
algorithm selects the model that the Yule-Walker estimate of $\sigma^2$
is minimal.

### Forecasting

If short-memory filter found in first step it has coefficients
$\Psi_0, \Psi_1, ..., \Psi_k (k \geq0)$ where $\Psi_0 = 1$. In this case
the transforemed series can be expressed as 
```math
\begin{equation*}
S_t = \Psi(B)Y_t = Y_t + \Psi_1 Y_{t-1} + ...+ \Psi_k Y_{t-k},
\*end{equation*} 
```
where $\Psi(B) = 1 + \Psi_1B + ...+ \Psi_k B^k$ is
polynomial in the back-shift operator.

If the coefficients of the subset autoregression found in the second
step it has coefficients $\phi_1, \phi_{l_1}, \phi_{l_2}$ and
$\phi_{l_3}$ then the subset AR model for $X_t = S_t - \bar{S}$ is
```math
\begin{equation*}
\phi(B)X_t = Z_t,
\end{equation*}
```
where $Z_t$ is a white-noise series with zero mean and constant variance
and
$\phi(B) = 1 - \phi_1B - \phi_{l_1}B^{l_1} - \phi_{l_2}B^{l_2} - \phi_{l_3}B^{l_3}$.
From equation (1) and (2) one can obtain
```math
\begin{equation*}

\xi(B)Y_t = \phi(1)\bar{S} + Z_t,

\end{equation*}
```
where $\xi (B) = \Psi(B)\phi(B)$.

Assuming the fitted model in equation (3) is an appropriate model, and
$Z_t$ is uncorrelated with $Y_j, j <t$$\forall t \in T$, one can
determine minimum mean squared error linear predictors
$P_n Y_{n + h}$of$Y_{n+h}$in terms of${1, Y_1, ..., Y_n}$ for
$n > k + l_3$, from recursions
```math
\begin{equation*}
P_n Y_{n+h} = - \sum_{j = 1}^{k + l_3} \xi P_nY_{n+h-j} + \phi(1)\bar{S},  h\geq 1,
\end{equation*} 
```
with the initial conditions $P_n Y_{n+h} = Y_{n + h},$
for $h\leq0.$

### Ref: Brockwell, Peter J, and Richard A. Davis. Introduction to Time Series and Forecasting. [Springer](https://link.springer.com/book/10.1007/978-3-319-29854-2) (2016)

## Package Features
- Automatic model selection
- Automatic Forecasting
- Error maesurement
## Function Documentation
```@docs
arar
```
