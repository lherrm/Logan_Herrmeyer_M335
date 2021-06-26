library(pacman)
pacman::p_load(tidyverse, lubridate)
link <- "https://byuistats.github.io/M335/data/sales.csv"
df <- read_csv(link)
df2 <- df %>%
  mutate(mt_time = with_tz(Time, "America/Denver")) %>%
  filter(Name != "Missing") %>%
  mutate(week = week(mt_time),
         month = month(mt_time),
         day = yday(mt_time))
# Check for inaccuracies in price
# There seems to be an outlier of $1026
# The distribution looks fine
ggplot(df2,aes(x=Amount)) +
  geom_histogram() +
  labs(title = "Histogram of sales amounts")
# The most is LeBelle
df2 %>% arrange(desc(Amount)) %>% head(5)
# The 1026 is about 5x higher than the next amount, 210
df2 %>% filter(Name == "LeBelle") %>% arrange(desc(Amount))
# I won't discard it, as others have unusual large amounts of money as well
# We don't know that the outlier is correct or not, but it does
# not effect the data much, so it should be kept
# This is 21 SD's away from the mean
# Chebyshev's Theorem says that <0.002% of data should occur there
# 634*0.0022 is 1.3948, or <1.4 points on average should be
# this far away from the mean. 126 instead of 1026 would
# make more sense.
# The peak in Lebelle sales does not correspond with any other
# peak, so I think It can be removed.
# Tacontento also has a large outlier as well at $782
# SplashAndDash does not seem like an outlier
# ShortStop may be a negative outlier
# However, outliers do not affect the graph
# Check for hour outliers too

df2 %>% 
  ggplot(aes(x = hour(mt_time), y = Amount)) +
  geom_jitter()
# Remove points between 5 and 7:30 AM?
# What about the zero hours?
df2 %>% filter(hour(mt_time) == 0)
# These do not just have 0 for a minute, so they are valid and
# are not just forgetting to put a time value
df2 %>% filter(hour(mt_time) < 7.5 & hour(mt_time) > 5)
# There are only 2 points between 5 and 7:30, so they don't really
# matter, safe to remove or not.
# They should be removed because of the very small amount
df2 %>% filter(Name == "HotDiggity") %>% filter(hour(mt_time) < 7)

# HotDiggity in April also seems like an outlier
df2 %>% 
  ggplot(aes(x = mt_time, y = Name)) +
  geom_jitter(aes(color=Name)) +
  theme(legend.position = "none")