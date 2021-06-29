* sp_to_sf converts to sf file
* sf (for example, nc) data is a data frame
* Since sf data is just a data frame, you can manipulate it with dplyr
* GGplot example:
```r
ggplot() +
  geom_sf(data = nc)
```
* coord_sf() puts a specific point on the map:
```r
ggplot() +
  geom_sf(data = nc) +
  annotate("point", x = -80, y = 35, colour = "red", size = 4) + 
  coord_sf(xlim = c(-81, -79), ylim = c(34, 36))
```