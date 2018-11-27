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
func_plot_counts_percents <- function(x, col_x, plot_stat = "count", colour_fill, plot_title, plot_title_x) {
  
  plot_bar <- ggplot(data = data.frame(x), mapping = aes_string(x = col_x)) +
    geom_bar(mapping = aes(y = (..count..)), fill = colour_fill) +
    geom_text(mapping = aes(y = (..count..),
                            label = ifelse((..count..) == 0, "",
                                           scales::percent((..count..)/sum(..count..)))), 
              stat = plot_stat, 
              colour = "black") +
    labs(title = paste0("Bar Chart: ", plot_title), subtitle = "LEAFF 2018", x = plot_title_x, y = "Count") +
    theme(plot.title = element_text(face = "bold", hjust = 0.5),
          plot.subtitle = element_text(face = "bold", hjust = 0.5),
          panel.background = element_blank(),
          axis.line = element_line(color = "black")) +
    # add text-wrapping for x labels
    scale_x_discrete(labels = function(x) str_wrap(x, width = 10))
  
  return(plot_bar)
}


# func_plot_pie -----------------------------------------------
# DESC: Creates pie chart
# PACKAGE DEPENDENCIES:
# 1. ggplot2
# FUNCTION DEPENDENCIES: none
# CREDIT: 
# 1. Parameterised columns for ggplot2 | https://stackoverflow.com/questions/22309285/how-to-use-a-variable-to-specify-column-name-in-ggplot
# NOTES: none
# ARGUMENTS:
# 1. x | (tibble) dataframe to pass through plotting function
# 2. colour_fill | (char) colour to fill the bars
# 3. colour_txt | (char) colour for text of percents displayed
func_plot_pie <- function(x, col_counts, col_category, plot_title, factor_levels) {  #col_label, for displaying percents
  plot_pie <- ggplot(data = x, 
                     mapping = aes(x = "", y = get(col_counts),
                                   fill = factor(x = get(col_category), levels = factor_levels), label = get(col_counts))) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar(theta = "y", start = 0) +
    # try to display percents as well
    #geom_text(mapping = aes(y = get(col_label), label = get(col_label, position = theta("y")))) +
    geom_text(size = 3, position = position_stack(vjust = 0.5)) +
    labs(title = paste0("Pie Chart: ", plot_title),
         subtitle = "LEAF 2018",
         fill = "Key") +
    theme(plot.title = element_text(face = "bold", hjust = 0.5),
          plot.subtitle = element_text(face = "bold", hjust = 0.5),
          panel.background = element_blank(),
          axis.line = element_blank(),
          axis.title = element_blank(),
          axis.text = element_blank())
  
  return(plot_pie)
}
