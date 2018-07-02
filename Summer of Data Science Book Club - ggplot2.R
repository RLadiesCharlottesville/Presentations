library(tidyverse)

####1 Data Viz w/ggplot2 ####
mpg <- ggplot2::mpg

ggplot(mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point()

# Anytime there is a variable, put it in aesthetics
# Global vs. Local

#*1.1 First Steps ####

# 1.) Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
# Answer: Nothing. ggplot2 creates anempty graph to add layers to. 

# 2.) How many rows are in mtcars? How many columns?
dim(mpg)
# Answer: 32 x 11 

# 3.) What does the drv variable discribe? Read the help for ?mpg to find out. 
?mpg
# Answer: f = front-wheel drive, r = rear wheel drive, 4 = 4wd

# 4.) Make a scatterplot of hwy versus cyl.
ggplot(mpg) +
    geom_point(mapping = aes(x = cyl, y = hwy))

# Answer: hwy has a negative relationship with cyl

# 5.) What happens when you make a scatterplot of class vs drv? Why is the 
#   plot not useful?
ggplot(mpg) +
    geom_point(mapping = aes(x = drv, y = class))

mosaicplot(mpg$class ~ mpg$drv)

# Answer: ggplot2 doesn't know how to deal with data of class character.

ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = class))


#*1.2 Aesthetics ####

# 1.) What's wrong with this code? Why are the points not blue?
ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# Answer: To set an aes manually, set it by name as an arg to your geom func;
#   i.e. put it outside of aes:
ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), color + "blue")

# 2.) Which variables in mpg are categorical? Which variables are continuous? 
#   How can you see this information when you run mpg?
str(mpg)
# Answer: manufacturer, model, trans, drv, fl, and class are categorical (char)
#   and displ, year, cyl, cty, and hwy are continuous (num or int).

# 3.) Map a continuous variable to color, size, and shape. How do these 
#   aesthetics behave differently for categorical versus continuous variables?
ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = year)) 

ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = cty))

ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, size = cyl))

# Answer: color becomes gradient when used on a continuous variable, size 
#   becomes increasingly large when used on a continuous variable, and shape 
#   cannot have a continous variable mapped to it. 

# 4.) What happens if you map the same variable to multiple aesthetics?
ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = hwy))
# Answer: It's doable, but not really necessary, unless you need to convert it 
#   to black and white, for example. 

# 5.) What does the stroke aesthetic do? What shapes does it work with?
ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), shape = 1, stroke = 2)
# Answer: it controls the thickness of the border of all shapes except 15 - 20
#   because those have solid fills.

# It helps for calling out specific points... I guess...

# 6.) What happens if you map an aesthetic to something other than a variable
#   name, like aes(color = displ < 5)?
ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))
# Answer: it treats displ < 5 as a logical variable and maps the True and False
#   responses to color.


#*1.3 Facets ####

# 1.) What happens if you facet on a continuous variable?
ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_wrap( ~ cty)
# Answer: ggplot tries to create a subplot for each value of the continuous 
#   variable - this can get very difficult to read the more values there are in
#   the continuous variable. 


# 2.) What do the empty cells in a plot with facet_grid(drv ~ cyl) mean? How do
#   they relate to this plot?

ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(drv ~ cyl)

ggplot(mpg) +
    geom_point(mapping = aes(x = drv, y = cyl))

# Answer: empty cells mean that there are no values that satisfy both the x and 
#   y conditions in the subplot grid. In the first plot, the empty cells show 
#   that there are no cars in the dataset that have both real wheel drive and 
#   are 4 or 5 cylinders, and there are no cars that have 4 wheel drive and 5 
#   cylinders. Both plots illustrate the same point.


# 3.) What plots does the following code make? What does the . do?

ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(drv ~ .)

# The dot means no faceting on the columns

