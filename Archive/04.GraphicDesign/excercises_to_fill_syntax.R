

# Rstats Friday 1/2/2019 Visulisation in R (focus on ggplots) -- companion script (worksheet)
# Questions? erin.walsh@anu.edu.au

########################## General things

# First variable is X axis, second variable is Y axis
# Most plots can be built up in layers

########################## Exercise 01: Base R

# Load example dataset
  data("iris")
  
  # Check categorical varible is in correct format
  iris$Species<-as.factor(iris$Species)
  
  head(iris)

## Base plots
  
### Single variable
    
  # To fill: Histogram
  hist(iris$Sepal.Length)
    
  # To fill: Dot chart
    
  # To fill: Strip chart
  stripchart(iris$Sepal.Length)
  
### Multi-variable
  
  # To fill: Scatter plot 
plot(iris$Petal.Length, iris$Petal.Width)    
  # To fill: Line plot
plot.new()  
  # To fill: Pairs plot
lines(iris$Petal.Length, iris$Petal.Width)    
plot(iris$Petal.Length, iris$Petal.Width)    
lines(iris$Petal.Length, iris$Petal.Width)    

pairs(~iris$Sepal.Length + iris$Petal.Width + iris$Sepal.Width)
plot(iris)
  # To fill: Box plot
  
  # To fill: Notched box plot
    
### Output of other functions or operations
  
  # To fill: Density plot
  
  # To fill: Linear model diagnostics
    
  # To fill: Linear model output on scatter plot

  # To fill: Bar plot
  
  # To fill: Stacked bar plot

  # To fill if you really must: pie chart (friends don't let friends use pie charts)

### Multiplots
  
  # To fill: par and mfrow
   
  # clear changed options with dev.off()  

### Annotation
    plot(iris$Petal.Length, iris$Petal.Width)
    
   # To fill: adding text!
    
    
########################## Exercise 02: ggplots can be used just like base graphics    
    
    # To fill: always note the version of the package you have loaded, and what you have loaded it for
    library(ggplot2) 
    
### Single variable
    
    # hist(iris$Sepal.Length)
    # To fill: ggplot histogram
    
    # dotchart(iris$Sepal.Length)
    # To fill: ggplot dotchart    
    
    # There is no ggplot version of a strip chart.
    
    
### Multi-variable
    
    # plot(iris$Petal.Length, iris$Petal.Width)
    # To fill: ggplot scatterplot
    
    # plot(iris$Petal.Length, iris$Petal.Width, type="l")
    # To fill: ggplot line chart 
    
    # pairs(~iris$Sepal.Length + iris$Petal.Width + iris$Sepal.Width)
    library(GGally)
    # To fill: ggplot pair plot
    
    # plot(iris$Species, iris$Sepal.Length, type="b")
    # To fill: ggplot box plot
    
### Output of other functions or operations
    
    # sepal_density<-density(iris$Sepal.Length)
    # plot(sepal_density)
    # To fill: ggplot density plot

    # No base ggplot version of linear model diagnostics
    
    # plot(iris$Sepal.Length ~iris$Petal.Width)
    # abline(sepal_linear)
    # To fill: ggplot scatterplot with linear model line
    
    # sepal_table<-table(iris$Sepal.Length)
    # barplot(sepal_table)
    # To fill: ggplot bar chart
    
    # sepal_table_stacked<-table(iris$Species, iris$Sepal.Length)
    # barplot(sepal_table_stacked)
    # To fill: ggplot stacked bar chart
    
    # To fill: ggplot pie chart (why??)
        
### Multiplots

    # To fill: ggplot facets
    
    # To fill: ggplot gridextra
    library(gridExtra)
    
    
    # Used in combination with functions and loops, this is EXTREMELY convenient for iterative plotting.
      # Initiate list
      iterative_plot<-list()
      # Run a loop 10 times, creating a 10-plot long list
      for(i in 1:10){iterative_plot[[i]]<-ggplot(data=iris[sample(nrow(iris), 15), ], # Take a random sample of 15 cases of the iris data
                                               aes(x=Petal.Length, y=Petal.Width)) + geom_point()}
    
      # To fill: do call with gridextra (and associated tweaks)
    
### Annotation
    
    # plot(iris$Petal.Length, iris$Petal.Width)
    # text(5,0.5, labels="Text")  
    # To fill: ggplot with annotations
    
    
    
########################## Exercise 03: ggplots and the grammar of graphics
    
      # To fill: build that plot!
      
      
