# Exploratory data analysis with Altair

This notebook collects explorations of Altair’s most interesting features. Originally published on [Kaggle](https://www.kaggle.com/code/jacoporepossi/eda-is-awesome-having-fun-with-altair/notebook).

Author

[Jacopo Repossi](https://www.linkedin.com/in/jacopo-repossi/)

Published

January 1, 2023

``` python
import altair as alt
import numpy as np 
import pandas as pd


ames_data = "https://github.com/eaisi/discover-projects/blob/main/ames-housing/AmesHousing.csv?raw=true"
train = pd.read_csv(ames_data).rename(columns=lambda s: s.replace(" ",""))

train
```

|  | Order | PID | MSSubClass | MSZoning | LotFrontage | LotArea | Street | Alley | LotShape | LandContour | ... | PoolArea | PoolQC | Fence | MiscFeature | MiscVal | MoSold | YrSold | SaleType | SaleCondition | SalePrice |
|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| 0 | 1 | 526301100 | 20 | RL | 141.0 | 31770 | Pave | NaN | IR1 | Lvl | ... | 0 | NaN | NaN | NaN | 0 | 5 | 2010 | WD | Normal | 215000 |
| 1 | 2 | 526350040 | 20 | RH | 80.0 | 11622 | Pave | NaN | Reg | Lvl | ... | 0 | NaN | MnPrv | NaN | 0 | 6 | 2010 | WD | Normal | 105000 |
| 2 | 3 | 526351010 | 20 | RL | 81.0 | 14267 | Pave | NaN | IR1 | Lvl | ... | 0 | NaN | NaN | Gar2 | 12500 | 6 | 2010 | WD | Normal | 172000 |
| 3 | 4 | 526353030 | 20 | RL | 93.0 | 11160 | Pave | NaN | Reg | Lvl | ... | 0 | NaN | NaN | NaN | 0 | 4 | 2010 | WD | Normal | 244000 |
| 4 | 5 | 527105010 | 60 | RL | 74.0 | 13830 | Pave | NaN | IR1 | Lvl | ... | 0 | NaN | MnPrv | NaN | 0 | 3 | 2010 | WD | Normal | 189900 |
| ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... |
| 2925 | 2926 | 923275080 | 80 | RL | 37.0 | 7937 | Pave | NaN | IR1 | Lvl | ... | 0 | NaN | GdPrv | NaN | 0 | 3 | 2006 | WD | Normal | 142500 |
| 2926 | 2927 | 923276100 | 20 | RL | NaN | 8885 | Pave | NaN | IR1 | Low | ... | 0 | NaN | MnPrv | NaN | 0 | 6 | 2006 | WD | Normal | 131000 |
| 2927 | 2928 | 923400125 | 85 | RL | 62.0 | 10441 | Pave | NaN | Reg | Lvl | ... | 0 | NaN | MnPrv | Shed | 700 | 7 | 2006 | WD | Normal | 132000 |
| 2928 | 2929 | 924100070 | 20 | RL | 77.0 | 10010 | Pave | NaN | Reg | Lvl | ... | 0 | NaN | NaN | NaN | 0 | 4 | 2006 | WD | Normal | 170000 |
| 2929 | 2930 | 924151050 | 60 | RL | 74.0 | 9627 | Pave | NaN | Reg | Lvl | ... | 0 | NaN | NaN | NaN | 0 | 11 | 2006 | WD | Normal | 188000 |

2930 rows × 82 columns

## Bar Chart with Highlighted Bar

Basic bar chart with a **bars highlighted based on the percentage of missing values**.

``` python
missing = train.isnull().sum()*100/train.isnull().sum().sum()
missing = missing[missing > 0].reset_index()
missing.columns = ['Column', 'Count missing']
missing.head()
```

|     | Column      | Count missing |
|-----|-------------|---------------|
| 0   | LotFrontage | 3.111309      |
| 1   | Alley       | 17.347133     |
| 2   | MasVnrType  | 11.270557     |
| 3   | MasVnrArea  | 0.146041      |
| 4   | BsmtQual    | 0.507969      |

``` python
alt.Chart(missing).mark_bar().encode(
    x=alt.X('Column', sort='-y'),
    y='Count missing',
    color=alt.condition(
        alt.datum['Count missing'] >10,  # If count missing is > 10%, returns True,
        alt.value('orange'),             # which sets the bar orange.
        alt.value('steelblue')           # And if it's not true it sets the bar steelblue.
    ),
    tooltip=['Count missing']
).properties(
    width=500,
    height=300
).configure_axis(
    grid=False
)
```

## Boxplot

Creation of a basic boxplot using **`.mark_boxplot()` method**

``` python
alt.Chart(train).mark_boxplot().encode(
    x='OverallQual:O',
    y='SalePrice:Q',
    color='OverallQual:N'
).properties(
    width=500,
    height=300
)
```

## Heatmaps

Creation of a basic heatmap using **`.mark_rect()` method**.

``` python
alt.Chart(train).mark_rect().encode(
    x='MSZoning',
    y='ExterQual',
    color='average(SalePrice)',
    tooltip=['MSZoning', 'ExterQual', 'average(SalePrice)']
).properties(
    width=500,
    height=300
)
```

## Bindings, Selections & Conditions

Here you can **select the `KitchenQual` feature** from a **dropdown menu** and see how the graph changes color!

``` python
input_dropdown = alt.binding_select(options=list(train['KitchenQual'].unique()), name='Lot Shape')
selection = alt.selection_point(fields=['KitchenQual'], bind=input_dropdown)
color = alt.condition(selection,
                      alt.Color('KitchenQual:N', legend=None),
                      alt.value('lightgray'))

alt.Chart(train).mark_point().encode(
    x='GrLivArea',
    y='SalePrice',
    color=color,
    tooltip=['GrLivArea', 'SalePrice']
).properties(
    width=500,
    height=300
).add_params(
    selection
).configure_axis(
    grid=False
)
```

## Interactive Chart with Cross-Highlight

In this more advanced example, I use the `ExterQual` feature as a filter for a **binned heatmap**.

**Click** on the bar chart **bars to change the heatmap**!

``` python
pts = alt.selection_point(encodings=['x'])

rect = alt.Chart(train).mark_rect().encode(
    x=alt.X('GrLivArea', bin=alt.Bin(maxbins=40)),
    y=alt.Y('GarageArea', bin=alt.Bin(maxbins=40)),
    color='average(SalePrice)'
).properties(
    width=500,
    height=300
).transform_filter(
    pts
)

bar = alt.Chart(train).mark_bar().encode(
    x='ExterQual:N',
    y='count()',
    color=alt.condition(pts, alt.ColorValue("steelblue"), alt.ColorValue("grey")),
    tooltip=['ExterQual', 'count()']
).properties(
    width=550,
    height=200
).add_params(
    pts
)


alt.vconcat(
    rect,
    bar
).resolve_legend(
    color="independent",
    size="independent"
).configure_axis(
    grid=False
)
```

## Dot Dash Plot

A Dot Dash Plot is basically a **scatter plot** with **both axis removed** and replaced with **barcode plots** (aka strip plots), which allow you to **see the distribution of values** of each measure used in the scatter plot.

``` python
# Configure the options common to all layers
brush = alt.selection_interval()
base = alt.Chart(train).add_params(brush)

# Configure the points
points = base.mark_point().encode(
    x=alt.X('GrLivArea', title=''),
    y=alt.Y('SalePrice', title=''),
    color=alt.condition(brush, 'KitchenQual', alt.value('grey'))
)

# Configure the ticks
tick_axis = alt.Axis(labels=False, domain=False, ticks=False)

x_ticks = base.mark_tick().encode(
    alt.X('GrLivArea', axis=tick_axis),
    alt.Y('KitchenQual', title='', axis=tick_axis),
    color=alt.condition(brush, 'KitchenQual', alt.value('lightgrey'))
)

y_ticks = base.mark_tick().encode(
    alt.X('KitchenQual', title='', axis=tick_axis),
    alt.Y('SalePrice', axis=tick_axis),
    color=alt.condition(brush, 'KitchenQual', alt.value('lightgrey'))
)

# Build the chart
(
    y_ticks | (points & x_ticks)
).configure_axis(
    grid=False
)
```

## Multifeature Scatter Plot

Let’s create a scatter plot with **multiple feature encodings**.

With `.interactive()` you can zoom in. You can also **click on legend** to select specific `KitchenQual` values.

``` python
selection = alt.selection_point(fields=['KitchenQual'], bind='legend')

alt.Chart(train).mark_circle().encode(
    alt.X('GrLivArea', scale=alt.Scale(zero=False)),
    alt.Y('GarageArea', scale=alt.Scale(zero=False, padding=1)),
    color='KitchenQual',
    size=alt.Size('SalePrice', bin=alt.Bin(maxbins=10), title='SalePrice'),
    opacity=alt.condition(selection, alt.value(1), alt.value(0.2)),
    tooltip=['GrLivArea', 'SalePrice']
).properties(
    width=500,
    height=500
).add_params(
    selection
).configure_axis(
    grid=False
).interactive()
```

## Scatter Matrix

Scatter matrix are one of the most common graph you’ll see on Kaggle. It consists of several **pair-wise scatter plots** of variables presented in a **matrix format**, useful to visualize **multiple relationships** between a pair of variables.

In Altair this can be achieved using a RepeatChart, let’s see how!

``` python
alt.Chart(train).mark_circle().encode(
    alt.X(alt.repeat("column"), type='quantitative'),
    alt.Y(alt.repeat("row"), type='quantitative'),
    color='KitchenQual'
).properties(
    width=300,
    height=300
).repeat(
    # Here we tell Altair we want to repeat out scatter plots for each row-column pair
    row=['GrLivArea', 'GarageArea', 'TotalBsmtSF'],
    column=['TotalBsmtSF', 'GarageArea', 'GrLivArea']
).configure_axis(
    grid=False
)
```

## Layered Histogram

Using Altair, we can make overlapping histograms or layers histograms from data:

``` python
alt.Chart(train).mark_bar(
    opacity=0.5,
    binSpacing=0
).encode(
    alt.X('SalePrice:Q', bin=alt.Bin(maxbins=50)),
    alt.Y('count()', stack=None),
    alt.Color('MSZoning:N')
)
```
