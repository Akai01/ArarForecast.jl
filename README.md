# The ARAR Algorithm:

## Memory Shortening

The ARAR algorithm applies a memory-shortening transformation if the
underlying process of a given time series
*Y*<sub>*t*</sub>, *t* = 1, 2, ..., *n* is “long-memory” then it fits an
autoregressive model.

The algorithm follows five steps to classify *Y*<sub>*t*</sub> and take
one of the following three actions:

-   L: declare *Y*<sub>*t*</sub> as long memory and form
    *Y*<sub>*t*</sub> by
    *Ỹ*<sub>*t*</sub> = *Y*<sub>*t*</sub> − *ϕ̂Y*<sub>*t* − *τ̂*</sub>
-   M: declare *Y*<sub>*t*</sub> as moderately long memory and form
    *Y*<sub>*t*</sub> by
    *Ỹ*<sub>*t*</sub> = *Y*<sub>*t*</sub> − *ϕ̂*<sub>1</sub>*Y*<sub>*t* − 1</sub> − *ϕ̂*<sub>2</sub>*Y*<sub>*t* − 2</sub>
-   S: declare *Y*<sub>*t*</sub> as short memory.

If *Y*<sub>*t*</sub> declared to be *L* or *M* then the series
*Y*<sub>*t*</sub> is transformed again until. The transformation process
continuous until the transformed series is classified as short memory.
However, the maximum number of transformation process is three, it is
very rare a time series require more than 2.