# Answer: In the first plot we're using a scatterplot to show how displ relates 
#   to hwy, while faceting on discrete variable drv. There will be a subplot for 
#   each level of drv, i.e on a 3 x 1 grid bc drv is on the x axis of the facet. 

ggplot(mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(. ~ cyl)

# Answer: In the second plot we're using a scatterplot to show how displ relates
#   to hwy, while faceting on discrete variable cyl. There will be a subplot 
#   for each level of cyl, i.e on a 1 x 4 grid bc cyl is on the y axis of the 
#   facet. 


# 4.) Take the first faceted plot in this section:
ggplot(mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_wrap(~ class, nrow = 2)
#   What are the advantages to using faceting instead of the color aesthetic? 
#   What are the disadvantages? How might the balance change if you had a 
#   larger dataset?

# Answer: it's better to use facets when you have a lot of levels to 
#   distinguising between, i.e. it can be difficult to tell levels from another
#   if they are too similar in color. Facets are harder to read at a glance
#   though, so for data with less than 9 levels you should use color. If this
#   dataset were larger, we would use facets to show differences. 

# 5.) Read ?facet_wrap. What does nrow do? What does ncol do? What other options
#   control the layout of the individual panels? Why doesn't facet_grid have 
#   nrow or ncol variables?

# Answer: facet_wrap wraps a 1 dimensional sequence of panels into 2 
#   dimensional. nrow and ncow refer to the number of rows and columns in the 
#   resulting grid. facet_grid forms a matrix of panels defined by row and 
#   column faceting variables. 


#*1.4 Geom Objects ####

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(mapping = aes(color = class)) +
    geom_smooth(
        data = filter(mpg, class == "subcompact"),
        se = F
    )
# The above code shows hwy x displ, with each color representing the class of 
#   the car. The geom_smooth line only represents subcompact cars. 

# 1.) What geom would you chose to draw a line chart? A boxplot? A histogram?
#   An area chart?

# Answer: geom_line to draw a line chart, geom_boxplot to draw a boxplot, 
#   geom_histogram to draw a histogram, and geom_area for an area chart. 

# 2.) Run this code in your head and predict what the output will look like. 
#   Then run the code and check your predictions. 

ggplot(
    data = mpg, 
    mapping = aes(x = displ, y = hwy, color = drv)
) +
    geom_point() +
    geom_smooth(se = TRUE)

# Answer: This is a scatterplot of displ by hwy with the color of each point
#   dependent on the level of drv. On top of that is a smoothed line also
#   representing displ by hwy for each level of drv. 

# 3.) What does show.legend = FALSE do? What happens if you remove it? Why do 
#   you think I used it earlier in the chapter?

ggplot(data = mpg) +
    geom_smooth(
        mapping = aes(x = displ, y = hwy, color = drv),
        show.legend = T
    )

# Answer: show.legend tells ggplot whether or not to print the legend for the
#   layer or not. Because the drv aesthetic is mapped to the geom, the legend
#   for that layer is printed. The more layers you have, the more complex
#   the levels are. 

# 4.) What does the se argument to geom_smooth do?
?geom_smooth
# Answer: se tells ggplot whether or not to display a confidence interval
#   around the smoothed line. se = T is the default.

# 5.) Will these two graphs look different? Why or why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point() +
    geom_smooth()

ggplot() +
    geom_point(
        data = mpg, 
        mapping = aes(x = displ, y = hwy)
    ) +
    geom_smooth(
        data = mpg,
        mapping = aes(x = displ, y = hwy)
    )
# Answer: they both create the same plot, however the first one is much easier 
#   to read. The first plot establishes the mappings in the first layer, while
#   the second plot establishes the mappings in each layer. 

# 6.) Recreate the R code necessary to generate the following graphs:

# Answer: there are 6 graphs displayed total, and each graph is a 
#   scatterplot of displ x hwy. The first graph has a smoothed trend line 
#   overlayed. The second graph has a smoothed trend line for each drv level
#   overlayed. The points in the third graph are colored based on their drv
#   levels. There is also a smoothed trend line for each drv overlayed, that is 
#   the same color as the points. The fourth graph's points are colored 
#   accorinding to their drv level, and there is also a smoothed overall trend 
#   line overlayed. The fifth graph is again colored by drv, but has an overall 
#   trend line for each dirv. The trend line for each drv is blue, however
#   the line for r is straight, the trend line for f is dashed, and the trend
#   line for 4 is dotted. 

# Plot 1:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point() +
    geom_smooth(se = F)

# Plot 2:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point() +
    geom_smooth(mapping = aes(group = drv), se = FALSE)

# Plot 3:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
    geom_point() +
    geom_smooth(se = FALSE)

# Plot 4:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(mapping = aes(color = drv)) +
    geom_smooth(se = FALSE)

# Plot 5:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(mapping = aes(color = drv)) +
    geom_smooth(mapping = aes(linetype = drv),se = FALSE)

# Inherent grouping!!!

# Plot 6:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(size = 2, shape = 21, stroke = 2, color = "white", aes(fill = drv))



#*1.5 Stat Transformations ####
data(diamonds)
# Every geom has a default stat and every stat has a default geom 

# 1.) What is the default geom associated with stat_summary()? How could you 
#   rewrite the previous plot to use that geom function instead of the stat
#   function?

ggplot(diamonds) +
    stat_summary(
        mapping = aes(x = cut, y = depth),
        fun.ymin = min, 
        fun.ymax = max, 
        fun.y = median
    )

# Answer: The default geom is pointrange. for each group on the x axis (cut), 
#   ggplot computes the min, max, and median of the y value (depth) and shows 
#   it as a pointrange (i.e. a vertical line for each x, with the top being the 
#   max, bottom being the min, and the point representing the median value. To
#   rewrite the plot with geom instead of stat:

# First group the diamonds df by cut, then get summary stats of depth, and
# save that in a new df named sum_diamonds:
sum_diamond <- diamonds %>% group_by(cut) %>%
    summarize(min = min(depth), max = max(depth), median = median(depth))
# Then plot the new df with the pointrange geom:
ggplot(sum_diamond) +
    geom_pointrange(mapping = aes(x = cut, y = median, ymin = min, ymax = max))


# 2.) What does geom_col() do? How is it different from geom_bar()?
?geom_col()

# This plot shows the number of diamonds in each group (cut):
ggplot(diamonds) +
    geom_bar(mapping = aes(x = cut))

# This plot shows the value of depth in each group (cut):
ggplot(diamonds) +
    geom_col(mapping = aes(x = cut, y = depth))

# Answer: both geom_col() and geom_bar() make bar charts, however with 
#   geom_col() the heights of the bars represent the values in the data (i.e.
#   it uses stat_identity), while geom_bar makes the height of the bar
#   proportional to the number of cases in each group (i.e. it uses 
#   stat_count by default).


# 3.) Most geoms and stats come in pairs that are almost always used in
#   concert. Read through the documentation and make a list of all the pairs. 
#   What do they have in common?

# Answer:
#   geom_abline(), geom_hline(), geom_vline() <> stat = geom (abline, hline, etc)
#   geom_area(), geom_ribbon() <> stat = "identity"
#   geom_bar() <> stat = "count"
#   geom_bin2d() <> stat = "bin2d"
#   geom_blank() <> stat = "identity"
#   geom_boxplot() <> stat = "boxplot"
#   geom_col() <> stat = "identity"
#   geom_contour <> stat = "contour"
#   geom_count() <> stat = "sum"
#   geom_crossbar(), geom_errorbar(), geom_linerange(), geom_pointrange() <>
#       stat = "identity"
#   geom_curve(), geom_segment() <> stat = "identity"
#   geom_density() <> stat = "density"
#   geom_freqpoly(), geom_histogram() <> stat = "bin"
#   geom_hex() <> stat = "binhex"
#   geom_jitter() <> stat = "identity"
#   geom_label(), geom_text <> stat = "identity"
#   geom_line(), geom_path(), geom_step() <> stat = "identity"
#   geom_map() <> stat = "identity"
#   geom_point() <> stat = "identity"
#   geom_polygon <> stat = "identity
#   geom_quantile() <> stat = "quantile"
#   geom_raster(), geom_rect(), geom_tile <> stat = "identity"
#   geom_rug() <> stat = "identity"
#   geom_smooth() <> stat = "smooth"
#   geom_violin() <> stat = "ydensity"

#   In general, the default stat for each geom is the identity of the y
#   variable, or the stat invloved in the geom transformation. 


# 4.) What does the variable stat_smooth() compute? What parameters control
#   its behavior?
?stat_smooth

# Answer: stat_smooth aids the eye in seeing patterns in the presence of 
#   overplotting by overlaying a trend line over a scatterplot. This function
#   computes the predicted value (y), the lower and upper pointwise confidence 
#   intervals around the mean (ymin), and the standard error (se). The 
#   parameters that control its behavior are the smoothing method (lm, glm, gam,
#   loess, or rlm), the formula to use in the smoothing function (ex. y ~ x), se
#   determines if the confidence interval should be plotted, and level
#   determines the level of the confidence interval. 


# 5.) In our proportion bar chart, we need to set group = 1. Why? In other 
#   words what is the problem with these two graphs?

ggplot(diamonds) +
    geom_bar(mapping = aes(x = cut, y = ..prop..))

ggplot(diamonds) +
    geom_bar(
        mapping = aes(x = cut, fill = color, y = ..prop..)
    )
# Answer: If group is not set to 1, then all the bars have prop == 1. ggplot is 
#   trying to plot the number of observations in a group divided by the same 
#   number of observations in the group. By setting group = 1 we're telling
#   ggplot to use the entire (one group) data set to calculate the proportion
#   for each group. The function geom_bar assumes the groups are equal to the 
#   x values, since the stat computes the count within the groups. In both of 
#   the above graphs, the proportions are calculated across all groups (i.e. 
#   it calculates the proportion in relation to the total, not within each 
#   group). Therefore the y values will be the same across all x vales (1). The 
#   correct way to plot the above graphs is:

ggplot(diamonds) +
    geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, fill = color, y = ..prop.., group = color))