########################## Exercise 04: the plot thickens
    
    
   # To fill: make an empty single continuous variable plot called base_cont
      base_cont <- ggplot(data=iris, aes(x=Sepal.Length))
      plot(base_cont)   
      base_cont+geom_bar()
      
      # To fill: make an empty two continuous variable plot called base_cont_cont 
   base_cont_cont <- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Width))
   base_cont_cont+geom_bin2d()
   plot(base_cont_cont)   
   
   # To fill: make an empty continuous by categorical variable plot called base_cont_cat 
      
    square<-data.frame(x=c(1,2,2,1,1),
                       y=c(2,2,1,1,2))
    base_cont_shape<-ggplot(data=square, aes(x=x, y=y))

    
## Geoms    
  ## Continuous
    # To fill: add these to base_cont: geom_bar()  geom_histogram()  geom_density()  geom_freqpoly()
    
  ## Continuous by continuous
    # To fill: add these to base_cont_cont: geom_point()   geom_jitter()  geom_line()  geom_rug()
    # geom_step()  geom_tile()  geom_bin2d()  geom_hex()  geom_quantile()  geom_smooth()
    
  ## Continuous by categorical    
    # To fill: add these to base_cont_cat: geom_boxplot()  geom_jitter()
    
  ## Area or shape
    # To fill: add these to base_cont_shape: geom_path()  geom_polygon()  geom_area()
    
  ## Error bars
    # Prepare the data: (this is one of many methods)
      summary_grabber<-function(x,group){data.frame(species=group,
                                                    Sepal.Length=mean(iris[which(iris$Species==group),x]),
                                                   sd=sd(iris[which(iris$Species==group),x]))}
      se_dat<-rbind(summary_grabber("Sepal.Length","setosa"),
                    summary_grabber("Sepal.Length","versicolor"),
                    summary_grabber("Sepal.Length","virginica"))
   
      se_dat$sd_lower<-se_dat$Sepal.Length-se_dat$sd
      se_dat$sd_upper<-se_dat$Sepal.Length+se_dat$sd
      
      # To fill: take a look at the above data
      
      # To fill: create an empty bar chart with se_dat, species, sepal length, 
      #          and the argument stat="identity" in geom_bar()
      #          name it bar_base
      
      # To fill: add these to bar_base: geom_errorbar()   geom_linerange()   geom_pointrange()   geom_crossbar()
      
    
    
  ## Scales and axes
      # To fill: add new xlim() and ylim() to base_cont_cont
      
      # To fill: add new scale_x_continuous() and scale_y_continuous() to base_cont_cont
      
      # To fill: add scale_x_reverse() and scale_x_reverse() to base_cont_cont
    
      # To fill: add these to base_cont_cont: scale_y_log10()    scale_y_sqrt()   coord_trans(x="log10", y="sqrt")
      
    
  ## Coords
      # To fill: add these to base_cont_cont: coord_flip()   coord_equal()   coord_polar()

    
  ## Adding and changing text
      # To fill: add these to bar_base:   geom_text(label="hello")  geom_text(label="hello", x=1)  
      #  geom_text(label="hello", x=1,y=1, colour="white")
      # Also have a play with position and colour
    

  ## Themes   
      # To fill: add these to base_cont_cont: theme_grey()   theme_bw()  theme_linedraw()  theme_light()
      #                                       theme_dark()  theme_minimal()  theme_classic()  theme_void()

    # Make your own: play with some of the colours and sizes! 
        custom_theme <- theme(# Change text with element_text; same parameters for axis.title and axis.text
                                  plot.title = element_text(color = "blue", face = "bold", size=rel(2)), 
                              # Change the plot lines with element_line
                                  panel.grid.major = element_line(colour="red",linetype = "dotted"),
                              # Change plot background colour
                                  panel.background = element_rect(fill = "yellow")
                              )
  
        # To fill: add your custom theme to base_cont_cont!
        
        
########################## Recommended further reading      
#
#   Broad grounding:    
#       Tufte, E., & Graves-Morris, P. (2014). The visual display of quantitative information.; 1983
#       Johnston, S. (2014) R Base graphics: an Idiot's guide http://rpubs.com/SusanEJohnston/7953 
#       Wilkinson, L. (2007) The grammar of graphics. Journal of statistical software 17(3). doi: 10.1002/wics.118
#       Wickham, H. (2016). ggplot2: elegant graphics for data analysis. Springer. 
#    
#   Topic specific:    
#       https://www.r-graph-gallery.com/ 
#       http://sape.inf.usi.ch/quick-reference/ggplot2/geom
#       https://bookdown.org/rdpeng/RProgDA/building-a-new-theme.html
        
        
        