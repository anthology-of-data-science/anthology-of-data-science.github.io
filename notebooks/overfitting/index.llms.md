# Demonstration of overfitting and underfitting

This notebook illustrates why we require a train/test split (or cross-validation) to balance overfitting vs. underfitting.

Authors

Daniel Kapitan

Pieter Overdevest

Published

May 1, 2023

``` python
import altair as alt
import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.preprocessing import PolynomialFeatures
```

## Python explainer - How does the ‘PolynomialFeatures()’ function work?

In this notebook, we use the [PolynomialFeatures](https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.PolynomialFeatures.html) function from `sklearn`, which generates n-th order polynomial features, expanding a given X matrix. Depending on the value assigned to the parameter `interaction_only`, the features include all main terms and interaction terms (False; default), or only the first order main terms and the interaction term only (True). So, for example `PolynomialFeatures(degree = 2)` generates a matrix with a column for each term in the following equation:

\\1 + X_1 + X_2 + X_3 + X_1^2 + X_2^2 + X_3^2 + X_1X_2 + X_1X_3 + X_2X3.\\

Note, the default value for `degree` is 2. Below, we demonstrate the workings of `PolynomialFeatures()` for a simple dummy matrix.

``` python
# Create a dummy X matrix (3x3).
X = np.arange(9).reshape(3, 3)

print("X matrix:")
print(X)
print("")

# Expanded matrix containing the first order main features and the interaction features. 
poly = PolynomialFeatures(degree = 2, interaction_only=True)
print("Expanded X matrix with first order and interaction features:")
print(poly.fit_transform(X))
print("")

# Expanded matrix containing the first and second order main features and the interaction features.
poly = PolynomialFeatures(degree = 2, interaction_only=False)
print("Expanded X matrix with first and second order and interaction features:")
print(poly.fit_transform(X))
```

    X matrix:
    [[0 1 2]
     [3 4 5]
     [6 7 8]]

    Expanded X matrix with first order and interaction features:
    [[ 1.  0.  1.  2.  0.  0.  2.]
     [ 1.  3.  4.  5. 12. 15. 20.]
     [ 1.  6.  7.  8. 42. 48. 56.]]

    Expanded X matrix with first and second order and interaction features:
    [[ 1.  0.  1.  2.  0.  0.  0.  1.  2.  4.]
     [ 1.  3.  4.  5.  9. 12. 15. 16. 20. 25.]
     [ 1.  6.  7.  8. 36. 42. 48. 49. 56. 64.]]

We observe that when we set `interaction_only` to False, we also get the quadratic main terms. In addition, we also observe that the first column is filled with ones. Why is that?

## Initialize objects

``` python
# Maximum number of degrees in polynomial.
MAX_DEGREE = 20
```

## Define functions

We define a number of functions that are used in this notebook down below: (1) Create and evaluate models for different levels of flexibility. (2) Plot fitted data. (3a) Plot RMSE - Evaluate model based full data set (3b) Plot RMSE - Evaluate model based on train and test set

