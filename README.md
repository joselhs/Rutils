# Rutils
Here I place different functions I created using R language to solve business problem that we had at work.

## ci_plot_smooth
This function permits to plot ~i~ data series smoothly with their confidence intervals by aproximating the original line with splines.

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
  - legendpos: legend position. It can be "topright", "topleft", "bottomright", "bottomleft".
  - legendlabels: legend labels.
  - trueLine: TRUE if we want to print the original serie to compare with the smooth curve.
