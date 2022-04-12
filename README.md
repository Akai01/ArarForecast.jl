# ArarForecast

# Note: The project is under development!

<div id="the-arar-algorithm" class="section level1">
<h1>The ARAR Algorithm:</h1>
<div id="memory-shortening" class="section level2">
<h2>Memory Shortening</h2>
<p>The ARAR algorithm applies a memory-shortening transformation if the
underlying process of a given time series <span class="math inline">\({Y_{t}, t = 1, 2, ..., n}\)</span> is
“long-memory” then it fits an autoregressive model.</p>
<p>The algorithm follows five steps to classify <span class="math inline">\({Y_{t}}\)</span> and take one of the following
three actions:</p>
<ul>
<li>L: declare <span class="math inline">\({Y_{t}}\)</span> as long
memory and form <span class="math inline">\({Y_{t}}\)</span> by <span class="math inline">\({\tilde{Y}_{t} = Y_{t} - \hat{\phi}Y_{t -
\hat{\tau}}}\)</span></li>
<li>M: declare <span class="math inline">\({Y_{t}}\)</span> as
moderately long memory and form <span class="math inline">\({Y_{t}}\)</span> by <span class="math inline">\({\tilde{Y}_{t} = Y_{t} - \hat{\phi}_{1}Y_{t -1} -
\hat{\phi}_{2}Y_{t -2}}\)</span></li>
<li>S: declare <span class="math inline">\({Y_{t}}\)</span> as short
memory.</li>
</ul>
<p>If <span class="math inline">\({Y_{t}}\)</span> declared to be <span class="math inline">\(L\)</span> or <span class="math inline">\(M\)</span> then the series <span class="math inline">\({Y_{t}}\)</span> is transformed again until. The
transformation process continuous until the transformed series is
classified as short memory. However, the maximum number of
transformation process is three, it is very rare a time series require
more than 2.</p>

* 1. For each <span class="math inline">\(\tau = 1, 2, ...,
15\)</span>, we find the value <span class="math inline">\(\hat{\phi(\tau)}\)</span> of <span class="math inline">\(\hat{\phi}\)</span> that minimizes;</p>
<p><span class="math display">\[\begin{equation}
ERR(\phi, \tau) = \frac{\sum_{t=\tau +1 }^{n} [Y_{t} - \phi
Y_{t-\tau}]^2}{\sum_{t=\tau+1}^{n}Y_{t}^{2}}
\end{equation}\]</span> then define</p>
<p><span class="math inline">\(Err(\tau) = ERR(\hat{\phi(\tau),
\tau})\)</span> and choose the lag <span class="math inline">\(\hat{\tau}\)</span> to be the value of <span class="math inline">\(\tau\)</span> that minimizes <span class="math inline">\(Err(\tau)\)</span>.</p></li>
</ol></li>

* 3.  If *ϕ̂*(*τ̂*) ≥ 0.93 and *τ̂* &gt; 2, *Y*<sub>*t*</sub> is a long-memory series.
* 4.  If *ϕ̂*(*τ̂*) ≥ 0.93 and *τ̂* = 1 or 2, *Y*<sub>*t*</sub> is  long-memory series.
* 5.  If *ϕ̂*(*τ̂*) &lt; 0.93, *Y*<sub>*t*</sub> is a short-memory series.

