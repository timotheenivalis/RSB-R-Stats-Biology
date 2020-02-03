

# Rstats Friday 1/2/2019 Visulisation in R (focus on ggplots) -- companion script (worked examples)
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
    hist(iris$Sepal.Length)
    
    dotchart(iris$Sepal.Length)
    
    stripchart(iris$Sepal.Length)
    
### Multi-variable
    plot(iris$Petal.Length, iris$Petal.Width)
    
    # Clear the plot:
    plot.new()
    # This does not work on its own: 
    lines(iris$Petal.Length, iris$Petal.Width)
    
    plot(iris$Petal.Length, iris$Petal.Width)
    lines(iris$Petal.Length, iris$Petal.Width)
    
    plot(iris$Petal.Length, iris$Petal.Width, type="l")
    
  # Pairs plot (multiple scatterplots)
    pairs(~iris$Sepal.Length + iris$Petal.Width + iris$Sepal.Width)
    
    plot(iris$Species, iris$Sepal.Length, type="b")
    plot(iris$Species, iris$Sepal.Length, type="b", notch=TRUE)
    
### Output of other functions or operations
  
  # Density plot (cousin of the histogram)
    sepal_density<-density(iris$Sepal.Length)
    plot(sepal_density)
  
  # Linear model diagnostics
    sepal_linear<-lm(iris$Sepal.Length ~iris$Petal.Width)
    plot(sepal_linear)  
    
  # Linear model output on points
    plot(iris$Sepal.Length ~iris$Petal.Width)
    abline(sepal_linear)

  # Bar plots
    sepal_table<-table(iris$Sepal.Length)
    barplot(sepal_table)
    barplot(sepal_table,horiz=TRUE)
  
  # Stacked bar plots  
    sepal_table_stacked<-table(iris$Species, iris$Sepal.Length)
    barplot(sepal_table_stacked)
    barplot(sepal_table_stacked, legend = names(table(iris$Species)))

  # Pie chart (Note: friends don't let friends use pie charts)
    petal_width_bins<-rep("Under 1", length(iris$Petal.Width))
    petal_width_bins[which(iris$Petal.Width>1)]<-"Over 1"
    petal_width_bins[which(iris$Petal.Width>2)]<-"Over 2"
    pie(table(petal_width_bins))

### Multiplots
    # First index is number of rows, second is number of columns. Default is 1,1...
    par(mfrow=c(1,1)) 
    hist(iris$Sepal.Length)
    
    par(mfrow=c(1,2)) 
    hist(iris$Sepal.Length)
    hist(iris$Sepal.Length)
    
    par(mfrow=c(2,1)) 
    hist(iris$Sepal.Length)
    hist(iris$Sepal.Length)
    
    par(mfrow=c(2,2)) 
    hist(iris$Sepal.Length)
    hist(iris$Sepal.Length)
    hist(iris$Sepal.Length)
    hist(iris$Sepal.Length)    
    
    # Automatically starts a new plot once old ones were full
    hist(iris$Sepal.Length)
    plot(sepal_density)
    stripchart(iris$Sepal.Length)
    barplot(sepal_table)
    
    # Good idea to put it back when you're done.
    par(mfrow=c(1,1)) 
    
    # clear changed options with dev.off(), resets all options and delete all graphes
    dev.off()
            
### Annotation
    plot(iris$Petal.Length, iris$Petal.Width)
    
    text(1,2.5, labels="Obscured text")
    text(1,2, labels="Text adjusted to 0", adj=0)    
    text(1,1.5, labels="Text adjusted to 0.5", adj=0.5)    
    text(1,1, labels="Text adjusted to 1", adj=1) 
    
    text(5,0.5, labels="Text with different X position")     
    
    text(4,2.5, labels="Obscured text")
    text(4,2, labels="Text adjusted to 0", adj=0)    
    text(4,1.5, labels="Text adjusted to 0.5", adj=0.5)    
    text(4,1, labels="Text adjusted to 1", adj=1)   
    
    
########################## Exercise 02: ggplots can be used just like base graphics    
    
    
    library(ggplot2)  # Version 3.2.5
    
