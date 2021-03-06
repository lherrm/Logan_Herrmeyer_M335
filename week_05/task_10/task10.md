---
title: "Task 10"
author: "Logan Herrmeyer"
date: "May 20, 2021"
output:
  html_document:  
    keep_md: true
    toc: true
    toc_float: true
    fig_height: 6
    fig_width: 12
    fig_align: 'center'
---



## Reading Notes

A temporarily file is needed for readxl, can be made with the tempfile() function.

The readr library has 3 main functions: read_csv(), read_fwf (fixed width file), and read_log() (Apache log files).

Parser functions get data vectors into the right data type.

## Task 10


```r
library(pacman)
pacman::p_load(tidyverse)
pacman::p_load(readr)
pacman::p_load(haven)
pacman::p_load(readxl)
pacman::p_load(downloader)
```

## Loading the data

### File 1 (XLSX)


```r
my_url <- "https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.xlsx?raw=true"
temp <- tempfile()
download(my_url, temp, mode = "wb")
df_xlsx <- read_xlsx(temp)
```

### File 2 (RDS)


```r
my_url <- "https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.RDS?raw=true"
df_rds <- read_rds(url(my_url))
```

### File 3 (CSV)


```r
my_url <- "https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.csv?raw=true"
df_csv <- read_csv(url(my_url))
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   contest_period = col_character(),
##   variable = col_character(),
##   value = col_double()
## )
```

### File 4 (DTA)

```r
my_url <- "https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.dta?raw=true"
df_dta <- read_dta(url(my_url))
```

### File 5 (SAV)

```r
my_url <- "https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.sav?raw=true"
df_sav <- read_sav(url(my_url))
```

## Comparing the data


```r
# all.equal was acting weirdly, dplyr::all_equal works better
# all.equal complains about attributes, which are not important. all_equal just looks at the data itself.
all_equal(df_xlsx, df_rds)
```

```
## [1] TRUE
```

```r
all_equal(df_xlsx, df_csv)
```

```
## [1] TRUE
```

```r
all_equal(df_xlsx, df_dta)
```

```
## [1] "- Different types for column `contest_period`: character vs character\n- Different types for column `variable`: character vs character\n- Different types for column `value`: double vs double\n"
```

```r
all_equal(df_xlsx, df_sav)
```

```
## [1] "- Different types for column `contest_period`: character vs character\n- Different types for column `variable`: character vs character\n- Different types for column `value`: double vs double\n"
```

```r
# The data type thing is a minor concern
```

## Graphic


```r
ggplot(df_csv, aes(x=variable, y=value)) +
  geom_boxplot() +
  geom_jitter(width=0.2, color="steelblue") +
  stat_summary(fun=mean, geom="point",shape=23, size=4, fill="red", color="red") +
  theme_bw() +
  xlab("Group") +
  ylab("6 month % returns")
```

![](task10_files/figure-html/unnamed-chunk-9-1.png)<!-- -->
