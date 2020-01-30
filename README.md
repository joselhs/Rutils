# Rutils
Here I place different functions I created using R language to solve business problem that we had at work.

## ci_plot_smooth
This function permits to plot _i_ data series smoothly with their confidence intervals by aproximating the original line with splines.

### Use
  - data: dataframe with 3n columns. In each three column, first one will be the data serie, second one the lower confidence interval and third one the upper confidence interval.
  - labels: x-axis labels. If not speficied, there will be labels from 1 to nrows.
  - ylim: vector indicating the y-axis limits.
  - sequence_y: seq(from=a,to=b,by=c) with the y-axis labels. 
  - colours: a vector indicating colours to be used. It's necessary to specify as many colours as series in the dataframe. If not specified, random colours will be used. 
  - xlab: x-label title.
  - ylab: y-label title.
  - main: main title.
  - legend: TRUE if we want to plot the legend. If TRUE also legendpos and legendlabels can be specified.
  - legendpos: legend position. It can be _topright_, _topleft_, _bottomright_, _bottomleft_.
  - legendlabels: legend labels.
  - trueLine: TRUE if we want to print the original serie to compare with the smooth curve.
  
### Examples
``
datatest <- data.frame(women = c(3.1, 3.6, 4.6, 5.4, 6.1, 7.0, 7.5, 6.7),
                       womenLW = c(2.9, 3.5, 4.6, 5.4, 6.0, 7.0, 7.4, 6.5),
                       womenUP = c(3.2, 3.7, 4.7, 5.5, 6.2, 7.1, 7.5, 6.9),
                       men = c(2.4, 3.1, 3.9, 4.8, 5.9, 7.2, 7.9, 7.4),
                       menLW = c(2.3, 3, 3.9, 4.7, 5.8, 7.1, 7.8, 7.1),
                       menUP = c(2.5, 3.1, 4, 4.8, 5.9, 7.3, 8, 7.8),
                       unknown = c(1, 1.7, 2.2, 1.5, 2.4, 3.2, 3.3, 2.1),
                       unknownLW = c(0.8, 1.5, 2.1, 1.2, 2.3, 3, 3.1, 2),
                       unknownUP = c(1.2, 1.8, 2.5, 1.6, 2.6, 3.3, 3.5, 2.4))

ci_plot_smooth(datatest,
         main = "CI Plot",
         xlab = "Grupos",
         ylab = "Value",
         legend = T,
         legendpos="topleft",
         legendlabs=c("a", "b", "c"),
         colours = c("orange", "steelblue", "darkgreen"),
         trueLine = F)
    
ci_plot_smooth(datatest, main = "CI Plot", xlab = "Grupos", y_lim = c(0.6, 10), ylab = "Valor", legend = F)
``
