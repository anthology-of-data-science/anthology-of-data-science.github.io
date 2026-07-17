# Explainable Boosting Machines

Slides from a 1-hour workshop, after which you will be convinced that EBMs are your standard go-to algorithm for tabular data.

Author

Daniel Kapitan

Published

September 9, 2024

# Generalized Additive Models and Explainable Boosting Machines

Your standard algorithm for tabular data?

Dr Daniel Kapitan [![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo1N0NEMjA4MDI1MjA2ODExOTk0QzkzNTEzRjZEQTg1NyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDozM0NDOEJGNEZGNTcxMUUxODdBOEVCODg2RjdCQ0QwOSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozM0NDOEJGM0ZGNTcxMUUxODdBOEVCODg2RjdCQ0QwOSIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1IE1hY2ludG9zaCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkZDN0YxMTc0MDcyMDY4MTE5NUZFRDc5MUM2MUUwNEREIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjU3Q0QyMDgwMjUyMDY4MTE5OTRDOTM1MTNGNkRBODU3Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+84NovQAAAR1JREFUeNpiZEADy85ZJgCpeCB2QJM6AMQLo4yOL0AWZETSqACk1gOxAQN+cAGIA4EGPQBxmJA0nwdpjjQ8xqArmczw5tMHXAaALDgP1QMxAGqzAAPxQACqh4ER6uf5MBlkm0X4EGayMfMw/Pr7Bd2gRBZogMFBrv01hisv5jLsv9nLAPIOMnjy8RDDyYctyAbFM2EJbRQw+aAWw/LzVgx7b+cwCHKqMhjJFCBLOzAR6+lXX84xnHjYyqAo5IUizkRCwIENQQckGSDGY4TVgAPEaraQr2a4/24bSuoExcJCfAEJihXkWDj3ZAKy9EJGaEo8T0QSxkjSwORsCAuDQCD+QILmD1A9kECEZgxDaEZhICIzGcIyEyOl2RkgwAAhkmC+eAm0TAAAAABJRU5ErkJggg==)](https://orcid.org/0000-0001-8979-9194)

<daniel@kapitan.net>

Eindhoven AI Systems Institute

September 10, 2024

## Attribution & copyright notice

  

This lecture is based on the following open access materials:

- James et al., [Introduction to Statistical Learning with Python (ISLP), chapter 7](https://www.statlearning.com/)
- Rich Caruana, [InterpretML: Explainable Boosting Machines (EBMs)](https://people.orie.cornell.edu/mru8/orie4741/lectures/Tutorial4MadeleineUdellClass_2020Dec08_RichCaruana_IntelligibleMLInterpretML_EBMs_75mins.pdf)

Source code: <https://github.com/anthology-of-data-science/lecture-gam-ebm>  

Daniel Kapitan, *Generalized Additive Models and Explainable Boosting Machines.*  
This work is licensed under [CC BY-SA 4.0![](https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1)![](https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1)![](https://mirrors.creativecommons.org/presskit/icons/sa.svg?ref=chooser-v1)](https://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1)

## Why this lecture?

Source: Adaptation of ISLP, figure 2.7

## Learning objectives: moving beyond linearity

  

### Generalized Additive Models

- Know how to use additive models with a single feature
  - polynomial regression
  - regression splines
  - smoothing splines
- Know how to use generalized additive models with multiple features
  - for regression
  - for classification

### Explainable Boosting Machines

- Know how to use Explainable Boosting Machines by
  - training smoothed splines
  - correcting the learned splines
  - interpreting EBMs
- Reflect on usefulness of EBMs for high-risk applications

# Generalized Additive Models

## Moving beyond linearity

  

### From linear regression

\\ y\_{i} = \beta\_{0} + \beta\_{1} x\_{i} + \epsilon\_{i} \\

  

### From logistic regression

\\\begin{align} p(x)& = \frac{e^{y\_{i}}}{1 + e^{y\_{i}}}\\ \log \left( {\frac{p(x)}{1 - p(x)}} \right) & = \beta\_{0} + \beta\_{1} x\_{i} + \epsilon\_{i} \end{align}\\

### … to polynomial regression

\\ y\_{i} = \beta\_{0} + \beta\_{1} x\_{i} + \beta\_{2} x\_{i}^{2} + \beta\_{3} x\_{i}^{3} + \ldots +\epsilon\_{i} \\  

### … to logistic polynomial regression

\\\begin{align} p(x)& = \frac{e^{y\_{i}}}{1 + e^{y\_{i}}}\\ \log\left({\frac{p(x)}{1 - p(x)}}\right)& = \beta\_{0} + \beta\_{1} x\_{i} + \beta\_{2} x\_{i}^{2} + \beta\_{3} x\_{i}^{3} + \ldots +\epsilon\_{i} \end{align}\\

## Polynomial regression

  

### Generalization of linear regression

- Use ordinary least squares for estimating coefficients
- Unusual for d \> 3 or 4, because curve becomes too flexible
- Classification usually uses logit or log-odds formula

  

### Concept of basis functions

- Polynomials are an example of basis functions
- Fourier basis is other commonly used basis function (sin, cos) for periodic functions

## Example: `Wage` data

Source: ISLP, figure 7.1

## Regression splines

### Not as many extra degrees of freedom as you may think

Source: ISLP, figure 7.3

**Piecewise cubic**: 2 x 4 coefficients  
–\> 8 degrees of freedom (DoF)

  

**Continuous cubic (no gaps)**: one extra constraint –\> 7 DoF

  

**Cubic spline**: require 1st and 2nd derivative to be continuous –\> two extra constraints –\> 5 DoF

## Smoothing splines

### Determine set of knots with regularization

  

\\ {\color{green}\sum^{n}\_{i=1} {\left(y\_{i} - g(x\_{i}) \right)}^{2}} + {\color{#ff4f5e} \lambda \int g''(t)^{2}dt} \\

  

Same principle as Lasso and Ridge regression: \\{\color{green} loss} + {\color{#ff4f5e} penalty}\\

- Low \\\color{#ff4f5e}\lambda\\: low penalty for ‘wildly oscillating’ function \\g(x)\\
- High \\\color{#ff4f5e}\lambda\\: high penalty forces \\g(x)\\ to become smoother (hence the name)
- Selection of \\\color{#ff4f5e}\lambda\\ done with cross validation (usually LOOCV)

## Smooting splines

### Example: tricep skinfold thickness as a function of age

Source: [Biostatistics Collaboration of Australia](https://bookdown.org/tpinto_home/Beyond-Linearity/smoothing-splines.html).

## Generalized additive models with multiple features

  

### From multiple linear regression:

\\ y\_{i} = \beta\_{0} + \beta\_{1} x\_{i1} + \beta\_{2} x\_{i2} + \ldots + \beta\_{p} x\_{ip} ++ \epsilon\_{i} \\

### … to GAMs

\\\begin{align} y\_{i} &= \beta\_{0} + f\_{1}(x\_{i1}) + f\_{2}(x\_{i2}) + \ldots + f\_{p}(x\_{ip}) + \epsilon\_{i} \\ y\_{i} &= \beta\_{0} + \sum^{p}\_{j=1} f(x\_{ij}) + \epsilon\_{i} \end{align}\\

- **Generalized**: for each function \\f_j\\ you can choose which (non-)linear basis function you want to use
- **Additive**: we assume we can add contributions of each separate \\f_j\\

## GAM for `Wage` data

### Regression using natural splines

\\wage = \beta_0 + f_1(year) + f_2(age) + f_3(education)\\

\\f_1\\: four degrees of freedom, \\f_2\\: five degrees of freedom

Source: ISLP, figure 7.11.

## GAM for `Wage` data

### Regression using smoothing splines

\\wage = \beta_0 + f_1(year) + f_2(age) + f_3(education)\\

\\f_1\\: four degrees of freedom, \\f_2\\: five degrees of freedom

Source: ISLP, figure 7.12.

## GAM for `Wage` data

### Probability of earning more than 250 thousand dollars per year

\\\log\left({{p(x)}/{1 - p(x)}}\right) = \beta_0 + beta_1 \times year + f_2(age) + f_3(education)\\

\\f_2\\: five degrees of freedom

Source: ISLP, figure 7.12.

## Pros and Cons of GAMS

\\\color{green}\bigtriangleup\\ You can fit a non-linear \\f_j\\ to each \\X_j\\, so we can automatically model such relationships (no need for manual transformation)

\\\color{green}\bigtriangleup\\ Using non-linear functions potentially results in more accurate predictions

\\\color{green}\bigtriangleup\\ Because model is additive, you can examine effect of each feature \\X_j\\ on response \\Y\\ individually

\\\color{green}\bigtriangleup\\ Smoothness of functions can be summarized via degrees of freedom

\\\color{orange}\bigtriangledown\\ Additive model may be too restrictive, doesn’t include interactions

\\\color{orange}\bigtriangledown\\ Can be computationally expensive for many features

# Explainable Boosting Machines

## Remember how gradient boosting works?

Source: [Python Geeks](https://pythongeeks.org/gradient-boosting-algorithm-in-machine-learning/)

## Generalized additive models with pairwise interactions (\\GA^{2}M\\)

### Microsoft Research implemented it and branded it as EBM

\\ g(E\[y\]) = \beta_0 + {\color{#00458b} \sum f_i(x\_{i})} + {\color{#6e008b} \sum f\_{ij}(x\_{ij})} \\

\\g(E\[y\]):\\  
  
link function, identity for regression, logit for logistic regression

\\{\color{#00458b} \sum f_i(x\_{i})}:\\  
  
GAM, but now using shallow trees as basis function

\\{\color{#6e008b} \sum f\_{ij}(x\_{i})}:\\  
  
pairwise interactions

- Combines different ideas into single model ([Lou et al. (2019)](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/06/kdd13.pdf))
  - Fast detection of pairwise interactions
  - Uses gradient boosted trees, training one feature at a time
  - Cycles features with each iteration to mitigate effect of co-linearity
- Implemented in [InterpretML](https://github.com/interpretml/interpret/)

## Intuition how EBM algorithm works

## Intuition how EBM algorithm works (intermediate result)

## Fast detection of pairwise interactions

### [Lou et al. (2013)](./resources/lou2013accurate.pdf)

Searching cuts on input space of \\x_i\\ and \\x_j\\. On the left we show a heat map on the target for different values of \\x_i\\ and \\x_j\\. \\c_i\\ and \\c_j\\ are cuts for \\x_i\\ and \\x_j\\, respectively. On the right we show an extremely simple predictor of modeling pairwise interaction.

## Intuition how EBM algorithm works (final result)

## Performance of EBM on some datasets

### [Chang et al. (2020)](./resources/chang2020how.pdf)

Test set AUCs (%) across ten datasets average over five runs. Best number in each row is in bold.

# Example: predicting pneumonia mortality risk

## The Pneumonia Data with 46 features

### [Cooper et al. (1997)](./resources/cooper1997evaluation.pdf)

The dataset contains 14,199 cases of pneumonia collected from 78 hospitals between July 1987 and December 1988.

## Using EBMs to detect common flaws in data

### [Chen et al. (2021)](./resources/chang2020how.pdf)

  

1.  EBM shape function graphs can be helpful in identifying various types of dataset flaws.
2.  In many cases, users with domain expertise are needed to examine what the model has learned.
3.  In some cases, EBMs provide simple tools for correcting problems in the models, when correcting the data is not feasible or too difficult.

## Missing values assumed normal

### [Chen et al. (2021)](./resources/chang2020how.pdf)

  

EBM shape function of “heart rate” for predicting pneumonia mortality risk. Left: missing values result in unrealistic high risk score. Right: corrected risk score.

## Correction for confounders and treatment effects

### [Chen et al. (2021)](./resources/chang2020how.pdf)

  

Left: confounder of retirement at age 67, resulting in sharp increase of risk. Social effect of doctors trying harder to cure centenarians results in lower risk. Right: patients who have a history of asthma have lower pneumonia mortality risk than general population, since they admitted directly into ICU and get more aggressive care, thereby lowering their risk of death.

## Discovering new protocols?

### [Chen et al. (2021)](./resources/chang2020how.pdf)

  

Left: patients get treated when blood urea nitrogent reaches ~50. When BUN goes over 100, dialysis is given. Right: patients in ICU get treated at systolic blood pressures (SBP) of 175, 200 and 255.

## Discovering new protocols?

### [Chen et al. (2021)](./resources/chang2020how.pdf)

  

Left: possible improvement by moving dialysis treatment to 80. Rightpatients get treated when blood urea nitrogent reaches ~50. When BUN goes over 100, dialysis is given. Right: adjust “inappropriate” treatment thresholds with flattend red lines.

## Where to go from here?

### Try it yourself

  

- Work through one of the examples on [InterpreML](https://interpret.ml/docs/python/examples/interpretable-classification.html)
- Reproduce the results from [Chang et al. (2020)](./resources/chang2020how.pdf) with the
  - [Adult census income dataset](https://archive.ics.uci.edu/dataset/2/adult)
  - [COMPAS Recividism dataset](https://www.kaggle.com/datasets/danofer/compass)
- Read the paper by [Nori et al. (2021)](./resources/nori21accuracy.pdf) how EBMs can be combined with differential privacy (DP) to achieve state-of-the-art accuracy whilst preserving privacy

## Thanks for your attention.

<https://anthology-of-data.science>

(view [full screen](https://anthology-of-data.science/lecture-gam-ebm/#/title-slide))