Function descriptions were added using [docstring](https://realpython.com/documenting-python-code/#documenting-your-python-code-base-using-docstrings) in [Numpy format](https://numpydoc.readthedocs.io/en/latest/format.html#docstring-standard). In case you want an explanation about a function, simply type help(*function name*) and you will get to see the description.

### 1 - Create and evaluate models for different levels of flexibility

``` python
def f_create_and_evaluate_model(df_data, b_split):

    """Creates and_evaluates models for different degrees of flexibility.

    Parameters
    ----------
    df_data : dataframe
        Dataframe with attribute 'Y' in the first column and X features in the second column and onwards (if applicable).
    b_split : bool
        Should the models be based on the full data set (b_split = False) or on a train/test split (b_split = True).

    Returns
    -------
    dataframe
        a dataframe with features, including: degree, RMSE, and predictions.
    """  

    # Initialize.
    results = []

    if b_split:
        X_train, X_val, y_train, y_val = train_test_split(df_data.iloc[:, 1:], df_data.Y, test_size = 0.2, random_state = 42)

    # Go through each degree of freedom from 1 to MAX_DEGREE and fit each polynomial to X features. 
    for n in range(1, MAX_DEGREE + 1):
        
        # Create object with framework for MAX_DEGREE polynomials.
        poly = PolynomialFeatures(n, interaction_only=False)

        # Apply X features to each of the MAX_DEGREE polynomials.
        Xp_all = poly.fit_transform(df_data.iloc[:, 1:])

        if not b_split:

            # Fit MAX_DEGREE polynomials to the same response 'Y'.
            fit = LinearRegression().fit(Xp_all, df_data.Y)

            # Use fit object to calculate predicted 'Y' for all X's.
            Y_hat_all = fit.predict(Xp_all)

            # Append performance metrics to results list.
            results.append(
                {
                    "degree":  n,
                    "rmse":    round(np.sqrt(mean_squared_error(df_data.Y, Y_hat_all))),
                    "X_hat":   Xp_all[:,1],
                    "Y_hat":   Y_hat_all
                }
            )

        else:

            # Apply X_train to each of the MAX_DEGREE polynomials.
            Xp_train = poly.fit_transform(X_train)

            # Apply X_val to each of the MAX_DEGREE polynomials.
            Xp_val = poly.fit_transform(X_val)

            # Fit the training data to y_train.
            fit = LinearRegression().fit(Xp_train, y_train)

            # Use fit object to calculate predicted Y for training set.
            Y_hat_train = fit.predict(Xp_train)

            # Use fit object to calculate predicted Y for test set.
            Y_hat_val = fit.predict(Xp_val)

            # Use fit object to calculate predicted 'Y' for full set.
            Y_hat_all = fit.predict(Xp_all)

            # Extend with list of performance metrics to results list, 'results'.
            results.extend(
                [
                    {
                        "degree": n,
                        "fold":   "train",
                        "rmse":   np.sqrt(mean_squared_error(y_train, Y_hat_train)),
                        "X_hat":  Xp_train[:,1],
                        "Y_hat":  Y_hat_train
                    },

                    {
                        "degree": n,
                        "fold":   "test",
                        "rmse":   np.sqrt(mean_squared_error(y_val, Y_hat_val)),
                        "X_hat":  Xp_val[:,1],
                        "Y_hat":  Y_hat_val
                    },

                    {
                        "degree": n,
                        "fold":   "full_set",
                        "X_hat":  Xp_all[:,1],
                        "Y_hat":  Y_hat_all,
                        
                    },
                ]
            )

    # Convert list to data frame.
    df_results = pd.DataFrame.from_records(results)

    return df_results
```

### 2 - Plot fitted data

``` python
def f_plot_data_and_two_models(df_data, df_results, n_i, n_ii, b_split):

    """Make a plot of data and of two selected fitted models.

    Parameters
    ----------
    df_data : dataframe
        Dataframe with attribute 'Y' in the first column and X features in the second column and onwards (if applicable).
    df_results : dataframe
        Dataframe with results from f_create_and_evaluate_model().
    n_i : int
        Degrees of flexibility (polynomial order) you want to plot predict model for (first model).
    n_ii : int
        Degrees of flexibility (polynomial order) you want to plot predict model for (second model).
    b_split : bool
        Should the models be based on the full data set (b_split = False) or on a train/test split (b_split = True).

    Returns
    -------
    plot
        a plot of the data with two predicted models.
    """

    # In case of the full data set each row in df_result is an iteration.
    # In case of a train/test split each three rows in df_result constitute an iteration.
    if b_split:

        index_X_hat    = 2
        index_Y_hat_i  = (n_i  - 1) * 3 + 2
        index_Y_hat_ii = (n_ii - 1) * 3 + 2
    
    else:

        index_X_hat    = 0
        index_Y_hat_i  = n_i  - 1
        index_Y_hat_ii = n_ii - 1


    # Define plot results data frame.
    df_plot_results = pd.DataFrame({
        
        "X_hat":    df_results.loc[index_X_hat,    "X_hat"],  
        "Y_hat_i":  df_results.loc[index_Y_hat_i,  "Y_hat"],
        "Y_hat_ii": df_results.loc[index_Y_hat_ii, "Y_hat"]
    })


    # POINTS: Plot point markers
    plot_data = alt.Chart(df_data).mark_point(color = "grey").encode(x = "X1", y = "Y")

    # LINES: Plot first fitted model
    plot_n_i = alt.Chart(df_plot_results).mark_line(color = "blue").encode(x = "X_hat", y = "Y_hat_i")

    plot_n_ii = alt.Chart(df_plot_results).mark_line(color = "green").encode(x = "X_hat", y = "Y_hat_ii")

    # Simply layer the three plots into one.
    return plot_data + plot_n_i + plot_n_ii
```

### 3 - Plot RMSE

Create a plot of the RMSE against the flexibility of the model (degrees of freedom).

#### 3a - Plot RMSE - Evaluate model based full data set

``` python
def f_plot_rmse_full_dataset(df_results):

    """Make a plot of RMSE against the flexibility of the model (degrees of freedom)
    in case of evaluating the model based on the full data set.

    Parameters
    ----------
    df_results : dataframe
        Dataframe with results from f_create_and_evaluate_model().

    Returns
    -------
    plot
        a plot of the RMSE.
    """
    
    return alt.Chart(df_results).mark_line(point = alt.OverlayMarkDef()).encode(x = "degree", y = "rmse", tooltip = ["degree", "rmse"])
```

#### 3b - Plot RMSE - Evaluate model based on train and test set

``` python
# Define function to plot performance metric (RMSE)
def f_plot_rmse_train_test_set(df_results):

    """Make a plot of RMSE against the flexibility of the model (degrees of freedom)
    in case of evaluating the model based on the train/test set.

    Parameters
    ----------
    df_results : dataframe
        Dataframe with results from f_create_and_evaluate_model().

    Returns
    -------
    plot
        a plot of the RMSE.
    """

    # Remove full_set data, leaving only the train and test data.
    df_results = df_results[df_results.fold != "full_set"]

    # Define base line chart.
    base = alt.Chart(df_results).mark_line(
            
            point=alt.OverlayMarkDef()

        ).encode(x = "degree",y = "rmse", color = "fold"
    )

    label = alt.selection_point(

        encodings = ['x'],       # Limit selection to x-axis value
        on        = 'mouseover', # Select on mouseover events
        nearest   = True,        # Select data point nearest to the cursor
        empty     = 'none'       # Empty selection includes no data points
    )

    return alt.layer(

        # Base line chart.
        base, 
        
        ######################################################################################
        #
        # I '#'-ed the definition of label.  I think the 
        ######################################################################################
        
        # Add a rule mark to serve as a guide line
        alt.Chart().mark_rule(color = '#aaa').encode(x = 'degree').transform_filter(label),
        
        # Add circle marks for selected time points, hide unselected points
        base.mark_circle().encode(
            
            opacity = alt.condition(label, alt.value(1), alt.value(0))

        ).add_params(label),

        # Add white stroked text to provide a legible background for labels
        base.mark_text(
            align       = 'left',
            dx          = 5,
            dy          = -5,
            stroke      = 'white',
            strokeWidth = 2
        ).encode(text='rmse:Q').transform_filter(label),

        # Add text labels for stock prices.
        base.mark_text(
            align = 'left',
            dx    = 5,
            dy    = -5
        ).encode(text='rmse:Q').transform_filter(label),
        
        data = df_results
    )
```

## Section 1 - Overfitting

We simulate a true function \\Y\\ as a third-order polynomial of \\X1\\. We show that the error of the fitted function decreases as you increase the complexity of the fitted functions, i.e. fitting polynomials with degree \> 3.

``` python
# Number of data
n_data = 50

# We set a fixed random seed to reproduce our results below. In which cases would we not want to set a fixed seed?
np.random.seed(123)

# Define X, error, and model including error.
x = np.sort(np.random.normal(loc = 10, scale = 5, size = n_data))
e = np.random.normal(loc = 0, scale = 2000, size = n_data)
y = (2530 + 20*x - 10*(x**2) + 5*(x**3) + e)

# Combine X1 and Y in a data frame.
df_data1 = pd.DataFrame({"Y": y, "X1": x})

# Create and evaluate models of various flexibility.
df_results1 = f_create_and_evaluate_model(df_data = df_data1, b_split = False)
```

``` python
# Plot data and two fitted models. Select fitted models by updating 'n_i' and 'n_ii'.
f_plot_data_and_two_models(df_data = df_data1, df_results = df_results1, n_i = 1, n_ii = 4, b_split = False)
```

``` python
# Plot RMSE against model flexibility.
f_plot_rmse_full_dataset(df_results = df_results1)
```

We observe that the RMSE increaes again at degree \> 16. This is due to the function becoming overly flexible that it starts missing (overshooting) data points.

**Question** - Why does the error not drop below 2000 up to 20 degrees of freedom?

## Section 2 - Overfitting with random variables

We now add features \\X2, X3\\ but keep the true function \\Y\\ unchanged, i.e. only dependent on \\X1\\. We show that these random variables may lead to even more severe overfitting.

``` python
# Make a copy of df_data1.
df_data2 = df_data1.copy()

# Add two more features, X2 and X3. Response variable Y is independent of X2 and X3.
for i in [2, 3]:

    df_data2[f"X{str(i)}"] = np.random.normal(loc = 10, scale = 5, size = n_data)

# Create and evaluate models of various flexibility.
df_results2 = f_create_and_evaluate_model(df_data = df_data2, b_split = False)
```

``` python
# Plot data and two fitted models. Select fitted models by updating 'n_i' and 'n_ii'.
f_plot_data_and_two_models(df_data = df_data2, df_results = df_results2, n_i = 1, n_ii = 2, b_split = False)
```

``` python
# Plot RMSE against model flexibility.
f_plot_rmse_full_dataset(df_results2)
```

With additional features we need fewer degrees of freedom in the polynomial. The additional features result in more flexibility in the model.

## Section 3 - Testing to prevent overfitting

We follow [example from sklearn library](https://scikit-learn.org/stable/auto_examples/model_selection/plot_underfitting_overfitting.html#sphx-glr-auto-examples-model-selection-plot-underfitting-overfitting-py), with cosine as true function.

``` python
# Define function with the true model.
def true_fun(x, e):
    return np.cos(1.5 * np.pi * x) + e

# We set a fixed random seed to reproduce our results below. In which cases would we not want to set a fixed seed?
np.random.seed(12)

# Number of data.
n_data = 50

# Define X, error, and model including error.
x = np.sort(np.random.rand(n_data))
e = np.random.randn(n_data) * 0.1
y = true_fun(x, e)

# Put data in data frame.
df_data3 = pd.DataFrame({"Y": y, "X1": x})

# Create and evaluate models of various flexibility.
df_results3 = f_create_and_evaluate_model(df_data = df_data3, b_split = True)
```

``` python
# Plot data and two fitted models. Select fitted models by updating 'n_i' and 'n_ii'.
# The plot shows all data (train + test), while the models are fitted on the training data.
# Try out different n_ii: start at 16 and increase with steps of 1. What do we see?
f_plot_data_and_two_models(df_data = df_data3, df_results = df_results3, n_i = 1, n_ii = 5, b_split = True)
```

``` python
# Plot RMSE against model flexibility.
f_plot_rmse_train_test_set(df_results3)
```

    /Users/macstudio/opt/anaconda3/envs/py310/lib/python3.10/site-packages/altair/vegalite/v5/api.py:355: AltairDeprecationWarning: The value of 'empty' should be True or False.
      warnings.warn(

## Section 4 - Train/test split can still lead to overfitting

Train/test split isn’t a 100% safe-guard against overfitting. Given a quadratic (second order) true function, testing still results in a fourth order fitted function.

``` python
# Set random seed, to reproduce results.
np.random.seed(456)

# Number of data.
n_data = 150

# Define X, error, and model including error.
x = np.random.normal(-10, 6, n_data)
e = np.random.normal(0, 75, n_data)
y = 25 + 2*x - 4*(x**2) + e

# Bring X and y together in a data frame.
df_data4 = pd.DataFrame({"Y": y, "X1": x})

# Create and evaluate models of various flexibility.
df_results4 = f_create_and_evaluate_model(df_data = df_data4, b_split = True)
```

``` python
# Plot data and two fitted models. Select fitted models by updating 'n_i' and 'n_ii'.
# The plot shows all data (train + test), while the models are fitted on the training data.
f_plot_data_and_two_models(df_data = df_data4, df_results = df_results4, n_i = 1, n_ii = 2, b_split = True)
```

``` python
# Plot RMSE against model flexibility.
f_plot_rmse_train_test_set(df_results4)
```

    /Users/macstudio/opt/anaconda3/envs/py310/lib/python3.10/site-packages/altair/vegalite/v5/api.py:355: AltairDeprecationWarning: The value of 'empty' should be True or False.
      warnings.warn(

## Cross-validation - Work in Progress

By using k-fold cross-validation, we have a better safeguard against overfitting. We reproduce the [example from Will Koehrsen](https://github.com/WillKoehrsen/Data-Analysis/blob/master/over_vs_under/Over%20vs%20Under%20Fitting%20Example.ipynb).

NB: WORK IN PROGRESS. Example is not the best in terms of train-validation curves.

``` python
# def fit_poly(train, y_train, test, y_test, degrees, plot='train', return_scores=False):
    
#     # Create a polynomial transformation of features
#     features = PolynomialFeatures(degree=degrees, include_bias=False)
    
#     # Reshape training features for use in scikit-learn and transform features
#     train = train.reshape((-1, 1))
#     train_trans = features.fit_transform(train)
    
#     # Create the linear regression model and train
#     model = LinearRegression()
#     model.fit(train_trans, y_train)
    
#     # Calculate the cross validation score
#     cross_valid = cross_val_score(model, train_trans, y_train, scoring='neg_mean_squared_error', cv = 5)
    
#     # Training predictions and error
#     train_predictions = model.predict(train_trans)
#     training_error    = mean_squared_error(y_train, train_predictions)
    
#     # Format test features
#     test = test.reshape((-1, 1))
#     test_trans = features.fit_transform(test)
    
#     # Test set predictions and error
#     test_predictions = model.predict(test_trans)
#     testing_error = mean_squared_error(y_test, test_predictions)
    
#     # Find the model curve and the true curve
#     x_curve = np.linspace(0, 1, 100)
#     x_curve = x_curve.reshape((-1, 1))
#     x_curve_trans = features.fit_transform(x_curve)
    
#     # Model curve
#     model_curve = model.predict(x_curve_trans)
    
#     # True curve
#     y_true_curve = true_fun(x_curve[:, 0])

#      # Return the metrics
#     if return_scores:
#         return training_error, testing_error, -np.mean(cross_valid)
```

``` python
# x = np.sort(np.random.rand(120))
# y = true_fun(x) + 0.1 * np.random.randn(len(x))

# # Random indices for creating training and testing sets
# random_ind = np.random.choice(list(range(120)), size = 120, replace=False)
# xt = x[random_ind]
# yt = y[random_ind]

# # Training and testing observations
# train = xt[:int(0.7 * len(x))]
# test = xt[int(0.7 * len(x)):]

# y_train = yt[:int(0.7 * len(y))]
# y_test = yt[int(0.7 * len(y)):]

# # Model the true curve
# x_linspace = np.linspace(0, 1, 1000)
# y_true = true_fun(x_linspace)

# # Range of model degrees to evaluate
# degrees = [int(x) for x in np.linspace(1, 40, 40)]

# # Results dataframe
# results5 = pd.DataFrame(0, columns = ['train_error', 'test_error', 'cross_valid'], index = degrees)

# # Try each value of degrees for the model and record results
# for degree in degrees:
#     degree_results = fit_poly(train, y_train, test, y_test, degree, plot=False, return_scores=True)
#     results5.loc[degree, 'train_error'] = degree_results[0]
#     results5.loc[degree, 'test_error'] = degree_results[1]
#     results5.loc[degree, 'cross_valid'] = degree_results[2]

# # print('10 Lowest Cross Validation Errors\n')
# # train_eval = results5.sort_values('cross_valid').reset_index(level=0).rename(columns={'index': 'degrees'})
# # train_eval.loc[:,['degrees', 'cross_valid']].head(10)
```

``` python
# import matplotlib.pyplot as plt

# plt.plot(results5.index, results5['train_error'], 'b-o', ms=6, label = 'Training Error')
# plt.plot(results5.index, results5['test_error'], 'r-*', ms=6, label = 'Testing Error')
# plt.legend(loc=2); plt.xlabel('Degrees'); plt.ylabel('Mean Squared Error'); plt.title('Training and Testing Curves');
# plt.ylim(0, 0.05); plt.show()

# print('\nMinimum Training Error occurs at {} degrees.'.format(int(np.argmin(results5['train_error']))))
# print('Minimum Testing Error occurs at {} degrees.\n'.format(int(np.argmin(results5['test_error']))))
```
