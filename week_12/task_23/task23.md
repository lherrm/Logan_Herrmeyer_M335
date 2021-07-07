---
title: "Task 23"
author: "Logan Herrmeyer"
date: "July 06, 2021"
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
library(tidyverse)
library(sf)
library(USAboundaries)
le <- read_csv("us_life_exp.csv")
```

## Visualization


```r
states <- us_states()
le_st <- le %>% 
    mutate(stusps = state.abb[match(State,state.name)])
states_le <- inner_join(le_st, states, by="stusps")
ggplot(states_le) +
    geom_sf(aes(geometry=geometry,fill=overall)) +
    xlim(-170,-70) +
    theme_bw() +
    scale_fill_continuous(name="Life expectancy (years)") +
    labs(
        X="",y="",
        title = "Life expectancy in US states in 2021"
    )
```

![](task23_files/figure-html/unnamed-chunk-3-1.png)<!-- -->
