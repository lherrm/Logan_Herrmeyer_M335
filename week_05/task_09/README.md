Tidy data has these 3 rules:
1. Each variable must have its own column.
2. Each observation must have its own row.
3. Each value must have its own cell. 
Pivoting can solve these 2 problems:
1. One variable might be spread across multiple columns.
2. One observation might be scattered across multiple rows.
pivot_longer() is used  when some column names are not names of variables, but instead values of a variable. (For example a column called '1999' and another '2000').
An example:
```
table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")
```
pivot_wider() is used when an observation is spread across multiple rows.
The first argument is the column to take variable names from, and the second is the column to take values from.
For example:
```
table2 %>%
    pivot_wider(names_from = type, values_from = count)
```
seperate() pulls 1 column apart into 2 by splitting by a seperator character.
By default it will seperate by a non-alphanum character, but it can be specified with the sep argument.
Example:
```
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")
```
Unite joins columns (default seperator is underscore, can be changed with sep). 
For example:
```
table5 %>% 
  unite(new, century, year)
```
fill() carries forward previous column values, either forward or backward.
"complete() takes a set of columns, and finds all unique combinations. It then ensures the original dataset contains all those values, filling in explicit NAs where necessary."