####*1.6 Postition Adjustments ####

ggplot(diamonds) +
    geom_bar(mapping = aes(x = cut, color = cut)) #outline color

ggplot(diamonds) +
    geom_bar(mapping = aes(x = cut, fill = cut)) #fill and outline color

ggplot(diamonds) +
    geom_bar(mapping = aes(x = cut, fill = clarity)) #stacked automatically 

# Position = "fill" makes each set of stacked bars the same height (useful 
#   for comparing proportions across groups):
ggplot(diamonds) +
    geom_bar(
        mapping = aes(x = cut, fill = clarity),
        position = "fill"
    )

# Position = "dodge" places overlapping objects directly beside one another
#   (useful for comparing individual values):
ggplot(diamonds) +
    geom_bar(
        mapping = aes(x = cut, fill = clarity),
        position = "dodge"
    )

# 1.) What is the problem with this plot? How could you improve it?

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_point()

# Answer: there is overplotting going on in the above plot. The values of hwy 
#   and cty are rounded so the points appear on a grid and many points overlap
#   eaother. To fix this issue, add position = "jitter" as an argument to the 
#   geom_point call:

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_point(position = "jitter")


# 2.) What parameters to geom_jitter() control the amount of jittering?
?geom_jitter()

# Answer: geom_jitter adds a small amount of randomm variation to the location
#   of each point. The width and height arguments control the amount of vertical
#   and horizontal jitter. The jitter is added in both positive and negative 
#   directions, so the total spread is twice the value specified here. If 
#   omitted, these arguments default to 40% of the resolution of the data: this
#   means the jitter values will occupy 80% of the implied bins. 

