# ----------- #
## Functions ##
# ----------- #

# ----------------------------------------
# DESC: user-created functions for project
# SCRIPT DEPENDENCIES: none
# NOTES: none
# ----------------------------------------


# func_plot_counts_percents -----------------------------------------------
# DESC: Creates bar chart that includes counts on y-axis and percents at top of bars
# PACKAGE DEPENDENCIES:
 # 1. ggplot2
 # 2. scales
# FUNCTION DEPENDENCIES: none
# CREDIT: https://www.r-bloggers.com/bar-charts-with-percentage-labels-but-counts-on-the-y-axis/
# NOTES: none
# ARGUMENTS:
 # 1. x | (tibble) dataframe to pass through plotting function
 # 2. colour_fill | (char) colour to fill the bars
 # 3. colour_txt | (char) colour for text of percents displayed
func_plot_counts_percents <- function(x, plot_stat = "count", colour_fill, colour_txt, plot_title, plot_subtitle, plot_title_x) {
  
  plot_bar <- ggplot(data = data.frame(x), mapping = aes(x = x)) +
    geom_bar(mapping = aes(y = (..count..)), fill = colour_fill) +
    geom_text(mapping = aes(y = (..count..),
                            label = ifelse((..count..) == 0, "",
                                           scales::percent((..count..)/sum(..count..)))), 
              stat = plot_stat, 
              colour = colour_txt) +
    labs(title = plot_title, subtitle = plot_subtitle, x = plot_title_x, y = "Count") +
    theme(plot.title = element_text(face = "bold", hjust = 0.5),
          plot.subtitle = element_text(face = "bold", hjust = 0.5),
          panel.background = element_blank(),
          axis.line = element_line(color = "black")) +
    # add text-wrapping for x labels
    scale_x_discrete(labels = function(x) str_wrap(x, width = 10))
  
  return(plot_bar)
}

