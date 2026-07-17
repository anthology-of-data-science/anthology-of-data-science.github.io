# Composable data platforms

Slides from a 3-hour guest lecture given at Strathmore University.

Author

Daniel Kapitan

Published

July 2, 2024

# Modern, open and downward-scaleable data engineering

Getting started with the composable data stack

Dr Daniel Kapitan [![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo1N0NEMjA4MDI1MjA2ODExOTk0QzkzNTEzRjZEQTg1NyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDozM0NDOEJGNEZGNTcxMUUxODdBOEVCODg2RjdCQ0QwOSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozM0NDOEJGM0ZGNTcxMUUxODdBOEVCODg2RjdCQ0QwOSIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1IE1hY2ludG9zaCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkZDN0YxMTc0MDcyMDY4MTE5NUZFRDc5MUM2MUUwNEREIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjU3Q0QyMDgwMjUyMDY4MTE5OTRDOTM1MTNGNkRBODU3Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+84NovQAAAR1JREFUeNpiZEADy85ZJgCpeCB2QJM6AMQLo4yOL0AWZETSqACk1gOxAQN+cAGIA4EGPQBxmJA0nwdpjjQ8xqArmczw5tMHXAaALDgP1QMxAGqzAAPxQACqh4ER6uf5MBlkm0X4EGayMfMw/Pr7Bd2gRBZogMFBrv01hisv5jLsv9nLAPIOMnjy8RDDyYctyAbFM2EJbRQw+aAWw/LzVgx7b+cwCHKqMhjJFCBLOzAR6+lXX84xnHjYyqAo5IUizkRCwIENQQckGSDGY4TVgAPEaraQr2a4/24bSuoExcJCfAEJihXkWDj3ZAKy9EJGaEo8T0QSxkjSwORsCAuDQCD+QILmD1A9kECEZgxDaEZhICIzGcIyEyOl2RkgwAAhkmC+eAm0TAAAAABJRU5ErkJggg==)](https://orcid.org/0000-0001-8979-9194)

<daniel@kapitan.net>

Eindhoven AI Systems Institute

September 8, 2024

## Attribution & copyright notice

This lecture is based on the following open access materials:

- Voltron Data, [The Composable Codex](https://voltrondata.com/codex/a-new-frontier)
- Cody Peterson, [Modern, hybrid, open analytics](https://anthology-of-data.science/posts/ibis-analytics/)
- Thierry Jean, [Portable dataflows with Ibis and Hamilton](https://anthology-of-data.science/posts/hamilton-ibis/)
- Documentation of the following Python libraries: [DuckDB](https://duckdb.org/docs/), [Ibis](https://ibis-project.org), [hamilton](https://github.com/dagworks-inc/hamilton), [polars](https://docs.pola.rs/), [Shiny for Python](https://shiny.posit.co/py/)

Source code: <https://github.com/anthology-of-data-science/lecture-composable-data-stack>

Daniel Kapitan, *Modern, open and downward-scaleable data engineering*.  
This work is licensed under [CC BY-SA 4.0![](https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1)![](https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1)![](https://mirrors.creativecommons.org/presskit/icons/sa.svg?ref=chooser-v1)](https://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1)

## Learning objectives

  

### Understand the problem

- how data platforms evolved in the past couple of decades
- current problems with data platforms
- what concepts underlie the composable data stack
- what concepts underlie modern data engineering workflows

### Know how to

- Build end-to-end data pipeline using open source implementations of the composable data stack
- Apply best practices of functional data engineering
- Apply the split-apply-combine strategy with various syntaxes

### Reflect

- on how this impact your (future) work as a data engineer
- on the pro’s and con’s of open standards and open source

# Understand the problem

## The problem

### The ML/AI/Data (MAD) Landscape

Source: <https://mad.firstmark.com/>

## The Composable Data Management System Manifesto

  

> *The requirement for specialization in data management systems has evolved faster than our software development practices. After decades of organic growth, this situation has created a **siloed landscape** composed of hundreds of products developed and maintained as monoliths, with limited reuse between systems. This fragmentation has resulted in developers often reinventing the wheel, **increased maintenance costs, and slowed down innovation**. It has also affected the end users, who are often required to learn the **idiosyncrasies of dozens of incompatible SQL and non-SQL API dialects**, and settle for systems with incomplete functionality and inconsistent semantics.*

Pedreira, Pedro, et al. [The composable data management system manifesto.](https://dl.acm.org/doi/10.14778/3603581.3603604) Proceedings of the VLDB Endowment 16.10 (2023): 2679-2685.

## Let’s start at the beginning

### Edgar Codd invents relational algebra (1970)

E. F. Codd. [A relational model of data for large shared data banks.](https://doi.org/10.1145/362384.362685) Commun. ACM 13, 6 (June 1970), 377–387.

## Standard Query Language (SQL)

### Still the most important language for a data engineer

Source: Jadwiga Wilkens on Medium. [The Best BigQuery SQL Cheat Sheet for Beginners.](https://medium.com/data-school/the-best-bigquery-sql-cheat-sheet-for-beginners-81c762f72845)

## Evolution of data platfom architectures

Armbrust, Michael, et al. [Lakehouse: a new generation of open platforms that unify data warehousing and advanced analytics.](https://15721.courses.cs.cmu.edu/spring2023/papers/02-modern/armbrust-cidr21.pdf) Proceedings of CIDR. Vol. 8. 2021.

## Towards a data-centric future

  

| NOW: Application-Centric | FUTURE: Data-Centric |
|----|----|
| Exorbitant, often prohibitive, cost of change. Reasonable cost of change. | Data is tied up in applications because applications own data. Data is an open resource that outlives any given application. |
| Every new project comes with a big data conversion project. | Every new project taps into existing data stores. |
| Data exists in wide variety of heterogeneous formats, structures, meaning, and terminology. | Data is globally integrated sharing a common meaning, being exported from a common source into any needed format. |
| Data integration consumes 35%-65% of IT budget. | Data integration will be nearly free. |
| Hard or impossible to integrate external data with internal data. | Internal and external data readily integrated. |

Source: [The Data-Centric Manifesto: Principles](http://datacentricmanifesto.org/principles/).

## 

# Understand open standards for data platforms

## Decomposing the venerable relational database management system (RDBMS)

Source: Basil Borque on [Stackoverflow](https://stackoverflow.com/questions/7022755/whats-the-difference-between-a-catalog-and-a-schema-in-a-relational-database)

## Decomposing the database into open standards

## Arrow: from row-based to column-based tables

### Columnar is faster for analytical processing

Source: [Apache Arrow overview](https://arrow.apache.org/overview/).

## Standardization saves time and resources

### No costly serialization/deserialization, no custom implementations

  

Source: [Apache Arrow overview](https://arrow.apache.org/overview/).

## JDBC/ODBC: row-based database connectivity protocols

### Less suitable for analytical workloads

Source: [Apache Arrow: Introducing ADBC](https://arrow.apache.org/blog/2023/01/05/introducing-arrow-adbc/).

## Arrow Database Connectivity (ADBC)

### A single API for getting Arrow data in and out of different databases

Source: [Apache Arrow: Introducing ADBC](https://arrow.apache.org/blog/2023/01/05/introducing-arrow-adbc/).

## Iceberg: an open table format and catalog

### Basically, a database engine in files

  

Source: [Apache Iceberg specification](https://iceberg.apache.org/spec/).

## Iceberg catalog

### We still need a (small) database

Source: [Apache Iceberg: An Architectural Look Under the Covers](https://www.dremio.com/resources/guides/apache-iceberg-an-architectural-look-under-the-covers/?utm_source=pocket_shared).

## Iceberg metadata file

### Stores schema, partition information and snapshots

Source: [Apache Iceberg: An Architectural Look Under the Covers](https://www.dremio.com/resources/guides/apache-iceberg-an-architectural-look-under-the-covers/?utm_source=pocket_shared).

## Iceberg manifest list

### Stores information about each manifest file that makes up a snapshot

Source: [Apache Iceberg: An Architectural Look Under the Covers](https://www.dremio.com/resources/guides/apache-iceberg-an-architectural-look-under-the-covers/?utm_source=pocket_shared).

## Iceberg manifest file

### Track data files as well as additional details and statistics about each file

Source: [Apache Iceberg: An Architectural Look Under the Covers](https://www.dremio.com/resources/guides/apache-iceberg-an-architectural-look-under-the-covers/?utm_source=pocket_shared).

## Iceberg in practice

### Creating a table

  

``` numberSource
CREATE TABLE table1 (
    order_id BIGINT,
    customer_id BIGINT,
    order_amount DECIMAL(10, 2),
    order_ts TIMESTAMP
)
USING iceberg
PARTITIONED BY ( HOUR(order_ts) );
```

Source: [Apache Iceberg: An Architectural Look Under the Covers](https://www.dremio.com/resources/guides/apache-iceberg-an-architectural-look-under-the-covers/?utm_source=pocket_shared).

## Iceberg in practice

### Result of creating a table

  

Source: [Apache Iceberg: An Architectural Look Under the Covers](https://www.dremio.com/resources/guides/apache-iceberg-an-architectural-look-under-the-covers/?utm_source=pocket_shared).

## Iceberg in practice

### Inserting data

  

``` numberSource
INSERT INTO table1 VALUES (
    123,
    456,
    36.17,
    '2021-01-26 08:10:23'
);
```

Source: [Apache Iceberg: An Architectural Look Under the Covers](https://www.dremio.com/resources/guides/apache-iceberg-an-architectural-look-under-the-covers/?utm_source=pocket_shared).

## Iceberg in practice

### Result of inserting data

  

Source: [Apache Iceberg: An Architectural Look Under the Covers](https://www.dremio.com/resources/guides/apache-iceberg-an-architectural-look-under-the-covers/?utm_source=pocket_shared).

## Iceberg in practice

### Merge into/upserting data

  

``` numberSource
MERGE INTO table1
USING ( SELECT * FROM table1_stage ) s
    ON table1.order_id = s.order_id
WHEN MATCHED THEN
    UPDATE table1.order_amount = s.order_amount
WHEN NOT MATCHED THEN
    INSERT *
```

Source: [Apache Iceberg: An Architectural Look Under the Covers](https://www.dremio.com/resources/guides/apache-iceberg-an-architectural-look-under-the-covers/?utm_source=pocket_shared).

## Iceberg in practice

### Result of merging into/upserting data

  

Source: [Apache Iceberg: An Architectural Look Under the Covers](https://www.dremio.com/resources/guides/apache-iceberg-an-architectural-look-under-the-covers/?utm_source=pocket_shared).

## Iceberg in practice

### Merge into/upserting data

  

``` numberSource
SELECT *
FROM db1.table1
```

Source: [Apache Iceberg: An Architectural Look Under the Covers](https://www.dremio.com/resources/guides/apache-iceberg-an-architectural-look-under-the-covers/?utm_source=pocket_shared).

## Iceberg in practice

### Result of select statement

  

Source: [Apache Iceberg: An Architectural Look Under the Covers](https://www.dremio.com/resources/guides/apache-iceberg-an-architectural-look-under-the-covers/?utm_source=pocket_shared).

# Understand the composable data stack

## The Data Science Hierachy of Needs

### All you need is MICE

## The Composable Data Stack

### Layers

## The Composable Data Stack

### Standards

## The Composable Data Stack

### Subtstrait for Intermediate Representation (IR)

## The Composable Data Stack

### Arrow for connectivity and data memory layout

## Big Data Is Dead

Source: Jordan Tigani, [Big Data Is Dead.](https://motherduck.com/blog/big-data-is-dead/)

## You can work with 100s GB of data on a single machine

### All you need is a PC and some open source libraries

Source: The Data Quarry::blog [Embedded databases (1): The harmony of DuckDB, KùzuDB and LanceDB.](https://thedataquarry.com/posts/embedded-db-1/)

# Know How To

## From components to a whole platform architecture

Source: Andreessen Horowitz, [Emerging Architectures for Modern Data Infrastructure](https://a16z.com/emerging-architectures-for-modern-data-infrastructure/).

## The Composable Data Stack in Practice

### Let’s get into building an end-to-end stack

## The Pipeline Pattern

### Directed Acyclyc Graphs, ETL/ELT and functional data engineering

  

Source: [Hamilton](https://hamilton.dagworks.io/en/latest/).

## Dagster

### Software-Defined Assets

Source: Dagster [Introducing Software-Defined Assets.](https://dagster.io/blog/software-defined-assets)

## Walk-through end-to-end pipeline

### Points of interest

  

- Overall structure of the project
- Managing your workflow: [`just`](https://just.systems/)
- Writing pipelines: functions, functions, functions
- Inspecting your DAG with Dagster
- Materializing assets
- Dashboard

## The split-apply-combine strategy for data analysis

  

Wickham, H. (2011). The Split-Apply-Combine Strategy for Data Analysis. Journal of Statistical Software, 40(1), 1–29. [https://doi.org/10.18637/jss.v040.i01](https://www.jstatsoft.org/article/view/v040i01)

## The split-apply-combine strategy for data analysis

### Overview data transformations in different libraries

  

| concept | pandas | polars | ibis | PySpark | dplyr | SQL |
|----|----|----|----|----|----|----|
| **split** | groupby() | group_by() | group_by() | groupBy() | group_by() | GROUP BY |
| **combine** | join (), merge() | join() | left_join, inner_join() etc. | join() | left_join, inner_join() etc. | LEFT JOIN, JOIN etc. |
| **filtering (row based)** | loc\[\], query() | filter() | filter() | filter() | filter() | WHERE |
| **select (column based)** | loc\[\], iloc\[\], | select() | select() | select() | select() | SELECT |
| **mutate** | assign() | with_columns() | mutuate() | withColumn() | mutate() | ADD |
| **ordering** | sort_values() | sort() | order_by() | orderBy() | arrange() | ORDER BY |

## Method chaining

### Using functions the bad way

``` numberSource
tumble_after(
    broke(
        fell_down(
            fetch(went_up(jack_jill, "hill"), "water"),
            jack),
        "crown"),
    "jill"
)
```

### … vs. the more readable way

``` numberSource
(jack_jill
  .went_up("hill")
  .fetch("water")
  .fell_down("jack")
  .broke("crown")
  .tumble_after("jill")
```

Source: Tom’s (Augspurger) Blog. [Method Chaining](https://tomaugspurger.net/posts/method-chaining/).

## Naming of table hierarchy differs across backends

### Ibis uses catalog –\> database –\> table

| Backend    | Catalog        | Database   |
|------------|----------------|------------|
| bigquery   | project        | database   |
| clickhouse |                | database   |
| datafusion | catalog        | schema     |
| druid      | dataSourceType | dataSource |
| duckdb     | database       | schema     |
| flink      | catalog        | database   |
| impala     |                | database   |
| mssql      | database       | schema     |
| mysql      |                | database   |
| postgres   | database       | schema     |
| pyspark    |                | database   |
| snowflake  |                | database   |
| trino      | catalog        | schema     |

Source: [Ibis documentation.](https://ibis-project.org/backend_table_hiearchy.html)

## Working with nested data

### Gotcha! Unforunately there is no standard naming yet …

  

| operation | ibis | polars | duckdb |
|----|----|----|----|
| Flatten `Array` into multiple rows | [`ArrayValue.unnest()`](https://ibis-project.org/reference/expression-collections.html#ibis.expr.types.arrays.ArrayValue.unnest) | [`DataFrame.explode()`](https://docs.pola.rs/api/python/stable/reference/dataframe/api/polars.DataFrame.explode.html#polars.DataFrame.explode) | [`UNNEST`](https://duckdb.org/docs/sql/query_syntax/unnest.html) |
| Unnest `Struct` into multiple columns | [`Table.unpack(*columns)`](https://ibis-project.org/reference/expression-tables#ibis.expr.types.relations.Table.unpack) | [`DataFrame.unnest()`](https://docs.pola.rs/api/python/stable/reference/dataframe/api/polars.DataFrame.unnest.html) | [`UNNEST`](https://duckdb.org/docs/sql/query_syntax/unnest.html) |

Ibis also has methods that operate directly on a column of structs:

- [`StructValue.destructure()`](https://ibis-project.org/reference/expression-collections#ibis.expr.types.structs.StructValue.destructure)
- [`StructValue.lift()`](https://ibis-project.org/reference/expression-collections#ibis.expr.types.structs.StructValue.lift)

## You can swap components to your hearts content

### My personal preferences

  

| component | Ibis analytics demo | My preference |
|----|----|----|
| Workflow orchestration | [Dagster](https://docs.dagster.io/getting-started) | [Hamilton](https://hamilton.dagworks.io/en/latest/) |
| Persistent storage | parquet, native DuckDB files | [Apache Iceberg](https://py.iceberg.apache.org/) |
| Dashboarding app | [Streamlit](https://docs.streamlit.io/) | [Shiny for Python](https://shiny.posit.co/py/docs/overview.html), [Quarto](https://quarto.org) |
| Visualization | [plotly](https://plotly.com/python/) | [vega-altair](https://altair-viz.github.io/) |

## Stuff we haven’t covered yet

### …and will definitely give you a headache in future projects

  

- [Change Data Capture (CDC)](https://en.wikipedia.org/wiki/Change_data_capture): determine and track data that has changed at the source, such that you only have to process the ‘deltas’
- Setup and manage access control mechanisms in an operational data platform
- Provide documentation for non-technical users
- Reporting on data quality

# Reflect

## Group discussion

### What are your main take-outs?

## Thanks for your attention.

<https://anthology-of-data.science>

(view [full screen](https://anthology-of-data.science/lecture-composable-data-stack/#/title-slide))