### Single variable
    
    # hist(iris$Sepal.Length)
    # qplot(iris$Sepal.Length)
    ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram()
    
    # Not always the same behavior - often clearer than base R
    # dotchart(iris$Sepal.Length)
    ggplot(data=iris, aes(x=Sepal.Length)) + geom_dotplot()
    
    
    # stripchart(iris$Sepal.Length)
    # - No base ggplot version of a strip chart
    
    
### Multi-variable
    
    # plot(iris$Petal.Length, iris$Petal.Width)
    ggplot(data=iris, aes(x=Petal.Length, y=Petal.Width)) + geom_point()
    
    # plot(iris$Petal.Length, iris$Petal.Width, type="l")
    ggplot(data=iris, aes(x=Petal.Length, y=Petal.Width)) + geom_line()
    
    # pairs(~iris$Sepal.Length + iris$Petal.Width + iris$Sepal.Width)
    library(GGally)
    ggpairs(iris[,c("Sepal.Length","Petal.Width","Sepal.Width")])
    
    # plot(iris$Species, iris$Sepal.Length, type="b")
    ggplot(data=iris, aes(x=Species, y=Sepal.Length)) + geom_boxplot()
    
### Output of other functions or operations
    
    # sepal_density<-density(iris$Sepal.Length)
    # plot(sepal_density)
    ggplot(data=iris, aes(x=Sepal.Length)) + geom_density()
    
    # Linear model plot
    # sepal_linear<-lm(iris$Sepal.Length ~iris$Petal.Width)
    # plot(sepal_linear)  
    # - No base ggplot version of linear model diagnostics
    
    # plot(iris$Sepal.Length ~iris$Petal.Width)
    # abline(sepal_linear)
    ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Width)) + geom_point() + geom_smooth(method="lm")
    
    # sepal_table<-table(iris$Sepal.Length)
    # barplot(sepal_table)
    ggplot(data=iris, aes(x=Sepal.Length)) + geom_bar()
    
    # sepal_table_stacked<-table(iris$Species, iris$Sepal.Length)
    # barplot(sepal_table_stacked)
    ggplot(data=iris, aes(x=Sepal.Length)) + geom_bar(aes(fill=Species))
    
    # petal_width_bins<-rep("Under 1", length(iris$Petal.Width))
    # petal_width_bins[which(iris$Petal.Width>1)]<-"Over 1"
    # petal_width_bins[which(iris$Petal.Width>2)]<-"Over 2"
    # pie(table(petal_width_bins))
    ggplot(iris, aes(x="", y=Petal.Width, fill=Species))+ geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0)
        
### Multiplots
    # Base R begins par(mfrow=c(1,2))
    # There are two methods:
    # - Faceting on the basis of a factor in the data
    # - Making different plots and then combining them
    
    ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram() + facet_wrap(~Species)
    
    # Works across almost all plot types
    ggplot(data=iris, aes(x=Petal.Length, y=Petal.Width)) + geom_point() + facet_wrap(~Species)
    
    # Still works, even if it is redundant.
    ggplot(data=iris, aes(x=Species, y=Sepal.Length)) + geom_boxplot()+ facet_wrap(~Species)
    ggplot(data=iris, aes(x=Sepal.Length)) + geom_bar(aes(fill=Species))+ facet_wrap(~Species)
    
    
    # An external package: gridExtra()
    library(gridExtra)
    
    grid.arrange(ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                 ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                 ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                 ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram())
                    
    # This gives extra flexibility, e.g. specifying rows and columns
    grid.arrange(nrow=1,
                 ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                 ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                 ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                 ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram())
    
    grid.arrange(ncol=1,
                 ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                 ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                 ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                 ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram())    
    
    
    # Nesting can be done conveniently via Grobs:
    grid.arrange(ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                 arrangeGrob(nrow=1,
                     ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                     ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                     ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram())
                )
    
    # The major title is easily added
    grid.arrange(top ="This is a title",
                 ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                 arrangeGrob(nrow=1,
                             ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                             ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                             ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram())
                 )    
    
    
    # Both plots and grobs can be saved as objects
    plot_object<-ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram()
    grob_object<- arrangeGrob(nrow=1,
                              ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                              ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram(),
                              ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram())
    
    grid.arrange(plot_object,grob_object)
    
    # Used in combination with functions and loops, this is EXTREMELY convenient for iterative plotting.
      # Initiate list
      iterative_plot<-list()
      # Run a loop 10 times, creating a 10-plot long list
      for(i in 1:10){iterative_plot[[i]]<-ggplot(data=iris[sample(nrow(iris), 15), ], # Take a random sample of 15 cases of the iris data
                                               aes(x=Petal.Length, y=Petal.Width)) + geom_point()}
    
    do.call(grid.arrange, iterative_plot)
    
    # Adjusts automatically to however many you feed it
    do.call(grid.arrange, iterative_plot[1:4])
    
    # Can also take additional arguments (by giving grid.arrange a vector), such as a title for grid.arrange
    do.call(grid.arrange, c(iterative_plot[1:4], top="Title"))
    
    
