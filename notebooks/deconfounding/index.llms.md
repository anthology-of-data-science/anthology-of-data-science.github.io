# Deconfounding explained

A demonstration howcorrelations ‘magically’ disappear if confounders are added to your model.

Published

September 18, 2022

## Credits

The original material for this demonstration was written in R by Jeroen de Mast. His original code was ported to Python by Daniel Kapitan.

## Setting the scene

Suppose that we want to test whether \\X\\ has a causal effect on \\Y\\:

\\X \longrightarrow Y\\

And also we have 1000 \\(X, Y)\\ tuples as our data and that we want to build a regressions model.

``` python
import altair as alt
import numpy as np
import pandas as pd
import statsmodels.formula.api as smf


# setting up our experiment
np.random.sample(1973)
N = 1000
C = np.random.normal(loc=0.0, scale=1.0, size=N)
error_x = np.random.normal(loc=0.0, scale=1.0, size=N)
error_y = np.random.normal(loc=0.0, scale=0.01, size=N)
X = 10 + 5*C + error_x
Y = 1 + 0.5*C + error_y
df = pd.DataFrame({'X': X, 'Y': Y, 'C': C})
```

``` python
confounded = smf.ols("Y ~ X", data=df).fit()
confounded.summary()
```

|                   |                  |                     |           |
|-------------------|------------------|---------------------|-----------|
| Dep. Variable:    | Y                | R-squared:          | 0.960     |
| Model:            | OLS              | Adj. R-squared:     | 0.960     |
| Method:           | Least Squares    | F-statistic:        | 2.385e+04 |
| Date:             | Thu, 21 Dec 2023 | Prob (F-statistic): | 0.00      |
| Time:             | 23:47:40         | Log-Likelihood:     | 854.10    |
| No. Observations: | 1000             | AIC:                | -1704.    |
| Df Residuals:     | 998              | BIC:                | -1694.    |
| Df Model:         | 1                |                     |           |
| Covariance Type:  | nonrobust        |                     |           |

OLS Regression Results {.simpletable .caption-top .table .table-sm .table-striped .small}

|           |        |         |         |          |         |         |
|-----------|--------|---------|---------|----------|---------|---------|
|           | coef   | std err | t       | P\>\|t\| | \[0.025 | 0.975\] |
| Intercept | 0.0446 | 0.007   | 6.389   | 0.000    | 0.031   | 0.058   |
| X         | 0.0958 | 0.001   | 154.420 | 0.000    | 0.095   | 0.097   |

|                |       |                   |       |
|----------------|-------|-------------------|-------|
| Omnibus:       | 1.331 | Durbin-Watson:    | 1.855 |
| Prob(Omnibus): | 0.514 | Jarque-Bera (JB): | 1.406 |
| Skew:          | 0.080 | Prob(JB):         | 0.495 |
| Kurtosis:      | 2.911 | Cond. No.         | 24.2  |

  
  
Notes:  
\[1\] Standard Errors assume that the covariance matrix of the errors is correctly specified.

So our first (confounded) model yields a result that \\Y = 0.03 + 0.1X\\. Note there can be small differences each time you re-run this notebook. But most importantly the fitted model has a high \\R^2 = 0.95\\ and high significance \\p = 0.0\\!

However, if you look closely at the Python code, you see that the real model has a confounder \\C\\:

\\C \longrightarrow X\\ \\C \longrightarrow Y\\

In other words, X and Y are both causally affected by C. As a consequence, X and Y are correlated, but they do not causally affect each other. So, the regression analysis above is actually wrong, and the correlation between X and Y is called *spurious*. C is called a confounder.

Now here is the great deconfounding trick: suppose that we include both X and C in the regression analysis and fit the following modelL

\\ Y = \beta_0 + \beta_1 X + \beta_2 C + ϵ\\

``` python
deconfounded = smf.ols("Y ~ X + C", data=df).fit()
deconfounded.summary()
```

|                   |                  |                     |           |
|-------------------|------------------|---------------------|-----------|
| Dep. Variable:    | Y                | R-squared:          | 1.000     |
| Model:            | OLS              | Adj. R-squared:     | 1.000     |
| Method:           | Least Squares    | F-statistic:        | 1.261e+06 |
| Date:             | Thu, 21 Dec 2023 | Prob (F-statistic): | 0.00      |
| Time:             | 23:47:40         | Log-Likelihood:     | 3164.9    |
| No. Observations: | 1000             | AIC:                | -6324.    |
| Df Residuals:     | 997              | BIC:                | -6309.    |
| Df Model:         | 2                |                     |           |
| Covariance Type:  | nonrobust        |                     |           |

OLS Regression Results {.simpletable .caption-top .table .table-sm .table-striped .small}

|           |         |         |         |          |         |          |
|-----------|---------|---------|---------|----------|---------|----------|
|           | coef    | std err | t       | P\>\|t\| | \[0.025 | 0.975\]  |
| Intercept | 1.0055  | 0.003   | 323.164 | 0.000    | 0.999   | 1.012    |
| X         | -0.0005 | 0.000   | -1.671  | 0.095    | -0.001  | 9.05e-05 |
| C         | 0.5023  | 0.002   | 316.780 | 0.000    | 0.499   | 0.505    |

|                |        |                   |       |
|----------------|--------|-------------------|-------|
| Omnibus:       | 2.983  | Durbin-Watson:    | 2.042 |
| Prob(Omnibus): | 0.225  | Jarque-Bera (JB): | 3.073 |
| Skew:          | -0.063 | Prob(JB):         | 0.215 |
| Kurtosis:      | 3.240  | Cond. No.         | 122\. |

  
  
Notes:  
\[1\] Standard Errors assume that the covariance matrix of the errors is correctly specified.

Note that, by including \\C\\ as an independent variable in the regression analysis, suddenly X has stopped being significant (p=0.36)!

This holds in general: if the true causal relationships are as given in the second diagram, then including the confounder C in the regression analysis gives the direct effect of X onto Y (if any such direct effect exists), and the part of the correlation that is induced by the confounder C is now entirely attributed to C and not to X. This approach is called “deconfounding”.