-   1.  For each *τ* = 1, 2, ..., 15, we find the value
        ϕ̂(*τ̂* ) of *ϕ̂* that minimizes ![formula](https://latex.codecogs.com/svg.image?\begin{equation}&space;&space;&space;&space;ERR(\phi,&space;\tau)&space;=&space;\frac{\sum_{t=\tau&space;&plus;1&space;}^{n}&space;[Y_{t}&space;-&space;\phi&space;Y_{t-\tau}]^2&space;}{\sum_{t=\tau&space;&plus;1&space;}^{n}&space;Y_{t}^{2}}\end{equation}) 
        then define Err(*τ*) = ERR(ϕ(*τ̂* ), *τ*) and
        choose the lag *τ̂* to be the value of *τ* that minimizes
        *E**r**r*(*τ*).

-   2.  If *E**r**r*(*τ̂*) ≤ 8/*n*, *Y*<sub>*t*</sub> is a long-memory
        series.

-   3.  If *ϕ̂*(*τ̂*) ≥ 0.93 and *τ̂* &gt; 2, *Y*<sub>*t*</sub> is a
        long-memory series.

-   4.  If *ϕ̂*(*τ̂*) ≥ 0.93 and *τ̂* = 1 or 2, *Y*<sub>*t*</sub> is a
        long-memory series.

-   5.  If *ϕ̂*(*τ̂*) &lt; 0.93, *Y*<sub>*t*</sub> is a short-memory
        series.

## Subset Autoregressive Model:

In the following we will describe how ARAR algorithm fits an
autoregressive process to the mean-corrected series
*X*<sub>*t*</sub> = *S*<sub>*t*</sub> − *S̄*, *t* = *k* + 1, ..., *n*
where *S*<sub>*t*</sub>, *t* = *k* + 1, ..., *n* is the memory-shortened
version of *Y*<sub>*t*</sub> which derived from the five steps we
described above and *S̄* is the sample mean of
*S*<sub>*k* + 1</sub>, ..., *S*<sub>*n*</sub>.

The fitted model has the following form:

*X*<sub>*t*</sub> = *ϕ*<sub>1</sub>*X*<sub>t</sub> − 1 + *ϕ*<sub>1</sub>*X*<sub>*t* − *l*<sub>1</sub></sub> + *ϕ*<sub>1</sub>*X*<sub>*t* − *l*<sub>1</sub></sub> + *ϕ*<sub>1</sub>*X*<sub>*t* − *l*<sub>1</sub></sub> + *Z*

where *Z* ∼ *WN*(0,*σ*<sup>2</sup>). The coefficients
*ϕ*<sub>*j*</sub> and white noise variance *σ*<sup>2</sup> can be
derived from the Yule-Walker equations for given lags
*l*<sub>1</sub>, *l*<sub>2</sub>, and *l*<sub>3</sub>:

![formula](https://latex.codecogs.com/svg.image?\begin{equation}&space;\begin{bmatrix}1&space;&&space;\hat{\rho}(l_1&space;-&space;1)&space;&&space;\hat{\rho}(l_2&space;-&space;1)&space;&&space;\hat{\rho}(l_3&space;-&space;1)\\\hat{\rho}(l_1&space;-&space;1)&space;&1&space;&&space;\hat{\rho}(l_2&space;-&space;l_1)&space;&&space;\hat{\rho}(l_3&space;-&space;l_1)\\\hat{\rho}(l_2&space;-&space;1)&space;&&space;\hat{\rho}(l_2&space;-&space;l_1)&space;&&space;1&space;&&space;\hat{\rho}(l_2&space;-&space;l_2)\\\hat{\rho}(l_3&space;-&space;1)&space;&&space;\hat{\rho}(l_3&space;-&space;l_1)&space;&&space;\hat{\rho}(l_3&space;-&space;l_1)&space;&&space;1\end{bmatrix}*\begin{bmatrix}\phi_{1}&space;\\\phi_{l_1}&space;\\\phi_{l_2}\\\phi_{l_3}\end{bmatrix}&space;=&space;\begin{bmatrix}&space;\hat{\rho}(1)&space;\\&space;\hat{\rho}(l_1)&space;\\&space;\hat{\rho}(l_2)\\&space;\hat{\rho}(l_3)&space;\end{bmatrix}\end{equation})

and *σ*<sup>2</sup> = *γ̂*(0)\[1−*ϕ*<sub>1</sub>*ρ̂*(1)\] − *ϕ*<sub>*l*<sub>1</sub></sub>*ρ̂*(*l*<sub>1</sub>)\] − *ϕ*<sub>*l*<sub>2</sub></sub>*ρ̂*(*l*<sub>2</sub>)\] − *ϕ*<sub>*l*<sub>3</sub></sub>*ρ̂*(*l*<sub>3</sub>)\],
where *γ̂*(*j*) and *ρ̂*(*j*), *j* = 0, 1, 2, ..., are the sample
autocovariances and autocorelations of the series *X*<sub>*t*</sub>.

The algorithm computes the coefficients of *ϕ*(*j*) for each set of lags
where
1 &lt; *l*<sub>1</sub> &lt; *l*<sub>2</sub> &lt; *l*<sub>3</sub> ≤ *m*
where m chosen to be 13 or 26. The algorithm selects the model that the
Yule-Walker estimate of *σ*<sup>2</sup> is minimal.

## Forecasting

If short-memory filter found in first step it has coefficients
*Ψ*<sub>0</sub>, *Ψ*<sub>1</sub>, ..., *Ψ*<sub>*k*</sub>(*k*≥0) where
*Ψ*<sub>0</sub> = 1. In this case the transforemed series can be
expressed as 

![formula](https://latex.codecogs.com/svg.image?\begin{equation}&space;&space;&space;&space;S_t&space;=&space;\Psi(B)Y_t&space;=&space;Y_t&space;&plus;&space;\Psi_1&space;Y_{t-1}&space;&plus;&space;...&plus;&space;\Psi_k&space;Y_{t-k}\end{equation})

where *Ψ*(*B*) = 1 + *Ψ*<sub>1</sub>*B* + ... + *Ψ*<sub>*k*</sub>*B*<sup>*k*</sup>
is polynomial in the back-shift operator.

If the coefficients of the subset autoregression found in the second
step it has coefficients
*ϕ*<sub>1</sub>, *ϕ*<sub>*l*<sub>1</sub></sub>, *ϕ*<sub>*l*<sub>2</sub></sub>
and *ϕ*<sub>*l*<sub>3</sub></sub> then the subset AR model for
*X*<sub>*t*</sub> = *S*<sub>*t*</sub> − *S̄* is

where *Z*<sub>*t*</sub> is a white-noise series with zero mean and
constant variance and
*ϕ*(*B*) = 1 − *ϕ*<sub>1</sub>*B* − *ϕ*<sub>*l*<sub>1</sub></sub>*B*<sup>*l*<sub>1</sub></sup> − *ϕ*<sub>*l*<sub>2</sub></sub>*B*<sup>*l*<sub>2</sub></sup> − *ϕ*<sub>*l*<sub>3</sub></sub>*B*<sup>*l*<sub>3</sub></sup>.
From equation (1) and (2) one can obtain

where *ξ*(*B*) = *Ψ*(*B*)*ϕ*(*B*).

Assuming the fitted model in equation (3) is an appropriate model, and
*Z*<sub>*t*</sub> is uncorrelated with *Y*<sub>*j*</sub>, *j* &lt; *t*
∀*t* ∈ *T*, one can determine minimum mean squared error linear
predictors *P*<sub>*n*</sub>*Y*<sub>*n* + *h*</sub> of
*Y*<sub>*n* + *h*</sub> in terms of
1, *Y*<sub>1</sub>, ..., *Y*<sub>*n*</sub> for
*n* &gt; *k* + *l*<sub>3</sub>, from recursions

![formula](https://latex.codecogs.com/svg.image?\begin{equation}&space;&space;&space;&space;P_n&space;Y_{n&plus;h}&space;=&space;-&space;\sum_{j&space;=&space;1}^{k&space;&plus;&space;l_3}&space;\xi&space;P_nY_{n&plus;h-j}&space;&plus;&space;\phi(1)\bar{S},&space;&space;h\geq&space;1,\end{equation})

with the initial conditions
*P*<sub>*n*</sub>*Y*<sub>*n* + *h*</sub> = *Y*<sub>*n* + *h*</sub>, for
*h* ≤ 0.
