---
title: "Task 17"
author: "Logan Herrmeyer"
date: "June 15, 2021"
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
pacman::p_load(tidyverse, lubridate)
waitlist <- read_csv("https://byuistats.github.io/M335/data/waitlist_DP_108.csv")
waitlist <- waitlist %>% mutate(date = lubridate::mdy_hm(`Registration Date`))
waitlist <- waitlist %>% filter(`Course Sec` == "FDMAT108-18")
```

## Function 1


```r
# Create a function that calculates the % of currently registered students who were at one time on the waitlist.
# Numerators are the same for both functions
# Numerator = number of currently registered students that were at one point on the waitlist
# Denominator = number of currently registered students total
# P(person was on the waitlist at some point | person currently registered)
# Apply conditional probability formula
# P(was on waitlist & currently reg.) / P(currently reg.)
f1 <- function(dat){
  # Get all currently registered people and count
  registered_people <- dat %>%
    filter(Status == "Registered") %>%
    distinct(`Person ID`) %>%
    pull(`Person ID`)
  num_reg <- length(registered_people)
  
  # Get num people who were on the wait list and who are also currently registered
  num_waitlist_and_reg <- dat %>%
    filter(Status == "Wait List") %>%
    filter(`Person ID` %in% registered_people) %>%
    distinct(`Person ID`) %>%
    count() %>%
    pull()
  
  # Calculate the conditional probability
  # (# waitlisted ppl regd) / (# total ppl regd)
  return((num_waitlist_and_reg/num_reg) * 100)
}
f1(waitlist)
```

```
## [1] 20.77922
```

## Function 2


```r
# Create a function that calculates the % of students who were ever on the waitlist that are currently registered for for the class.
# Numerator = number of currently registered students that were at one point on the waitlist
# Denominator = number of students who were at one point on the waitlist
# P(person registered for the class | person ever on waitlist)
# Apply conditional probability formula:
# P(registered for class & ever on waitlist) | P(ever on waitlist)
f2 <- function(dat){
  # Get all currently registered people
  registered_people <- dat %>%
    filter(Status == "Registered") %>%
    distinct(`Person ID`) %>%
    pull(`Person ID`)
  
  # Get num people who were on the wait list and who are also currently registered
  num_waitlist_and_reg <- dat %>%
    filter(Status == "Wait List") %>%
    filter(`Person ID` %in% registered_people) %>%
    distinct(`Person ID`) %>%
    count() %>%
    pull()
  
  # Get num people who were ever on the waitlist
  num_waitlist <- dat %>%
    filter(Status == "Wait List") %>%
    distinct(`Person ID`) %>%
    count() %>%
    pull()
  
  # Calculate the conditional probability
  # (# waitlisted ppl regd)/(# total waitlisted ppl)
  return((num_waitlist_and_reg/num_waitlist) * 100)
}
f2(waitlist)
```

```
## [1] 25.80645
```

