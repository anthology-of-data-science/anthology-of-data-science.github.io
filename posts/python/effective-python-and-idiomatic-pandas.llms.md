# Effective Python and idiomatic pandas

Guidelines on how to continue to develop your skills to write effective Python and use pandas in an idiomatic way.

Author

Daniel Kapitan

Published

September 18, 2022

## A functional approach to Python

After you have gained basic working knowledge of Python, it is essential that you continue to develop your skills to write effective Python and use pandas in an idiomatic way. This notebook provides guidelines how to do this. It is very opinionated, and based on a functional programming approach to Python. Functional programming defines a computation using expressions and evaluation—often encapsulated in function definitions. It de-emphasizes or avoids the complexity of state change and mutable objects. This tends to create programs that are more succinct and expressive. Since you can’t easily create purely functional programs in Python, we take a hybrid approach, using functional features where we can add clariy or simplify the code. There are several key features of functional programming that are available in Python which we will use.

Functional programming is often a very good fit for data analysis.

- Use functions as first-class objects, meaning you can assign functions to variables and pass functions as arguments in other functions allowing for for composability of complex functions for data pipelines using smaller, more simple ones.
- Use of higher-order functions that operate on lists (iterables), like `sorted()`, `min()` and `max()`. NumPy and pandas follow this same principle with so-called [universal functions](https://numpy.org/doc/stable/reference/ufuncs.html), being functions that operate on `ndarrays` in an element-by-element fashion, supporting array broadcasting, type casting, and several other standard features.
- Functional programmes often exploits immutable data structures. Python offers tuples, namedtuples and frozen dataclass as complex but immutable objects. Although NumPy arrays and pandas DataFrames are mutable, we will adhere to the principle of immutable in data pipelines as much as possible.

## Structure of notebook

This notebook is structred in a couple of chapters with a number of related items. Feel free to jump between the items. Each item contains concise and specific guidance explaining how you can write effective, functional Python. We have used the following books and online resources, which are recommended for further reading:

- [Effective Python, 2nd edition](https://effectivepython.com/), by Brett Slatkin (eBook: EUR 30). Referenced as EP for items that have been taken from this book (which is warmly recommended).
- Blog posts on [Modern pandas](https://tomaugspurger.github.io/modern-1-intro.html) by Tom Augspurger.
- [Functional Python Programming](https://www.packtpub.com/product/functional-python-programming-second-edition/9781788627061) by Steven F. Lott (eBook: EUR 5).
- Intermediate tutorials for data science on [Real Python](https://realpython.com/learning-paths/data-science-python-core-skills/).

## Pythonic thinking

### \#1. Follow the PEP-8 style guide (EP \#2)

Python Enhancement Proposal \#8, otherwise known as [PEP-8](https://www.python.org/dev/peps/pep-0008/), is the style guide for how to format Python code. You are welcome to write Python code any way you want, as long as it has valid syntax. However, using a consistent style makes your code more approachable and easier to read. Sharing a common style with other Python programmers in the larger community facilitates collaboration on projects. But even if you are the only one who will ever read your code, following the style guide will make it easier for you to change things later, and can help you avoid many common errors.

PEP-8 provides a wealth of details about how to write clear Python code. It continues to be updated as the Python language evolves. It’s worth reading the [whole guide online](https://www.python.org/dev/peps/pep-0008/). Here are a few rules you should be sure to follow.

#### Whitespace

- Use spaces instead of tabs for indentation.
- Use four spaces for each level of syntactically significant indenting.
- Lines should be 79 characters in length or less.
- Continuations of long expressions onto additional lines should be indented by four extra spaces from their normal indentation level.
- In a file, functions and classes should be separated by two blank lines.
- In a class, methods should be separated by one blank line.
- In a dictionary, put no whitespace between each key and colon, and put a single space before the corresponding value if it fits on the same line.
- Put one—and only one—space before and after the `=` operator in a variable assignment.
- For type annotations, ensure that there is no separation between the variable name and the colon, and use a space before the type information.

#### Naming

PEP 8 suggests unique styles of naming for different parts in the language. These conventions make it easy to distinguish which type corresponds to each name when reading code. Follow these guidelines related to naming:

- Functions, variables, and attributes should be in `lowercase_underscore` format.
- Protected instance attributes should be in `_leading_underscore` format.
- Private instance attributes should be in `__double_leading_underscore` format.
- Classes (including exceptions) should be in `CapitalizedWord` format.
- Module-level constants should be in `ALL_CAPS` format.
- Instance methods in classes should use `self`, which refers to the object, as the name of the first parameter.
- Class methods should use `cls`, which refers to the class, as the name of the first parameter.

#### Expressions and Statements

The Zen of Python states: “There should be one—and preferably only one—obvious way to do it.” PEP 8 attempts to codify this style in its guidance for expressions and statements:

- Use inline negation (`if a is not b`) instead of negation of positive expressions (`if not a is b`).
- Don’t check for empty containers or sequences (like `[]` or `''`) by comparing the length to zero (if `len(somelist) == 0`). Use `if not somelist` and assume that empty values will implicitly evaluate to `False`.
- The same thing goes for non-empty containers or sequences (like `[1]` or `'hi'`). The statement `if somelist` is implicitly `True` for non-empty values.
- Avoid single-line if statements, `for` and `while` loops, and except compound statements. Spread these over multiple lines for clarity.
- If you can’t fit an expression on one line, surround it with parentheses and add line breaks and indentation to make it easier to read.
- Prefer surrounding multiline expressions with parentheses over using the `\` line continuation character.

#### Imports

PEP 8 suggests some guidelines for how to import modules and use them in your code:

- Always put import statements (including from `x import y`) at the top of a file.
- Always use absolute names for modules when importing them, not names relative to the current module’s own path. For example, to import the foo module from within the bar package, you should use from bar import foo, not just import foo.
- If you must do relative imports, use the explicit syntax `from . import foo`.
- Imports should be in sections in the following order:
  - standard library modules
  - third-party modules
  - your own modules.

  Each subsection should have imports in alphabetical order.

#### Use code formatters

It is recommended to use a code formatter like [pylint](https://www.pylint.org) or [Black](https://pypi.org/project/black/) to handle these conventions automatically. There is also [Jupyter Black](https://github.com/drillan/jupyter-black) for doing this in notebooks.

### \#2. Prefer interpolated f-strings over C-style formatting (EP \#4)

Before f-strings were introduced in Python 3.6, you had to do this to format your strings:

``` python
first_name = "Eric"
last_name = "Idle"
age = 74
profession = "comedian"
affiliation = "Monty Python"
print(
    "Hello, %s %s. You are %s. You are a %s. You were a member of %s."
    % (first_name, last_name, age, profession, affiliation)
)
```

    Hello, Eric Idle. You are 74. You are a comedian. You were a member of Monty Python.

Although the `str.format()` syntax is definitely better, it is still verbose:

``` python
print(
    "Hello {} {}, You are a {}. You are a{}. You were a member of {}".format(
        first_name, last_name, age, profession, affiliation
    )
)
```

    Hello Eric Idle, You are a 74. You are acomedian. You were a member of Monty Python

With f-strings this becomes a lot more readable.

``` python
print(
    f"Hello {first_name} {last_name}. You are {age}. You are a {profession}. You were a member of {affiliation}"
)
```

    Hello Eric Idle. You are 74. You are a comedian. You were a member of Monty Python

You can read more about using f-strings in this [Real Python tutorial](https://realpython.com/python-f-strings/).

### \#3. Write helper functions instead of complex expressions (EP \#5)

Python’s pithy syntax makes it easy to write single-line expressions that implement a lot of logic. For example, say that I want to decode the query string from a URL. Here, each query string parameter represents an integer value:

``` python
from urllib.parse import parse_qs

my_values = parse_qs("red=5&blue=0&green=", keep_blank_values=True)
print(repr(my_values))
```

    {'red': ['5'], 'blue': ['0'], 'green': ['']}

Some query string parameters may have multiple values, some may have single values, some may be present but have blank values, and some may be missing entirely. Using the `get` (more on that in [item 11](#item11)) method on the result dictionary will return different values in each circumstance:

``` python
print("Red:     ", my_values.get("red"))
print("Green:   ", my_values.get("green"))
print("Opacity: ", my_values.get("opacity"))
```

    Red:      ['5']
    Green:    ['']
    Opacity:  None

It’d be nice if a default value of `0` were assigned when a parameter isn’t supplied or is blank. I might choose to do this with Boolean expressions because it feels like this logic doesn’t merit a whole if statement or helper function quite yet.

Python’s syntax makes this choice all too easy. The trick here is that the empty string, the empty list, and zero all evaluate to `False` implicitly. Thus, the expressions below will evaluate to the subexpression after the or operator when the first subexpression is False:

``` python
red = my_values.get("red", [""])[0] or 0
green = my_values.get("green", [""])[0] or 0
opacity = my_values.get("opacity", [""])[0] or 0
print(f"Red:     {red!r}")
print(f"Green:   {green!r}")
print(f"Opacity: {opacity!r}")
```

    Red:     '5'
    Green:   0
    Opacity: 0

The `red` case works because the key is present in the my_values dictionary. The value is a list with one member: the string `'5'`. This string implicitly evaluates to `True`, so red is assigned to the first part of the or expression.

The `green` case works because the value in the `my_values` dictionary is a list with one member: an empty string. The empty string implicitly evaluates to `False`, causing the or expression to evaluate to `0`.

The `opacity` case works because the value in the `my_values` dictionary is missing altogether. The behavior of the get method is to return its second argument if the key doesn’t exist in the dictionary (see [item 11: “Prefer `get` over `in` and `KeyError` to handle missing dictionary keys”](#item11)). The default value in this case is a list with one member: an empty string. When `opacity` isn’t found in the dictionary, this code does exactly the same thing as the `green` case.

However, this expression is difficult to read, and it still doesn’t do everything I need. I’d also want to ensure that all the parameter values are converted to integers so I can immediately use them in mathematical expressions. To do that, I’d wrap each expression with the int built-in function to parse the string as an integer:

``` python
red = int(my_values.get("red", [""])[0] or 0)
green = int(my_values.get("green", [""])[0] or 0)
opacity = int(my_values.get("opacity", [""])[0] or 0)
print(f"Red:     {red}")
print(f"Green:   {green}")
print(f"Opacity: {opacity}")
```

    Red:     5
    Green:   0
    Opacity: 0

You see this get unwieldly quite quickly. Furthermore, if you need to reuse this logic repeatedly - even just to or three times, as in this example, - then writing a helper function is the way to go:

``` python
def get_first_int(values, key, default=0):
    found = values.get(key, [""])
    if found[0]:
        return int(found[0])
    return default


green = get_first_int(my_values, "green")
print(f"Green:   {green!r}")
```

    Green:   0

As soon as expressions get complicated, it’s time to consider splitting them into smaller pieces and moving logic into helper functions. What you gain in readability always outweighs what brevity may have afforded you. Avoid letting Python’s pithy syntax for complex expressions from getting you into a mess like this. Follow the **DRY** principle: *Don’t repeat yourself*.

### \#4. Prefer multiple assignment unpacking over indexing (EP \#6)

Python also has syntax for unpacking, which allows for assigning multiple values in a single statement. The patterns that you specify in unpacking assignments look a lot like trying to mutate tuples—which isn’t allowed—but they actually work quite differently. For example, if you know that a tuple is a pair, instead of using indexes to access its values, you can assign it to a tuple of two variable names:

``` python
item = ("Peanut butter", "Jelly")
first, second = item  # Unpacking
print(first, "and", second)
```

    Peanut butter and Jelly

Unpacking has less visual noise than accessing the tuple’s indexes, and it often requires fewer lines. The same pattern matching syntax of unpacking works when assigning to lists, sequences, and multiple levels of arbitrary iterables within iterables. Newcomers to Python may be surprised to learn that unpacking can even be used to swap values in place without the need to create temporary variables. Here, I use typical syntax with indexes to swap the values between two positions in a list as part of an ascending order sorting algorithm (using [bubble sort](https://en.wikipedia.org/wiki/Bubble_sort)):

``` python
def bubble_sort(a):
    for _ in range(len(a)):
        for i in range(1, len(a)):
            if a[i] < a[i - 1]:
                temp = a[i]
                a[i] = a[i - 1]
                a[i - 1] = temp


names = ["pretzels", "carrots", "arugula", "bacon"]
bubble_sort(names)
print(names)
```

    ['arugula', 'bacon', 'carrots', 'pretzels']

However, with unpacking syntax, it’s possible to swap indexes in a single line:

``` python
def bubble_sort(a):
    for _ in range(len(a)):
        for i in range(1, len(a)):
            if a[i] < a[i - 1]:
                a[i - 1], a[i] = a[i], a[i - 1]  # Swap


names = ["pretzels", "carrots", "arugula", "bacon"]
bubble_sort(names)
print(names)
```

    ['arugula', 'bacon', 'carrots', 'pretzels']

The way this swap works is that the right side of the assignment (`a[i], a[i-1]`) is evaluated first, and its values are put into a new temporary, unnamed tuple (such as `('carrots', 'pretzels')` on the first iteration of the loops). Then, the unpacking pattern from the left side of the assignment (`a[i-1], a[i]`) is used to receive that tuple value and assign it to the variable names `a[i-1]` and `a[i]`, respectively. This replaces `'pretzels'` with `'carrots'` at index `0` and `'carrots'` with `'pretzels'` at index 1. Finally, the temporary unnamed tuple silently goes away.

Another valuable application of unpacking is in the target list of for loops and similar constructs, such as comprehensions and generator expressions (see [item 13: “Use comprehensions instead of `map` and `filter`”](#item13) for those). As an example for contrast, here I iterate over a list of snacks without using unpacking:

``` python
snacks = [("bacon", 350), ("donut", 240), ("muffin", 190)]
for i in range(len(snacks)):
    item = snacks[i]
    name = item[0]
    calories = item[1]
    print(f"#{i+1}: {name} has {calories} calories")
```

    #1: bacon has 350 calories
    #2: donut has 240 calories
    #3: muffin has 190 calories

This works, but it’s noisy. There are a lot of extra characters required in order to index into the various levels of the snacks structure. Here, I achieve the same output by using unpacking along with the enumerate built-in function (see [item 5: “Prefer enumerate Over range”](#item5)):

``` python
for rank, (name, calories) in enumerate(snacks, 1):
    print(f"#{rank}: {name} has {calories} calories")
```

    #1: bacon has 350 calories
    #2: donut has 240 calories
    #3: muffin has 190 calories

Using unpacking wisely will enable you to avoid indexing when possible, resulting in clearer and more Pythonic code. So remember:

- Python has special syntax called unpacking for assigning multiple values in a single statement.
- Unpacking is generalized in Python and can be applied to any iterable, including many levels of iterables within iterables.
- Reduce visual noise and increase code clarity by using unpacking to avoid explicitly indexing into sequences.

\### \#5. Prefer `enumerate` over `range` (EP \#7)

When you have a data structure to iterate over, like a list of strings, you can loop directly over the sequence:

``` python
flavor_list = ["vanilla", "chocolate", "pecan", "strawberry"]
for flavor in flavor_list:
    print(f"{flavor} is delicious")
```

    vanilla is delicious
    chocolate is delicious
    pecan is delicious
    strawberry is delicious

Often, you’ll want to iterate over a list and also know the index of the current item in the list. For example, say that I want to print the ranking of my favorite ice cream flavors. One way to do it is by using range:

``` python
for i in range(len(flavor_list)):
    flavor = flavor_list[i]
    print(f"{i + 1}: {flavor}")
```

    1: vanilla
    2: chocolate
    3: pecan
    4: strawberry

This looks clumsy compared with the other example of iterating over `flavor_list`. I have to get the length of the list. I have to index into the array. The multiple steps make it harder to read.

Python provides the `enumerate` built-in function to address this situation. `enumerate` wraps any iterator with a lazy generator (read [more on generators in this Real Python article](https://realpython.com/introduction-to-python-generators/)). `enumerate` yields pairs of the loop index and the next value from the given iterator. Here, I manually advance the returned iterator with the next built-in function to demonstrate what it does:

``` python
for i, flavor in enumerate(flavor_list):
    print(f"{i + 1}: {flavor}")
```

    1: vanilla
    2: chocolate
    3: pecan
    4: strawberry

I can make this even shorter by specifying the number from which `enumerate` should begin counting (`1` in this case) as the second parameter:

``` python
for i, flavor in enumerate(flavor_list, 1):
    print(f"{i}: {flavor}")
```

    1: vanilla
    2: chocolate
    3: pecan
    4: strawberry

### \#6. Use zip to process iterators in parallel (EP \#8)

Often in Python you find yourself with many lists of related objects. List comprehensions make it easy to take a source list and get a derived list by applying an expression (see [item 13: “Use comprehensions instead of `map` and `filter`”](#item13)):

``` python
names = ["Cecilia", "Lise", "Marie"]
counts = [len(n) for n in names]
print(counts)
```

    [7, 4, 5]

The items in the derived list are related to the items in the source list by their indexes. To iterate over both lists in parallel, I can iterate over the length of the `names` source list:

``` python
longest_name = None
max_count = 0

for i in range(len(names)):
    count = counts[i]
    if count > max_count:
        longest_name = names[i]
        max_count = count

print(longest_name)
```

    Cecilia

The problem is that this whole loop statement is visually noisy. The indexes into `names` and `counts` make the code hard to read. Indexing into the arrays by the loop index `i` happens twice. Using `enumerate` (see [item 5: “Prefer enumerate Over range”](#item5)) improves this slightly, but it’s still not ideal:

``` python
longest_name = None
max_count = 0
for i, name in enumerate(names):
    count = counts[i]
    if count > max_count:
        longest_name = name
        max_count = count

print(longest_name)
```

    Cecilia

To make this code clearer, Python provides the `zip` built-in function. `zip` wraps two or more iterators with a lazy generator. The `zip` generator yields tuples containing the next value from each iterator. These tuples can be unpacked directly within a for statement (see [item 4: “Prefer multiple assignment unpacking over indexing”](#item4)). The resulting code is much cleaner than the code for indexing into multiple lists:

``` python
longest_name = None
max_count = 0
for name, count in zip(names, counts):
    if count > max_count:
        longest_name = name
        max_count = count

print(longest_name)
```

    Cecilia

`zip` consumes the iterators it wraps one item at a time, which means it can be used with infinitely long inputs without risk of a program using too much memory and crashing.

However, beware of `zip`’s behavior when the input iterators are of different lengths. For example, say that I add another item to names above but forget to update counts. Running zip on the two input lists will have an unexpected result:

``` python
names.append("Rosalind")
for name, count in zip(names, counts):
    print(name)
```

    Cecilia
    Lise
    Marie

The new item for `'Rosalind'` isn’t there. Why not? This is just how `zip` works. It keeps yielding tuples until any one of the wrapped iterators is exhausted. Its output is as long as its shortest input. This approach works fine when you know that the iterators are of the same length, which is often the case for derived lists created by list comprehensions. But in many other cases, the truncating behavior of `zip` is surprising and bad. If you don’t expect the lengths of the lists passed to zip to be equal, consider using the `zip_longest` function from the `itertools` built-in module instead:

``` python
import itertools

for name, count in itertools.zip_longest(names, counts):
    print(f"{name}: {count}")
```

    Cecilia: 7
    Lise: 4
    Marie: 5
    Rosalind: None

`zip_longest` replaces missing values—the length of the string `'Rosalind'` in this case—with whatever fillvalue is passed to it, which defaults to `None`.

Note that the `itertools` implements more iterator building block that come from functional programming. Read more in [this Real Python article](https://realpython.com/python-itertools/).

## Lists, dictionairies and dataclasses

### \#7. Use `dataclass` if you need to create a data container

The `dataclass` class was introduced in Python 3.7. Given our functional approach, you should first ask yourself whether you really need a new container object for your data. In the words of [Alan J. Perlis](https://en.wikipedia.org/wiki/Alan_Perlis):

> It is better to have 100 functions operate on one data structure than to have 10 functions operate on 10 data structures.

If you have consciously decided you *do* want a new data object, then `dataclass` is your friend. It is created using the new `@dataclass` decorator as follows:

``` python
from dataclasses import dataclass


@dataclass
class DataClassCard:
    rank: str
    suit: str
```

A `dataclass` comes with basic functionality already implemented. For instance, you can instantiate, print, and compare `dataclass` instances straight out of the box:

``` python
queen_of_hearts = DataClassCard("Q", "Hearts")
print(queen_of_hearts.rank)
```

    Q

``` python
queen_of_hearts
```

    DataClassCard(rank='Q', suit='Hearts')

``` python
queen_of_hearts == DataClassCard("Q", "Hearts")
```

    True

Read more on `dataclass` and how to use them in [this Real Python tutorial](https://realpython.com/python-data-classes/).

### \#8. Prefer catch-all unpacking over slicing (EP \#13)

One limitation of basic unpacking (see [item 4](#item4)) is that you must know the length of the sequences you’re unpacking in advance. For example, here I have a list of the ages of cars that are being traded in at a dealership. When I try to take the first two items of the list with basic unpacking, an exception is raised at runtime:

``` python
car_ages = [0, 9, 4, 8, 7, 20, 19, 1, 6, 15]
car_ages_descending = sorted(car_ages, reverse=True)
oldest, second_oldest = car_ages_descending
```

    ---------------------------------------------------------------------------
    ValueError                                Traceback (most recent call last)
    <ipython-input-28-99634ca0e408> in <module>
          1 car_ages = [0, 9, 4, 8, 7, 20, 19, 1, 6, 15]
          2 car_ages_descending = sorted(car_ages, reverse=True)
    ----> 3 oldest, second_oldest = car_ages_descending

    ValueError: too many values to unpack (expected 2)

Newcomers to Python often rely on indexing and slicing for this situation. For example, here I extract the oldest, second oldest, and other car ages from a list of at least two items:

``` python
oldest = car_ages_descending[0]
second_oldest = car_ages_descending[1]
others = car_ages_descending[2:]
print(oldest, second_oldest, others)
```

    20 19 [15, 9, 8, 7, 6, 4, 1, 0]

However, to unpack assignments that contain a starred expression, you must have at least one required part, or else you’ll get a `SyntaxError`. You can’t use a catch-all expression on its own:

``` python
*others = car_ages_descending
```

      File "<ipython-input-30-77c6f344fe32>", line 1
        *others = car_ages_descending
        ^
    SyntaxError: starred assignment target must be in a list or tuple

You also can’t use multiple catch-all expressions in a single-level unpacking pattern:

``` python
first, *middle, *second_middle, last = [1, 2, 3, 4]
```

      File "<ipython-input-31-77dccc131ad1>", line 1
        first, *middle, *second_middle, last = [1, 2, 3, 4]
        ^
    SyntaxError: multiple starred expressions in assignment

But it is possible to use multiple starred expressions in an unpacking assignment statement, as long as they’re catch-alls for different parts of the multilevel structure being unpacked. I don’t recommend doing the following (see [item 11: “Never unpack more than three variables when functions return multiple values”](#item11) for related guidance), but understanding it should help you develop an intuition for how starred expressions can be used in unpacking assignments:

``` python
car_inventory = {
    "Downtown": ("Silver Shadow", "Pinto", "DMC"),
    "Airport": ("Skyline", "Viper", "Gremlin", "Nova"),
}

((loc1, (best1, *rest1)), (loc2, (best2, *rest2))) = car_inventory.items()
print(f"Best at {loc1} is {best1}, {len(rest1)} others")
print(f"Best at {loc2} is {best2}, {len(rest2)} others")
```

    Best at Downtown is Silver Shadow, 2 others
    Best at Airport is Skyline, 3 others

Starred expressions become list instances in all cases. If there are no leftover items from the sequence being unpacked, the catch-all part will be an empty `list`. This is especially useful when you’re processing a sequence that you know in advance has at least \\N\\ elements:

``` python
short_list = [1, 2]
first, second, *rest = short_list
print(first, second, rest)
```

    1 2 []

But with the addition of starred expressions, the value of unpacking iterators becomes clear. For example, here I have a generator that yields the rows of a CSV file containing all car orders from the dealership this week:

``` python
def generate_csv():
    yield ("Date", "Make", "Model", "Year", "Price")
    for i in range(100):
        yield ("2019-03-25", "Honda", "Fit", "2010", "$3400")
        yield ("2019-03-26", "Ford", "F150", "2008", "$2400")
```

Processing the results of this generator using indexes and slices is fine, but it requires multiple lines and is visually noisy:

``` python
all_csv_rows = list(generate_csv())
header = all_csv_rows[0]
rows = all_csv_rows[1:]
print("CSV Header:", header)
print("Row count: ", len(rows))
```

    CSV Header: ('Date', 'Make', 'Model', 'Year', 'Price')
    Row count:  200

Unpacking with a starred expression makes it easy to process the first row—the header—separately from the rest of the iterator’s contents. This is much clearer:

``` python
it = generate_csv()
header, *rows = it
print("CSV Header:", header)
print("Row count: ", len(rows))
```

    CSV Header: ('Date', 'Make', 'Model', 'Year', 'Price')
    Row count:  200

Keep in mind, however, that because a starred expression is always turned into a list, unpacking an iterator also risks the potential of using up all of the memory on your computer and causing your program to crash. So you should only use catch-all unpacking on iterators when you have good reason to believe that the result data will all fit in memory.

Finally, note that the unpacking operators `*` for `list`s and `**` for `dict`s is often used in functions. Read [this tutorial on Real Python that demystifies `*args` and `**kwargs`](https://realpython.com/python-kwargs-and-args/). Note that `args` and `kwargs` are just names that are used by convention to refer to positional arguments and keyword arguments, respectively. You could use any other name if you wanted to. The magic lies in the `*` and `**` unpacking operators, as is shown with this trick from Real Python’s homepage:

``` python
x = {"a": 1, "b": 2}
y = {"c": 3, "d": 4}
z = {**x, **y}
```

When unpacking `dict`s with overlapping keys, the last value is kept:

``` python
y = {"b": 3, "c": 4}
{**x, **y}
```

    {'a': 1, 'b': 3, 'c': 4}

Using `**kwargs` you can easily re-use parameters are the same for different calls to the same function:

``` python
import pandas as pd

csv_kwargs = {"sep": ";", "encoding": "utf-8"}
ames = pd.read_csv(
    "https://github.com/eaisi/discover-projects/blob/main/ames-housing/AmesHousing.csv?raw=true",
    **csv_kwargs
)
pima = pd.read_csv(
    "https://github.com/eaisi/discover-projects/blob/main/pima-indians-diabetes/diabetes.csv?raw=true",
    **csv_kwargs
)
```

### \#9. Sort by complex criteria using the `key` parameter (EP \#14)

The `list` built-in type provides a sort method for ordering the items in a `list` instance based on a variety of criteria. By default, sort will order a list’s contents by the natural ascending order of the items. For example, here I sort a list of integers from smallest to largest:

``` python
numbers = [93, 86, 11, 68, 70]
numbers.sort()
print(numbers)
```

    [11, 68, 70, 86, 93]

The sort method works for nearly all built-in types (strings, floats, etc.) that have a natural ordering to them. What does `sort` do with objects? Often there’s an attribute on the object that you’d like to use for sorting. To support this use case, the `sort` method accepts a key parameter that’s expected to be a function. The key function is passed a single argument, which is an item from the list that is being sorted. The return value of the key function should be a comparable value (i.e., with a natural ordering) to use in place of an item for sorting purposes.

For example, here I define a `dataclass` to represent various tools. To sort a the `list` of `Tool` object alphabetically by name, I use the lambda keyword to define a function for the key parameter:

``` python
from dataclasses import dataclass


@dataclass
class Tool:
    name: str
    weight: float


tools = [
    Tool("level", 3.5),
    Tool("hammer", 1.25),
    Tool("screwdriver", 0.5),
    Tool("chisel", 0.25),
]
```

``` python
print("\nUnsorted:\n", tools)
tools.sort(key=lambda x: x.name)
print("\nSorted:\n", tools)
```


    Unsorted:
     [Tool(name='level', weight=3.5), Tool(name='hammer', weight=1.25), Tool(name='screwdriver', weight=0.5), Tool(name='chisel', weight=0.25)]

    Sorted:
     [Tool(name='chisel', weight=0.25), Tool(name='hammer', weight=1.25), Tool(name='level', weight=3.5), Tool(name='screwdriver', weight=0.5)]

I can just as easily define another lambda function to sort by weight and pass it as the key parameter to the sort method:

``` python
tools.sort(key=lambda x: x.weight)
print("\nBy weight:\n", tools)
```


    By weight:
     [Tool(name='chisel', weight=0.25), Tool(name='screwdriver', weight=0.5), Tool(name='hammer', weight=1.25), Tool(name='level', weight=3.5)]

Within the lambda function passed as the key parameter you can access attributes of items as I’ve done here, index into items (for sequences, tuples, and dictionaries), or use any other valid expression.

For basic types like strings, you may even want to use the key function to do transformations on the values before sorting. For example, here I apply the `lower` method to each item in a `list` of place names to ensure that they’re in alphabetical order, ignoring any capitalization (since in the natural lexical ordering of strings, capital letters come before lowercase letters):

``` python
places = ["home", "work", "New York", "Paris"]
places.sort()
print("Case sensitive: ", places)
places.sort(key=lambda x: x.lower())
print("Case insensitive:", places)
```

    Case sensitive:  ['New York', 'Paris', 'home', 'work']
    Case insensitive: ['home', 'New York', 'Paris', 'work']

Sometimes you may need to use multiple criteria for sorting. For example, say that I have a list of power tools and I want to sort them first by weight and then by name. How can I accomplish this?

``` python
power_tools = [
    Tool("drill", 4),
    Tool("circular saw", 5),
    Tool("jackhammer", 40),
    Tool("sander", 4),
]
```

The simplest solution in Python is to use the `tuple` type. Tuples are immutable sequences of arbitrary Python values. Tuples are comparable by default and have a natural ordering, meaning that they implement all of the special methods, such as `__lt__`, that are required by the `sort` method. Tuples implement these special method comparators by iterating over each position in the tuple and comparing the corresponding values one index at a time. Here, I show how this works when one tool is heavier than another:

``` python
saw = (5, "circular saw")
jackhammer = (40, "jackhammer")
(jackhammer < saw)  # False
```

    False

If the first position in the tuples being compared are equal—weight in this case—then the `tuple` comparison will move on to the second position, and so on. You can take advantage of this `tupl`e comparison behavior in order to sort the `list` of power tools first by weight and then by name. Here, I define a `key` function that returns a tuple containing the two attributes that I want to sort on in order of priority:

``` python
power_tools.sort(key=lambda x: (x.weight, x.name))
print(power_tools)
```

    [Tool(name='drill', weight=4), Tool(name='sander', weight=4), Tool(name='circular saw', weight=5), Tool(name='jackhammer', weight=40)]

One limitation of having the `key` function return a `tuple` is that the direction of sorting for all criteria must be the same (either all in ascending order, or all in descending order). If I provide the `reverse` parameter to the `sort` method, it will affect both criteria in the `tuple` the same way (note how ’`sander'` now comes before `'drill'` instead of after):

``` python
power_tools.sort(
    key=lambda x: (x.weight, x.name), reverse=True
)  # Makes all criteria descending
print(power_tools)
```

    [Tool(name='jackhammer', weight=40), Tool(name='circular saw', weight=5), Tool(name='sander', weight=4), Tool(name='drill', weight=4)]

For situations where you do want to have different sorting orders, Python provides a *stable* sorting algorithm. The `sort` method of the list type will preserve the order of the input list when the `key` function returns values that are equal to each other. This means that I can call `sort` multiple times on the same `list` to combine different criteria together. Here, I produce the same sort ordering of `weight` descending and `name`b ascending as I did above but by using two separate calls to sort:

``` python
power_tools.sort(key=lambda x: x.name)  # Name ascending
power_tools.sort(key=lambda x: x.weight, reverse=True)  # Weight descending
print(power_tools)
```

    [Tool(name='jackhammer', weight=40), Tool(name='circular saw', weight=5), Tool(name='drill', weight=4), Tool(name='sander', weight=4)]

This same approach can be used to combine as many different types of sorting criteria as you’d like in any direction, respectively. You just need to make sure that you execute the sorts in the opposite sequence of what you want the final `list` to contain. In this example, I wanted the sort order to be by `weight` descending and then by `name` ascending, so I had to do the `name` sort first, followed by the `weight` sort.

That said, the approach of having the key function return a tuple, and using unary negation to mix sort orders for numbers, is simpler to read and requires less code. I recommend only using multiple calls to sort if it’s absolutely necessary.

\### \#10. Prefer `get` over `in` and `KeyError` to handle missing dictionairy keys (EP 16)

The three fundamental operations for interacting with dictionaries are accessing, assigning, and deleting keys and their associated values. The contents of dictionaries are dynamic, and thus it’s entirely possible—even likely—that when you try to access or delete a key, it won’t already be present.

For example, say that I’m trying to determine people’s favorite type of bread to devise the menu for a sandwich shop. Here, I define a dictionary of counters with the current votes for each style:

``` python
counters = {
    "pumpernickel": 2,
    "sourdough": 1,
}
```

To increment the counter for a new vote, I need to see if the key exists, insert the key with a default counter value of zero if it’s missing, and then increment the counter’s value. This requires accessing the key two times and assigning it once. Here, I accomplish this task using an `if` statement with an `in` expression that returns `True` when the key is present:

``` python
key = "wheat"

if key in counters:
    count = counters[key]
else:
    count = 0

counters[key] = count + 1
```

Another way to accomplish the same behavior is by relying on how dictionaries raise a `KeyError` exception when you try to get the value for a key that doesn’t exist. This approach is more efficient because it requires only one access and one assignment:

``` python
try:
    count = counters[key]
except KeyError:
    count = 0

counters[key] = count + 1
```

This flow of fetching a key that exists or returning a default value is so common that the dict built-in type provides the `get` method to accomplish this task. The second parameter to `get` is the default value to return in the case that the key—the first parameter—isn’t present. This also requires only one access and one assignment, but it’s much shorter than the `KeyError` example:

``` python
count = counters.get(key, 0)
counters[key] = count + 1
```

Thus, for a dictionary with simple types, using the `get` method is the shortest and clearest option.

> Note: ff you’re maintaining dictionaries of counters like this, it’s worth considering the Counter class from the collections built-in module, which provides most of the facilities you are likely to need.

What if the values of the dictionary are a more complex type, like a `list`? For example, say that instead of only counting votes, I also want to know who voted for each type of bread. Here, I do this by associating a list of names with each key:

``` python
votes = {
    "baguette": ["Bob", "Alice"],
    "ciabatta": ["Coco", "Deb"],
}
key = "brioche"
who = "Elmer"
```

Similarly, you can use the get method to fetch a list value when the key is present, or do one fetch and one assignment if the key isn’t present:

``` python
names = votes.get(key)
if names is None:
    votes[key] = names = []
names.append(who)
print(votes)
```

    {'baguette': ['Bob', 'Alice'], 'ciabatta': ['Coco', 'Deb'], 'brioche': ['Elmer']}

The approach that involves using `get` to fetch list values can further be shortened by one line if you use an assignment expression with the walrus operator which was introduced in Python 3.8. [Read more about that on Real Python](https://realpython.com/python38-new-features/#the-walrus-in-the-room-assignment-expressions). For now, we will just leave you with the example:

``` python
# note: this will throw error on Google Colab, which is Python 3.6
if (names := votes.get(key)) is None:
    votes[key] = names = []
names.append(who)
print(votes)
```

    {'baguette': ['Bob', 'Alice'], 'ciabatta': ['Coco', 'Deb'], 'brioche': ['Elmer', 'Elmer']}

## Functions

\### \#11. Never unpack more than three variables when functions return multiple values (EP \#19)

One effect of the unpacking syntax (see [item 4](#item4)) is that it allows Python functions to seemingly return more than one value. For example, say that I’m trying to determine various statistics for a population of alligators. Given a list of lengths, I need to calculate the minimum and maximum lengths in the population. Here, I do this in a single function that appears to return two values:

``` python
def get_stats(numbers):
    minimum = min(numbers)
    maximum = max(numbers)
    return minimum, maximum


lengths = [63, 73, 72, 60, 67, 66, 71, 61, 72, 70]
minimum, maximum = get_stats(lengths)  # Two return values
print(f"Min: {minimum}, Max: {maximum}")
```

    Min: 60, Max: 73

The way this works is that multiple values are returned together in a two-item tuple. The calling code then unpacks the returned tuple by assigning two variables. Here, I use an even simpler example to show how an unpacking statement and multiple-return function work the same way:

``` python
first, second = 1, 2
assert first == 1
assert second == 2


def my_function():
    return [1, 2]


first, second = my_function()
assert first == 1
assert second == 2
```

``` python
_, second = my_function()
```

Multiple return values can also be received by starred expressions for catch-all unpacking. For example, say I need another function that calculates how big each alligator is relative to the population average. This function returns a list of ratios, but I can receive the longest and shortest items individually by using a starred expression for the middle portion of the list:

``` python
def get_avg_ratio(numbers):
    average = sum(numbers) / len(numbers)
    scaled = [x / average for x in numbers]
    scaled.sort(reverse=True)
    return scaled


longest, *middle, shortest = get_avg_ratio(lengths)
print(f"Longest: {longest:>4.0%}")
print(f"Shortest: {shortest:>4.0%}")
```

    Longest: 108%
    Shortest:  89%

Now, imagine that the program’s requirements change, and I need to also determine the average length, median length, and total population size of the alligators. I can do this by expanding the `get_stats` function to also calculate these statistics and return them in the result tuple that is unpacked by the caller:

``` python
def get_stats(numbers):
    minimum = min(numbers)
    maximum = max(numbers)
    count = len(numbers)
    average = sum(numbers) / count

    sorted_numbers = sorted(numbers)
    middle = count // 2
    if count % 2 == 0:
        lower = sorted_numbers[middle - 1]
        upper = sorted_numbers[middle]
        median = (lower + upper) / 2
    else:
        median = sorted_numbers[middle]

    return minimum, maximum, average, median, count


minimum, maximum, average, median, count = get_stats(lengths)

print(f"Min: {minimum}, Max: {maximum}")
print(f"Average: {average}, Median: {median}, Count {count}")

assert minimum == 60
assert maximum == 73
assert average == 67.5
assert median == 68.5
assert count == 10
```

    Min: 60, Max: 73
    Average: 67.5, Median: 68.5, Count 10

There are two problems with this code. First, all the return values are numeric, so it is all too easy to reorder them accidentally (e.g., swapping average and median), which can cause bugs that are hard to spot later. Using a large number of return values is extremely error prone.

Second, the line that calls the function and unpacks the values is long, and it likely will need to be wrapped in one of a variety of ways, which hurts readability.

To avoid these problems, you should never use more than three variables when unpacking the multiple return values from a function. These could be individual values from a three-tuple, two variables and one catch-all starred expression, or anything shorter. If you need to unpack more return values than that, you’re better off defining a `dataclass` or `namedtuple` and having your function return an instance of that instead.

### \#12. Use `None` and docstrings to specify dynamic default arguments (EP \#24)

Sometimes you need to use a non-static type as a keyword argument’s default value. For example, say that I want to load a value encoded as JSON data; if decoding the data fails, I want an empty dictionary to be returned by default:

``` python
import json


def decode(data, default={}):
    try:
        return json.loads(data)
    except ValueError:
        return default
```

The problem here is that dictionary specified for `default` will be shared by all calls to `decode` because default argument values are evaluated only once (at module load time). This can cause extremely surprising behavior:

``` python
foo = decode("bad data")
foo["stuff"] = 5
bar = decode("also bad")
bar["meep"] = 1
print("Foo:", foo)
print("Bar:", bar)
```

    Foo: {'stuff': 5, 'meep': 1}
    Bar: {'stuff': 5, 'meep': 1}

You might expect two different dictionaries, each with a single key and value. But modifying one seems to also modify the other. The culprit is that `foo` and `bar` are both equal to the default parameter. They are the same dictionary object:

``` python
foo is bar
```

    True

The fix is to set the keyword argument default value to None and then document the behavior in the function’s docstring:

``` python
def decode(data, default=None):
    """Load JSON data from a string.

    Args:
         data: JSON data to decode.
         default: Value to return if decoding fails.
             Defaults to an empty dictionary.
    """
    try:
        return json.loads(data)
    except ValueError:
        if default is None:
            default = {}
    return default
```

Now, running the same test code as before produces the expected result:

``` python
foo = decode("bad data")
foo["stuff"] = 5
bar = decode("also bad")
bar["meep"] = 1
print("Foo:", foo)
print("Bar:", bar)
```

    Foo: {'stuff': 5}
    Bar: {'meep': 1}

``` python
foo is not bar
```

    True

So remember: - A default argument value is evaluated only once: during function definition at module load time. This can cause odd behaviors for dynamic values (like `{}`, `[]`, or `datetime.now()`). - Use `None` as the default value for any keyword argument that has a dynamic value. Document the actual default behavior in the function’s docstring.

## Comprehensions

### \#13. Use comprehensions instead of `map` and `filter` (EP \#27)

Python provides compact syntax for deriving a new `list` from another sequence or iterable. These expressions are called list comprehensions. For example, say that I want to compute the square of each number in a `list`. Here, I do this by using a simple `for` loop:

``` python
a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
squares = []
for x in a:
    squares.append(x ** 2)
print(squares)
```

    [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

With a list comprehension, I can achieve the same outcome by specifying the expression for my computation along with the input sequence to loop over:

``` python
squares = [x ** 2 for x in a]  # List comprehension
print(squares)
```

    [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

Unless you’re applying a single-argument function, list comprehensions are also clearer than the `map` built-in function for simple cases. `map` requires the creation of a lambda function for the computation, which is visually noisy:

``` python
alt = map(lambda x: x ** 2, a)
```

Unlike `map`, list comprehensions let you easily filter items from the input list, removing corresponding outputs from the result. For example, say I want to compute the squares of the numbers that are divisible by 2. Here, I do this by adding a conditional expression to the list comprehension after the loop:

``` python
even_squares = [x ** 2 for x in a if x % 2 == 0]
print(even_squares)
```

    [4, 16, 36, 64, 100]

The `filter` built-in function can be used along with map to achieve the same outcome, but it is much harder to read:

``` python
alt = map(lambda x: x ** 2, filter(lambda x: x % 2 == 0, a))
assert even_squares == list(alt)
```

Dictionaries and sets have their own equivalents of list comprehensions (called *dictionary comprehensions* and *set comprehensions*, respectively). These make it easy to create other types of derivative data structures when writing algorithms:

``` python
# note both dictionairy and set comprehensions use {} which may be confusing at first
even_squares_dict = {x: x ** 2 for x in a if x % 2 == 0}
threes_cubed_set = {x ** 3 for x in a if x % 3 == 0}
print(even_squares_dict)
print(threes_cubed_set)
```

    {2: 4, 4: 16, 6: 36, 8: 64, 10: 100}
    {216, 729, 27}

Achieving the same outcome is possible with map and filter if you wrap each call with a corresponding constructor. These statements get so long that you have to break them up across multiple lines, which is even noisier and should be avoided:

``` python
alt_dict = dict(map(lambda x: (x, x ** 2), filter(lambda x: x % 2 == 0, a)))
alt_set = set(map(lambda x: x ** 3, filter(lambda x: x % 3 == 0, a)))
```

### \#14. Avoid more than two control subexpressions in comprehensions (EP \#28)

Beyond basic usage, comprehensions support multiple levels of looping. For example, say that I want to simplify a matrix (a `list` containing other `list` instances) into one flat `list` of all cells. Here, I do this with a list comprehension by including two for subexpressions. These subexpressions run in the order provided, from left to right:

``` python
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
flat = [x for row in matrix for x in row]
print(flat)
```

    [1, 2, 3, 4, 5, 6, 7, 8, 9]

This example is simple, readable, and a reasonable usage of multiple loops in a comprehension. Another reasonable usage of multiple loops involves replicating the two-level-deep layout of the input `list`. For example, say that I want to square the value in each cell of a twodimensional matrix. This comprehension is noisier because of the extra `[]` characters, but it’s still relatively easy to read:

``` python
squared = [[x ** 2 for x in row] for row in matrix]
print(squared)
```

    [[1, 4, 9], [16, 25, 36], [49, 64, 81]]

If this comprehension included another loop, it would get so long that I’d have to split it over multiple lines:

``` python
my_lists = [
    [[1, 2, 3], [4, 5, 6]],
]
flat = [x for sublist1 in my_lists for sublist2 in sublist1 for x in sublist2]
```

At this point, the multiline comprehension isn’t much shorter than the alternative. Here, I produce the same result using normal loop statements. The indentation of this version makes the looping clearer than the three-level-list comprehension:

``` python
flat = []
for sublist1 in my_lists:
    for sublist2 in sublist1:
        flat.extend(sublist2)
```

Comprehensions support multiple `if` conditions. Multiple conditions at the same loop level have an implicit `and` expression. For example, say that I want to filter a `list` of numbers to only even values greater than 4. These two list comprehensions are equivalent:

``` python
a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
b = [x for x in a if x > 4 if x % 2 == 0]
c = [x for x in a if x > 4 and x % 2 == 0]
```

Conditions can be specified at each level of looping after the `for` subexpression. For example, say I want to filter a matrix so the only cells remaining are those divisible by 3 in rows that sum to 10 or higher. Expressing this with a list comprehension does not require a lot of code, but it is extremely difficult to read:

``` python
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
filtered = [[x for x in row if x % 3 == 0] for row in matrix if sum(row) >= 10]
print(filtered)
```

    [[6], [9]]

Although this example is a bit convoluted, in practice you’ll see situations arise where such comprehensions seem like a good fit. I strongly encourage you to avoid using `list`, `dict`, or `set` comprehensions that look like this. The resulting code is very difficult for new readers to understand. The potential for confusion is even worse for dict comprehensions since they already need an extra parameter to represent both the key and the value for each item.

The rule of thumb is to avoid using more than two control subexpressions in a comprehension. This could be two conditions, two loops, or one condition and one loop. As soon as it gets more complicated than that, you should use normal if and for statements and write a helper function.

## pandas

### \#15. Be aware of memory consumption and downcast where necessary

For larger datasets, it pays off to optimize memory usage by converting string columns to categorical, and downcasting numeric columns. Use `df.info()` to get a first view. We will demonstrate this with the Ames housing dataset, which in itselft is not so large (1.8 MB). If anything gets beyond hundreds of MBs in memory, it helps to optimize, by using pd.to_numeric(downcast=…) and converting categorical variables to pd.categorical. Doing so reduces the memory to 22% of the orginal (400 KB).

``` python
df = pd.read_csv(
    "https://github.com/eaisi/discover-projects/blob/main/ames-housing/AmesHousing.csv?raw=true"
)
df.memory_usage().sum()
```

    1922208

``` python
# objects to categorical
df[df.select_dtypes(include="object").columns] = df.select_dtypes(
    include="object"
).astype("category")

# convert integers to smallest unsigned integer and floats to smallest
for old, new in [("integer", "unsigned"), ("float", "float")]:
    for col in df.select_dtypes(include=old).columns:
        df[col] = pd.to_numeric(df[col], downcast=new)

df.memory_usage().sum()
```

    419054

### \#16. Use `.loc` and `.iloc` for indexing dataframes (and forget about `.ix`)

One-third of the top-15 voted [pandas questions on Stackoverflow](http://stackoverflow.com/questions/tagged/pandas?sort=votes&pageSize=15) are about indexing. Another one-third are about slicing. This seems as good a place as any to start.

By indexing, we mean the selection of subsets of a `DataFrame` or `Series`. `DataFrames` (and to a lesser extent, `Series`) provide a difficult set of challenges:

- Like lists, you can index by location.
- Like dictionaries, you can index by label.
- Like NumPy arrays, you can index by boolean masks.
- Any of these indexers could be scalar indexes, or they could be arrays, or they could be slices.
- Any of these should work on the index (row labels) or columns of a DataFrame.
- And any of these should work on hierarchical indexes.

The complexity of pandas’ indexing is a microcosm for the complexity of the pandas API in general. There’s a reason for the complexity (well, most of it), but that’s not much consolation while you’re learning. Still, all of these ways of indexing really are useful enough to justify their inclusion in the library.

Since pandas 0.12, these tasks have been cleanly separated into two methods:

1.  `.loc` for label-based indexing
2.  `.iloc` for positional indexing

Previously, `.ix` was used to handle both cases. You may encounter this in old blog-posts. `.ix` is deprecated, so stop using it.

For more details, please read any (or all) of the following online tutorials: - [Using Pandas and Python To Explore Your Dataset](https://realpython.com/pandas-python-explore-dataset/) on Real Python; - [Data Indexing and Slicing notebok](https://github.com/jads-nl/PythonDataScienceHandbook/blob/8a34a4f653bdbdc01415a94dc20d4e9b97438965/notebooks/03.02-Data-Indexing-and-Selection.ipynb) by Jake VanderPlas - [pandas documentation on indexing and selecting data](https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#different-choices-for-indexing)

### \#17. Use method chaining to make your data preparation more readable

Method chaining, where you call methods on an object one after another, is in vogue at the moment. It’s always been a style of programming that’s been possible with pandas:

- [assign](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.assign.html) (0.16.0): For adding new columns to a DataFrame in a chain (inspired by dplyr’s mutate)
- [pipe](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.pipe.html) (0.16.2): For including user-defined methods in method chains.
- [rename](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.rename.html) (0.18.0): For altering axis names (in additional to changing the actual labels as before).
- [Window methods](https://pandas.pydata.org/docs/user_guide/window.html) (0.18): Took the top-level pd.rolling\_\* and pd.expanding\_\* functions and made them NDFrame methods with a groupby-like API.
- [Resample](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.resample.html) (0.18.0) Added a new groupby-like API
- [selection by callable](https://pandas.pydata.org/docs/user_guide/indexing.html#selection-by-callable) (0.18.1): You can pass a callable to the indexing methods, to be evaluated within the DataFrame’s context (like .query, but with code instead of strings).

To illustrate the potential of method chaining, let’s look at this example with the Titanic dataset which explores the data of passengers that have embarked in Southampton:

``` python
import sys
import pandas as pd


TITANIC_DATA = "https://github.com/BindiChen/machine-learning/blob/master/data-analysis/007-method-chaining/data/train.csv?raw=true"
bins = [0, 13, 19, 61, sys.maxsize]
labels = ["<12", "Teen", "Adult", "Older"]

pclass_age_map = {
    1: 37,
    2: 29,
    3: 24,
}


def replace_age_na(x_df, fill_map):
    cond = x_df["Age"].isna()
    res = x_df.loc[cond, "Pclass"].map(fill_map)
    x_df.loc[cond, "Age"] = res
    return x_df
```

``` python
view_southampton = (
    pd.read_csv(TITANIC_DATA)
    .pipe(replace_age_na, pclass_age_map)
    .query('Embarked == "S"')
    .assign(ageGroup=lambda df: pd.cut(df["Age"], bins=bins, labels=labels))
    .pivot_table(values="Survived", columns="Pclass", index="ageGroup", aggfunc="mean")
    .rename_axis("", axis="columns")
    .rename("Class {}".format, axis="columns")
    .style.format("{:.2%}")
)

view_southampton
```

|          | Class 1 | Class 2 | Class 3 |
|----------|---------|---------|---------|
| ageGroup |         |         |         |
| \<12     | 75.00%  | 100.00% | 37.14%  |
| Teen     | 80.00%  | 40.00%  | 17.78%  |
| Adult    | 58.10%  | 40.77%  | 16.61%  |
| Older    | 25.00%  | 33.33%  | 50.00%  |

``` python
_string = 'sdfjghsdfgjk'

def clean_string(str):
    return _string.upper().replace('S', 'Z')
```

``` python
lambda s: s.upper().replace('S', 'Z')
```

    <function __main__.<lambda>(s)>

Read more on method chaining in these tutorials:

- [Best practice method chaining](https://towardsdatascience.com/using-pandas-method-chaining-to-improve-code-readability-d8517c5626ac) by B. Chen (with the Titanic example).
- [Tom Augspurger’s explanation on method chaining](https://tomaugspurger.github.io/method-chaining) goes a bit more in depth on the reasoning and rationale behind it.

### \#18. Don’t use `inplace=True` operations on dataframes

Most pandas methods have an `inplace` keyword that’s `False` by default. In general, you shouldn’t do inplace operations.

First, if you like method chains then you simply can’t use inplace since the return value is `None`, terminating the chain.

Second, I suspect people have a mental model of inplace operations happening, you know, inplace. That is, extra memory doesn’t need to be allocated for the result. But that might not actually be true. Quoting Jeff Reback from that answer

> Their is no guarantee that an inplace operation is actually faster. Often they are actually the same operation that works on a copy, but the top-level reference is reassigned.

That is, the pandas code might look something like this

``` python
def dataframe_method(self, inplace=False):
    data = self.copy()  # regardless of inplace
    result = ...
    if inplace:
        self._update_inplace(data)
    else:
        return result
```

There’s a lot of defensive copying in pandas. Part of this comes down to pandas being built on top of NumPy, and not having full control over how memory is handled and shared. Without the copy, adding the columns would modify the input DataFrame, which just isn’t polite.

Finally, inplace operations don’t make sense in projects like ibis or dask, where you’re manipulating expressions or building up a DAG of tasks to be executed, rather than manipulating the data directly.

### \#19. Use `.query` and `eval` for fast, complex indexing

The power of the PyData stack is built upon the ability of NumPy and pandas to push basic operations into C via an intuitive syntax: examples are vectorized/broadcasted operations in NumPy, and grouping-type operations in pandas. While these abstractions are efficient and effective for many common use cases, they often rely on the creation of temporary intermediate objects, which can cause undue overhead in computational time and memory use.

As of version 0.13 (released January 2014), pandas includes some experimental tools that allow you to directly access C-speed operations without costly allocation of intermediate arrays. These are the `eval()` and `query()` functions, which rely on the Numexpr package.

Please refer to the following notebooks and documentation on how and when to use them: - [High-Performance Pandas: eval() and query()](https://github.com/jads-nl/PythonDataScienceHandbook/blob/8a34a4f653bdbdc01415a94dc20d4e9b97438965/notebooks/03.12-Performance-Eval-and-Query.ipynb) by Jake VanderPlas - [pandas user guide on the query() method](https://pandas.pydata.org/docs/user_guide/indexing.html#the-query-method)
