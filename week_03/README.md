 * ggplot2 is based on the "grammar of graphics"
 * A data frame is a rectangular table of data.
 * You always start with ggplot() when graphing and a geom function is later added to change the type of graph  
 * The basic form of a ggplot graph is like this:
 ```
 ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
 ```
 * An aesthetic is a visual property of your graph. For example, this could be a color.
 * Using aesthetics can give more visual meaning to the data and help us see patterns.
 * Aesthetic properties can be set manually.
 * Geoms determine the type of graph (bar,line,etc.).
 * The mappings determine have the X and Y axes.