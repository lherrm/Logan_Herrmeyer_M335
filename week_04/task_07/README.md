* R data frames have different data types (int, dbl, chr, ddtm [date-time])
* dplyr has 5 key functions for manipulating data:
** filter() (pick observations by values)
** arrange() (reorder rows)
** select() (pick variables by names)
** mutate() (create new variables with functions of existing ones)
** summarise() (collapse many values down to a single summary)
* All dyplr verbs have the first argument a data frame, the following arguments say what to do with the data frame, and it returns a data frame.