</ol></li>
</ul>
</div>
<div id="subset-autoregressive-model" class="section level2">
<h2>Subset Autoregressive Model:</h2>
<p>In the following we will describe how ARAR algorithm fits an
autoregressive process to the mean-corrected series <span class="math inline">\(X_{t} = S_{t}- {\bar{S}}\)</span>, <span class="math inline">\(t = k+1, ..., n\)</span> where <span class="math inline">\({S_{t}, t = k + 1, ..., n}\)</span> is the
memory-shortened version of <span class="math inline">\({Y_{t}}\)</span>
which derived from the five steps we described above and <span class="math inline">\(\bar{S}\)</span> is the sample mean of <span class="math inline">\(S_{k+1}, ..., S_{n}\)</span>.</p>
<p>The fitted model has the following form:</p>
<p><span class="math inline">\(X_{t} = \phi_{1}X{t-1} +
\phi_{1}X_{t-l_{1}} + \phi_{1}X_{t- l_{1}} + \phi_{1}X_{t-l_{1}} +
Z\)</span></p>
<p>where <span class="math inline">\(Z \sim WN(0, \sigma^{2})\)</span>.
The coefficients <span class="math inline">\(\phi_{j}\)</span> and white
noise variance <span class="math inline">\(\sigma^2\)</span> can be
derived from the Yule-Walker equations for given lags <span class="math inline">\(l_1, l_2,\)</span> and <span class="math inline">\(l_3\)</span> : <span class="math display">\[\begin{equation}
\begin{bmatrix}
1 & \hat{\rho}(l_1 - 1) & \hat{\rho}(l_2 - 1) &
\hat{\rho}(l_3 - 1)\\
\hat{\rho}(l_1 - 1) &1 & \hat{\rho}(l_2 - l_1) &
\hat{\rho}(l_3 - l_1)\\
\hat{\rho}(l_2 - 1) & \hat{\rho}(l_2 - l_1) & 1 &
\hat{\rho}(l_2 - l_2)\\
\hat{\rho}(l_3 - 1) & \hat{\rho}(l_3 - l_1) & \hat{\rho}(l_3 -
l_1) & 1
\end{bmatrix}*\begin{bmatrix}
\phi_{1} \\
\phi_{l_1} \\
\phi_{l_2}\\
\phi_{l_3}
\end{bmatrix} = \begin{bmatrix} \hat{\rho}(1) \\ \hat{\rho}(l_1) \\
\hat{\rho}(l_2)\\ \hat{\rho}(l_3) \end{bmatrix}
\end{equation}\]</span></p>
<p>and <span class="math inline">\(\sigma^2 = \hat{\gamma}(0)
[1-\phi_1\hat{\rho}(1)] - \phi_{l_1}\hat{\rho}(l_1)] -
\phi_{l_2}\hat{\rho}(l_2)] - \phi_{l_3}\hat{\rho}(l_3)]\)</span>, where
<span class="math inline">\(\hat{\gamma}(j)\)</span> and <span class="math inline">\(\hat{\rho}(j), j = 0, 1, 2, ...,\)</span> are the
sample autocovariances and autocorelations of the series <span class="math inline">\(X_{t}\)</span>.</p>

The algorithm computes the coefficients of *ϕ*(*j*) for each set of lags
where
1 &lt; *l*<sub>1</sub> &lt; *l*<sub>2</sub> &lt; *l*<sub>3</sub> ≤ *m*
where m chosen to be 13 or 26. The algorithm selects the model that the
Yule-Walker estimate of *σ*<sup>2</sup> i


</div>
<div id="forecasting" class="section level2">
<h2>Forecasting</h2>
<p>If short-memory filter found in first step it has coefficients <span class="math inline">\(\Psi_0, \Psi_1, ..., \Psi_k (k \geq0)\)</span>
where <span class="math inline">\(\Psi_0 = 1\)</span>. In this case the
transforemed series can be expressed as <span class="math display">\[\begin{equation}
    S_t = \Psi(B)Y_t = Y_t + \Psi_1 Y_{t-1} + ...+ \Psi_k Y_{t-k},
\end{equation}\]</span> where <span class="math inline">\(\Psi(B) = 1 +
\Psi_1B + ...+ \Psi_k B^k\)</span> is polynomial in the back-shift
operator.</p>
<p>If the coefficients of the subset autoregression found in the second
step it has coefficients <span class="math inline">\(\phi_1, \phi_{l_1},
\phi_{l_2}\)</span> and <span class="math inline">\(\phi_{l_3}\)</span>
then the subset AR model for <span class="math inline">\(X_t = S_t -
\bar{S}\)</span> is <span class="math display">\[\begin{equation}
    \phi(B)X_t = Z_t,
\end{equation}\]</span></p>
<p>where <span class="math inline">\(Z_t\)</span> is a white-noise
series with zero mean and constant variance and <span class="math inline">\(\phi(B) = 1 - \phi_1B - \phi_{l_1}B^{l_1} -
\phi_{l_2}B^{l_2} - \phi_{l_3}B^{l_3}\)</span>. From equation (1) and
(2) one can obtain</p>
<p><span class="math display">\[\begin{equation}
    \xi(B)Y_t = \phi(1)\bar{S} + Z_t,
\end{equation}\]</span> where <span class="math inline">\(\xi (B) =
\Psi(B)\phi(B)\)</span>.</p>


<p>Assuming the fitted model in equation (3) is an appropriate model,
and <span class="math inline">\(Z_t\)</span> is uncorrelated with *Y*<sub>*j*</sub>, *j* &lt; *t*
∀*t* ∈ *T*, one can determine
minimum mean squared error linear predictors <span class="math inline">\(P_n Y_{n + h}\)</span> of <span class="math inline">\(Y_{n+h}\)</span> in terms of <span class="math inline">\({1, Y_1, ..., Y_n}\)</span> for *n* &gt; *k* + *l*, from recursions</p>
<p><span class="math display">\[\begin{equation}
    P_n Y_{n+h} = - \sum_{j = 1}^{k + l_3} \xi P_nY_{n+h-j} +
\phi(1)\bar{S},  h\geq 1,
\end{equation}\]</span> with the initial conditions <span class="math inline">\(P_n Y_{n+h} = Y_{n + h}\)</span>, for <span class="math inline">\(h\leq0\)</span>.</p>
