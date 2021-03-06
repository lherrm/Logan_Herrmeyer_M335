---
title: "Task 15"
author: "Logan Herrmeyer"
date: "June 07, 2021"
output:
  html_document:  
    keep_md: true
    toc: true
    toc_float: true
    fig_height: 6
    fig_width: 12
    fig_align: 'center'
---



```r
library(pacman)
pacman::p_load(tidyverse)
```

## Text analysis

### Reading in the strings


```r
ltrs <- read_lines("https://byuistats.github.io/M335/data/randomletters.txt")
ltr_nums <- read_lines("https://byuistats.github.io/M335/data/randomletters_wnumbers.txt") 
```

### Hidden quote


```r
# Sequence of counting by 1700s
my_seq <- seq(from=1700,to=1700*50,by=1700)
# Include the first letter
my_seq <- append(1, my_seq)
# Get substrings of indicies in sequence and combine into string.
str_0 <-  str_c(str_sub(ltrs, my_seq, my_seq), collapse='')
# Get rid of text past period and print
str_replace(str_0, "[.].*", ".")
```

```
## [1] "the plural of anecdote is not data."
```
"The plural of anecdote is not data."

### Hidden letters in numbers


```r
# Function to convert number to letter
l2n <- function(x){return(letters[as.numeric(x)])}
 # Get all strings of 1+ digits in the text
nums <- str_extract_all(ltr_nums,"\\d+")
# Convert to letters
lets <- c(sapply(nums, l2n))
# Convert list of letters to string
str_c(lets, collapse = '')
```

```
## [1] "expertsoftenpossessmoredatathanjudgment"
```

"Experts often possess more data than judgement."

### Vowel sequence


```r
# Remove spaces/periods
ltrs2 <- str_replace_all(ltrs, "\\s|\\.", "")
# Make sure everything is lower case
ltrs2 <- str_to_lower(ltrs2)
# Get all vowel sequences
v_strs <- str_extract_all(ltrs, "[aeiou]+")[[1]]
# Convert to data frame
v_tbl <- as_tibble_col(v_strs, column_name = "str")
# Get the longest vowel sequence and print it
v_tbl %>%
    mutate(len = nchar(str)) %>%
    arrange(-len) %>%
    head(1) %>%
    pull(str)
```

```
## [1] "oaaoooo"
```

The longest vowel sequence is "oaaoooo", at 7 characters.
