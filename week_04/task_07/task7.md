---
title: "Task 7"
author: "Logan Herrmeyer"
date: "May 10, 2021"
output:
  html_document:  
    keep_md: true
    toc: true
    toc_float: true
    fig_height: 6
    fig_width: 12
    fig_align: 'center'
---



## Task 7

### Commented Code


```r
only_first_last <- ratings %>% # Store filtered data in only_first_last variable
  group_by(series) %>% # Group by series (season)
  slice(1, n()) %>% # Select only the first and last rows (episodes) for each series.
  mutate(which_episode = ifelse(episode == 1, "First", "Last")) %>% # Add a which_episode variable, saying if it is the first or last episode of the series.
  ungroup() %>% # Ungroup the data, undoing the group_by()
  mutate(series_f = as.factor(series)) # Change the series variable into the factor data type.

View(only_first_last) # Show a data table of the only_first_last data

ggplot(data = only_first_last, # Plot the data
       mapping = aes(x = which_episode, # With the x-axis being the episode (first or lass)
                     y = viewers_7day, # The y-axis being
                     group = series_f, # Put the data in groups by series
                     color = series_f)) + # Color by series
  geom_line() + # Make the graph a line graph
  geom_point(size = 5) # Set the point size to 5
```

![](task7_files/figure-html/unnamed-chunk-2-1.png)<!-- -->


## Series viewers


```r
ratings_10 <- ratings %>%
    group_by(series) %>%
    filter(n() == 10) %>%
    ungroup() %>%
    mutate(series_f = as.factor(series))
ratings_mean <- ratings_10 %>%
    group_by(series) %>%
    summarise(mean_views = mean(viewers_7day))

ggplot() + 
    geom_line(data = ratings_10,
              mapping = aes(x=episode,
                            y=viewers_7day,
                            group=series_f,
                            color=series_f)) +
    geom_point(data=ratings_mean,
               mapping = aes(x=series,
                             y=mean_views)) +
    ylab("7-day viewers/average") +
    xlab("Episode/Series #") +
    labs(color = "Series #") +
    ggtitle("Great British Bake Off Viewers")
```

![](task7_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

The above graph shows the average series 7-day viewers per episode (the dots), and the average episode 7-day viewers for each series (the colored lines). 

The series data shows that until series 7, each series was constantly increasing in average viewers. In series 8, viewership declined sharply and remained fairly constant through season 10.

The episode data also reveals interesting trends. In every season, the last episode of the series was the most viewed one. I think this is because people who have not watched the series. This happens for every series, from the most viewed one to the least. I think it is interesting that this is a universal pattern in this show.
