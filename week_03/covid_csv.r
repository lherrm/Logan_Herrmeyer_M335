#Data located at https://github.com/nytimes/covid-19-data
#The RAW CSV files give direct access to data
pacman::p_load(tidyverse)
covid_url <- "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv"

covid_data <- 
  read_csv(covid_url) %>% 
  glimpse()

covid_data %>% 
  ggplot(aes(x = date, y = cases)) +
  geom_line()

covid_data %>% 
  mutate(daily_new_cases = cases - lag(cases)) %>% 
  ggplot() +
  geom_line(aes(x = date, y = daily_new_cases))


pacman::p_load(tidyverse)
covid_state_url <- "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv"

covid_state_data <- 
  read_csv(covid_state_url) %>% 
  glimpse()

# Make 2 top/bottom graphs
covid_state_data %>% 
  filter(state %in% c("Idaho","Utah")) %>% 
  ggplot(aes(x = date, y = cases)) +
  geom_line() +
  facet_grid(state ~ .)

# Make 2 side by side graphs
covid_state_data %>% 
  filter(state %in% c("Idaho","Utah")) %>% 
  ggplot(aes(x = date, y = cases)) +
  geom_line() +
  facet_grid(. ~ state)



# Each state has a line on the same graph
covid_state_data %>% 
  filter(state %in% c("Idaho","Utah")) %>% 
  ggplot(aes(x = date, y = cases, color=state)) +
  geom_line()

# Load county data
covid_county_url <- "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"
covid_county_data <- read_csv(covid_county_url)

# Glimpse it
covid_county_data %>% glimpse()

# Filter and graph
covid_county_data %>% 
  filter(state == "Minnesota") %>% 
  filter(county %in% c("Anoka", "Ramsey", "Hennepin", "Washington")) %>%
  ggplot(aes(x = date, y = cases, color=county)) +
  geom_line()