# Low horizonal jitter, high vertical jitter:
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_point(position = position_jitter(width = 0, height = 15))
# High horizonal jitter, low vertical jitter:
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_point(position = position_jitter(width = 15, height = 0))
# High horizonal jitter, high vertical jitter:
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_point(position = position_jitter(width = 15, height = 15))
# Low horizonal jitter, low vertical jitter:
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_point(position = position_jitter(width = 0, height = 0))


# 3.) Compare and contrast geom_jitter() with geom_count().
?geom_count

ggplot(mpg, aes(cty, hwy)) +
    geom_count()
ggplot(mpg, aes(cty, hwy)) +
    geom_jitter()

# Answer: geom_count() is a variant to geom_point() that counts the number
#   of observations at each location, then maps the count to point area. It 
#   computes n, the number of observations at a position, and prop, the percent
#   of points in that panel at that position. The larger the size of the point, 
#   the more data it represents. While geom_jitter adds random variation to 
#   handle overplotting, geom_count changes the size of the point. 


# 4.) What's the default position adjustment for geom_boxplot()? Create a 
#   visualization of the mpg dataset that demonstrates it.

?geom_boxplot

# Answer: the default position argument is dodge. This places overlapping 
#   objects directly beside eachother. For example:

ggplot(mpg, aes(class, hwy)) +
    geom_boxplot()