### Annotation
    
    # plot(iris$Petal.Length, iris$Petal.Width)
    # text(5,0.5, labels="Text")    
    
    ggplot(data=iris, aes(x=Petal.Length, y=Petal.Width)) + geom_point() +
        geom_text(aes(x=5, y=0.5,label="Text"))
    
    
    
    
    
    
########################## Exercise 03: ggplots and the grammar of graphics
    
    ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Width))
    ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Width))+ scale_y_log10()
    ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Width))+ scale_y_log10()+ geom_smooth() + geom_point()
    ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Width))+ scale_y_log10()+ geom_smooth() + geom_point() + coord_polar()
    ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Width))+ scale_y_log10()+ geom_smooth(colour="red") + geom_point(colour="blue") + coord_polar() + theme_bw()
    
    
########################## Exercise 04: the plot thickens
    
    
    base_cont<-ggplot(data=iris, aes(x=Sepal.Length))
    
    base_cont_cont<-ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Width))
    
    base_cont_cat<-ggplot(data=iris, aes(x=Species, y=Petal.Width))
    
    square<-data.frame(x=c(1,2,2,1,1),
                       y=c(2,2,1,1,2))
    base_cont_shape<-ggplot(data=square, aes(x=x, y=y))

    
## Geoms    
  ## Continuous  
    base_cont + geom_bar()
    base_cont + geom_histogram()
    base_cont + geom_density()
    base_cont + geom_freqpoly()
    
  ## Continuous by continuous
    base_cont_cont + geom_point()
    base_cont_cont + geom_jitter()
    base_cont_cont + geom_line()
    base_cont_cont + geom_rug()
    base_cont_cont + geom_step()
    base_cont_cont + geom_tile()
    base_cont_cont + geom_bin2d()
    base_cont_cont + geom_hex()
    base_cont_cont + geom_quantile()
    base_cont_cont + geom_smooth()
    
  ## Continuous by categorical    
    base_cont_cat + geom_boxplot()
    base_cont_cat + geom_boxplot() + geom_jitter()
    
  ## Area or shape
    base_cont_shape + geom_path()
    base_cont_shape + geom_polygon()
    base_cont_shape + geom_area()
 
    
  ## Error bars
    # Prepare the data: this is one of many methods
      # Just grabbing summary stats by group
      summary_grabber<-function(x,group){data.frame(species=group,
                                                    Sepal.Length=mean(iris[which(iris$Species==group),x]),
                                                   sd=sd(iris[which(iris$Species==group),x]))}
      se_dat<-rbind(summary_grabber("Sepal.Length","setosa"),
                    summary_grabber("Sepal.Length","versicolor"),
                    summary_grabber("Sepal.Length","virginica"))
              
   
      se_dat$sd_lower<-se_dat$Sepal.Length-se_dat$sd
      se_dat$sd_upper<-se_dat$Sepal.Length+se_dat$sd
      
      bar_base<-ggplot(se_dat, aes(x=species, y=Sepal.Length)) + geom_bar(stat="identity")
      
      # geom_errorbar()
      # Note: geom_errorbarh() works the same, but for the x axis
      bar_base + geom_errorbar(ymin=se_dat$sd_lower,ymax=se_dat$sd_upper)
      
      # geom_linerange()
      bar_base + geom_linerange(ymin=se_dat$sd_lower,ymax=se_dat$sd_upper)
        
      # geom_pointrange()
      bar_base + geom_pointrange(ymin=se_dat$sd_lower,ymax=se_dat$sd_upper)
      
      # geom_crossbar()
      bar_base + geom_crossbar(ymin=se_dat$sd_lower,ymax=se_dat$sd_upper)
      
    
    
  ## Scales and axes
    # Limit the range
      base_cont_cont + xlim(0,5) + ylim(0,1)
      base_cont_cont + scale_x_continuous(limits=c(0,5)) + scale_y_continuous(limits=c(0,1))
    
    # Reverse the axes
      base_cont_cont + scale_x_reverse() + scale_y_reverse()
      
    # Transform the axes
      base_cont_cont + scale_x_log10() +scale_y_log10()
      base_cont_cont + scale_x_sqrt()  +scale_y_sqrt()
      base_cont_cont + coord_trans(x="log10", y="sqrt")
      
    
  ## Coords
    base_cont_cont
    base_cont_cont + coord_flip()
    base_cont_cont + coord_equal()
    base_cont_cont + coord_polar()

    
  ## Adding and changing text
    
    bar_base + geom_text(label="hello")
    bar_base + geom_text(label="hello", x=1)
    bar_base + geom_text(label="hello", x=1,y=1)
    bar_base + geom_text(label="hello", x=1,y=1, colour="white")    
    
    bar_base + ggtitle("Title for a plot")
    bar_base + xlab("X axis label") + ylab("Y axis label")
    
    
  ## Themes   
    base_cont_cont
    base_cont_cont + theme_grey() # This is the default
    base_cont_cont + theme_bw()
    base_cont_cont + theme_linedraw()
    base_cont_cont + theme_light()
    base_cont_cont + theme_dark()
    base_cont_cont + theme_minimal()
    base_cont_cont + theme_classic()
    base_cont_cont + theme_void()

    # Make your own 
        custom_theme <- theme(# Change text with element_text; same parameters for axis.title and axis.text
                                  plot.title = element_text(color = "blue", face = "bold", size=rel(2)), 
                              # Change the plot lines with element_line
                                  panel.grid.major = element_line(colour="red",linetype = "dotted"),
                              # Change plot background colour
                                  panel.background = element_rect(fill = "yellow")
                              )
  
    base_cont_cont + ggtitle("Your own theme") + custom_theme
    
    
    
    
    
    custom_theme <- theme(plot.title = element_text(color = "blue", face = "bold", size=rel(2)), 
                          panel.grid.major = element_line(colour="red",linetype = "dotted"),
                          panel.background = element_rect(fill = "yellow")
                          )
    

    # Recap: Geoms
      base_cont + geom_bar()
      base_cont_cont + geom_point()
      base_cont_cat + geom_boxplot()
      base_cont_shape + geom_path()
      
   # Recap: scales and axes
      base_cont + geom_bar() + scale_y_log10()
      base_cont_cont + geom_point() + scale_y_log10()
      base_cont_cat + geom_boxplot() + scale_y_log10()
      base_cont_shape + geom_path() + scale_y_log10()
    
    # Recap: Coords
      base_cont + geom_bar() + coord_equal()
      base_cont_cont + geom_point() + coord_equal()
      base_cont_cat + geom_boxplot() + coord_equal()
      base_cont_shape + geom_path() + coord_equal()
    
    # Recap: Adding and changing text  
      base_cont + geom_bar() + geom_text(label="hello", y=10, x=6)
      base_cont_cont + geom_point() + geom_text(label="hello", y=1,x=7)
      base_cont_cat + geom_boxplot() + geom_text(label="hello", y=1,x=1)
      base_cont_shape + geom_path() + geom_text(label="hello",y=1.5,x=1.5)
    
    # Recap: Themes   
      base_cont + geom_bar() + theme_bw()
      base_cont_cont + geom_point() + theme_bw()
      base_cont_cat + geom_boxplot() + theme_bw()
      base_cont_shape + geom_path() + theme_bw()
      
    
      
      
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
      
      