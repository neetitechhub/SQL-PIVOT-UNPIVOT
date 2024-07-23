# SQL-PIVOT-UNPIVOT

**Pivot: Converts rows into columns, typically used for aggregating and summarizing data in a crosstab format.**
**Unpivot: Converts columns into rows, typically used for normalizing data and making it easier to work with in a row-based format.**

**Pivoting and unpivoting are operations used to transform data in SQL.**

**Pivot:** Transform rows into columns. This is useful when you want to aggregate data and present it in a cross-tabulated format.

Working: Aggregates data based on one or more columns and spreads the aggregated values into new columns.

Use Case: Displaying sales data where each row represents a product, and columns represent different months with sales amounts.

**Unpivot:** Transform columns into rows. This is useful when you need to normalize data or convert wide-format tables into a more traditional row-based format.

Working: Converts multiple columns into a single column with an additional column that indicates the original column names.

Use Case: Normalizing a table where each column represents a different month’s sales data into a format where each row represents a single month’s sales data.

**Pivoting Example -**

<img width="337" alt="image" src="https://github.com/user-attachments/assets/db565f5b-bab7-40bc-8fc3-634e4d050fc9">


**Unpivoting Example -**

<img width="317" alt="image" src="https://github.com/user-attachments/assets/9d163343-3570-4015-9011-996f80c2ccb4">