# In the above plot, the x axis shows the class group, while the y axis shows 
#   the corresponding hwy statistics. There is a boxplot for each group on the 
#   x axis (class), and the boxplots are side by side. 



####*1.7 Coordinate Systems ####

bar <- ggplot(data = diamonds) +
    geom_bar(
        mapping = aes(x = cut, fill = cut), 
        show.legend = F, 
        width = 1
    ) +
    theme(aspect.ratio = 1) +
    labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

# 1.) Turn a stacked bar chart into a pie chart using coord_polar.

# Answer: the polar coord system is most commonly used for pie charts, which 
#   are a stacked bar chart in polar coordinates. First create a stacked bar
#   chart, then add the coord_polar layer:

ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
    geom_bar() +
    coord_polar()


# 2.) What does labs() do? Read the documentation.
?labs()

# Answer: labs() allows us to modify the axis', legend, and plot labels. 

ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
    geom_bar() +
    labs(y = "y axis label", x = "x axis label")


# 3.) What's the difference between coord_quickmap() and coord_map()?
?coord_quickmap

# Answer: coord_map projects a portion of the earth, which is approx spherical, 
#   onto a flat 2D plane. These projections do not, in general, preserve 
#   straight lines, so this requires considerable computation. However
#   coord_quickmap is a quick approximation that does preserve straight lines.
#   It works best for smaller areas closer to the equator. 


# 4.) What does the following plot tell you about the relationship between city
#   and highway mpg? Why is coord_fixed important? What does geom_abline do?

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
    geom_point() +
    geom_abline() +
    coord_fixed()

# Answer: the plot above shows that city and highway mpg are direct variants of 
#   the other; they are positively linear related. For each car, as city mpg 
#   increases, so does highway mpg.  The geom_abline function adds a regression 
#   line showing the slope and y-intercept of the data. Coord_fixed forces a 
#   specific ration between the physical representation of the data units on 
#   the axis. The ratio represents the number of units on the y axis equivalent 
#   to 1 unit on the x axis (y/x).


####*1.8 Layered Grammar of Graphics ####
ggplot(data = <DATA>) +
    <GEOM_FUNCTION>(
        mapping = aes(<MAPPINGS>),
        stat = <STAT>,
        position = <POSITION>
    ) +
    <COORDINATE_FUNCTION> +
    <FACET_FUNCTION>
    