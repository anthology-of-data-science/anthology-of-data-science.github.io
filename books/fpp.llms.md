# Forecasting: Principles and Practice, the Pythonic Way

Authors

Affiliations

[Rob J Hyndman](https://robjhyndman.com)

Monash University, Australia

[George Athanasopoulos](https://research.monash.edu/en/persons/george-athanasopoulos)

Monash University, Australia

[Azul Garza](https://github.com/AzulGarza/)

TimeCopilot, San Francisco, USA

Cristian Challu

Nixtla, San Francisco, USA

Max Mergenthaler

Nixtla, San Francisco, USA

Kin G Olivares

Amazon, New York, USA

Modified

17 July 2026

## Preface

![](figs/fpppy_front_cover.jpg)

[Buy a print version](print-version.llms.md)

Welcome to our online textbook on forecasting for Python 🐍.

This textbook is based on [*Forecasting: Principles and Practice* (3rd ed)](https://otexts.com/fpp3/) and is intended to provide a comprehensive introduction to forecasting methods and to present just enough information about each method for readers to be able to use them sensibly. We don’t attempt to give a thorough discussion of the theoretical details behind each method, although the references at the end of each chapter will hopefully fill in many of those details.

The book is mainly aimed at four audiences:

1.  People doing forecasting in business without formal training.
2.  Undergraduate students interested in forecasting.
3.  MBA students taking a forecasting elective. The original R version is used for masters and third-year undergraduate students at Monash University, Australia.
4.  Practitioners needing a Python version of [*Forecasting: Principles and Practice* (3rd ed)](https://otexts.com/fpp3/).

For most sections, we assume only that readers are familiar with introductory statistics, and with high-school algebra. There are a couple of sections that also require knowledge of matrices and linear algebra, but these are flagged.

At the end of each chapter we provide a list of “further reading”. These lists suggest textbooks for a more advanced or detailed treatment of the subject. When no suitable textbook exists, we suggest journal articles for more information. To make this textbook easier to follow, we also provide a list of libraries, functions, modules, and classes with links to their documentation.

We use Python throughout the book and intend for students to learn how to forecast with Python. Python is free and available on almost every operating system. It is a great tool for statistical analysis, not just forecasting. See the [Using Python appendix](UsingPython.llms.md) for instructions on installing and using Python.

The book is different from other forecasting textbooks in several ways.

- It is free and online, making it accessible to a wide audience.
- It uses Python, which is free, open-source, and extremely powerful software.
- The online version is continuously updated. You don’t have to wait until the next edition for errors to be removed or new methods to be discussed. We will update the book frequently.
- There are dozens of real data examples taken from our own consulting practice. We have worked with hundreds of businesses and organisations helping them with forecasting issues, and this experience has contributed directly to many of the examples given here, as well as guiding our general philosophy of forecasting.
- We emphasise graphical methods more than most forecasters. We use graphs to explore the data, analyse the validity of the models fitted and present the forecasting results.

### Changes in the Python edition

The most important change in this edition of the book is that we use Python through the [nixtlaverse](https://github.com/Nixtla/) rather than R. The `nixtlaverse` is a collection of open-source Python libraries developed by Nixtla that provide a comprehensive, cutting-edge toolkit for time series forecasting. We also included two new chapters: Neural networks ([14  Neural networks](14-neural-networks.llms.md)) and Foundation forecasting models ([15  Foundation forecasting models](15-foundation-models.llms.md)), which are dedicated to recent techniques and developments in neural networks applied to forecasting.

The book covers the fundamental principles and methods of forecasting, demonstrating their application using Python’s powerful ecosystem of libraries, particularly those in the Nixtlaverse. While the core forecasting concepts remain the same, this version shows how to implement various forecasting techniques using Python tools. Readers will learn how to analyse time series data, apply different forecasting methods, and evaluate forecast accuracy, all within the Python environment. This adaptation aims to make the valuable forecasting knowledge from the original book accessible to Python users, while maintaining the practical, example-driven approach that made the R version so popular.

All the datasets used in this book are available [on the book’s website](./data) under the [`/data`](./data) directory. For example, to access `aus_tourism.csv`, you can navigate to [`data/aus_tourism.csv`](./data/aus_tourism.csv).

No doubt we have introduced some mistakes, and we will correct them online as soon as they are spotted. Please continue to [let us know](https://github.com/orgs/OTexts/discussions/categories/error-report?discussions_q=) about such things.

If you have questions about using the Python libraries discussed in this book, or about forecasting in general, please ask on the [OTexts discussion forum](https://github.com/orgs/OTexts/discussions).

 

Happy forecasting! 💙

Rob J Hyndman, George Athanasopoulos, Azul Garza, Cristian Challu, Max Mergenthaler Canseco, and Kin G Olivares

May 2026

### Acknowledgements

We would like to give special recognition to Mariana Menchero, whose work was essential to this book. She played a key role in providing tireless technical assistance to the authors and editorial team, helping bring this collaborative effort to fruition.

We also thank Mickaël Canouil, Yibei Hu, José Morales, Marco Peixeiro, Michael Richman, and Olivier Sprangers for their help and contributions.

Lastly, we would like to thank all the Nixtla open-source contributors. This book would not have been possible without their valuable work.

------------------------------------------------------------------------

To cite the online version of this book, please use the following:

> Hyndman, R.J., Athanasopoulos, G., Garza, A., Challu, C., Mergenthaler, M., & Olivares, K.G. (2026). Forecasting: Principles and Practice, the Pythonic Way. OTexts: Melbourne, Australia. Available at: OTexts.com/fpppy. Accessed on .

The online version of this book was last updated on 17 July 2026.

A [print edition of this book is also available](print-version.llms.md).
