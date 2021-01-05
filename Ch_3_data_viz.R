# Hadley Wickham's R for data science, Chapter 3 problems and notes
library(ggplot2)
library(tidyverse)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy))

# Not a very useful plot, since most of the class types
# have all drive types:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))

# Using color aesthetic for class.
# class is unordered, and so is color. This is fine.
# We should not use an unordered aesthetic to map to an ordered feature,
# and vice versa.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
# This gives us a warning since we're using an ordered aesthetic (size)
# to map to an unordered feature (class):
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

# Only 6 shapes can be used in a single plot.
# Additional groups will be missing from the plot.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# Manually setting color (aesthetic property of the geom).
# All points are now in the color specified.
# You can also set:
#   shape = 10  or
#   size = 3  (3mm)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class), 
             color = 'blue', size = 3)

# Mapping continuous variables to color, size.
# Cannot map a continuous variable to shape - produces an error.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = year))
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = year))
# ggplot(data = mpg) +
#   geom_point(mapping = aes(x = displ, y = hwy, shape = year))

# Mapping the same variable to multiple aesthetics (shape, color, size) 
# changes the shape, color, and size of the point groups.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, 
                           shape = class, color = class, size = class))

# The stroke aesthetic modifies the width of the border
# for shapes that have a border
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), shape = 21, stroke = 1)

# When you map an aesthetic to something other than a variable,
# a True/False value is generated for each point based on the RHS
# of the aesthetic, and the aesthetic is set based on the True/False
# group it falls in.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))

# Facets.
# Advantage of facets vs. color/shape/size is that you can see all values
# without other data's values intruding on it.
# The disadvantage is that it may be difficult to compare against
# the other data points.
# If there are lots of data points, facets would be preferred to clarify
# the visualization. If not, color/shape/size may work better.
# When using the facet_grid, put variable with more unique levels
# in the columns, since laptop screens are more wide than tall.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2) # facet_wrap takes only 1 variable
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl) # facet_grid figures out how many rows/cols.
                        # First variable faceted along rows.
                        # Second variable faceted along columns.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl) # To not facet along row or col, put a . there
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(cyl ~ .) # To not facet along row or col, put a . there
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ year) # When faceting on a continuous variable,
                       # only the minimum and maximum values
                       # of the variable are used for faceting.

# Adding geom_smooth to fit the data with a smooth line.
# The mapping was moved into the ggplot call since
# it is common to both geom_point and geom_smooth.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()  # fit the data with a smooth line.

# Use the linetype aesthetic to create separate geom_smooth plots.
# YOu can use linetype to separate the geom_smooth plots,
# and match those with the geom_point using color.
# Notice that we've used linetype aesthetic on geom_smooth,
# but not on geom_point (it wouldn't make sense anyway).
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(linetype = drv, color = drv)) +
  geom_point(mapping = aes(color = drv))
# You can disable legend using show.legend = FALSE.
# You have to do this for each geom.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(linetype = drv, color = drv), show.legend = FALSE) +
  geom_point(mapping = aes(color = drv), show.legend = FALSE)

# Specify different data for each layer
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == 'subcompact'), # select only 
                                                         # subcompact cars.
              se = FALSE) # SE shows the 95% confidence interval, and is the 
                          # greay shaded area around the smooth fit line.

ggplot(data = filter(mpg, drv == 'f'), mapping = aes(x = displ, y = hwy)) + 
  geom_point()
ggplot(data = mpg, mapping = aes(x = drv, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = hwy, y = displ)) +
  geom_area()

# We're grouping by color on drv, thus geom_smooth creates multiple
# fits
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

# Various ways of generating plots
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() + 
  geom_smooth(se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(data = filter(mpg, drv == '4'), se = FALSE) +
  geom_smooth(data = filter(mpg, drv == 'f'), se = FALSE) +
  geom_smooth(data = filter(mpg, drv == 'r'), se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) + 
  geom_smooth(se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(mapping = aes(linetype = drv), se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point()

# Statistical Transformations
