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


# func_plot_pie -----------------------------------------------
# DESC: Creates pie chart
# PACKAGE DEPENDENCIES:
 # 1. ggplot2

# FUNCTION DEPENDENCIES: none
# CREDIT: https://www.r-bloggers.com/bar-charts-with-percentage-labels-but-counts-on-the-y-axis/
# NOTES: none
# ARGUMENTS:
 # 1. x | (tibble) dataframe to pass through plotting function
 # 2. colour_fill | (char) colour to fill the bars
 # 3. colour_txt | (char) colour for text of percents displayed
func_plot_pie <- function(x, col_counts, #col_category, 
                          plot_title#, factor_levels
                          ) {
  plot_pie <- ggplot(data = x, 
                     mapping = aes_string(x = "", y = col_counts
                                          
                                          #, #remove vars...
                                   #fill = factor(x = col_category, levels = factor_levels), label = col_counts)
                                   )) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar(theta = "y", start = 0) +
    geom_text(size = 3, position = position_stack(vjust = 0.5)) +
    labs(title = paste0("Pie Chart: ", plot_title),
         subtitle = "LEAF 2017",
         fill = "Key") +
    theme(plot.title = element_text(face = "bold", hjust = 0.5),
          plot.subtitle = element_text(face = "bold", hjust = 0.5),
          panel.background = element_blank(),
          axis.line = element_blank(),
          axis.title = element_blank(),
          axis.text = element_blank())
    
  return(plot_pie)
}

func_plot_pie <- function(x, x_col = "", col_counts, col_category) {
  ggplot(data = x, mapping = aes_string(x = x_col, y = col_counts, fill = col_category)) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar(theta = "y", start = 0)
}

test_func <- function(x, col_counts, col_category) { 
  ggplot(data = x, mapping = aes_string(x = col_counts, y = col_category)) +
    geom_bar(stat = "identity")
}
test_func(x = data, col_counts = "Field", col_category = "Value")