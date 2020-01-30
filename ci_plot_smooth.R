#########################################################
# Autor: Jose L Holgado Sánchez y Cristina Lopez Zumel  #
# Fecha: 28/01/2020                                     #
#########################################################
 
ci_plot_smooth <- function(data, labels=NA, y_lim=NA, sequence_y=NA, colours=NA, xlab=NA, ylab=NA, main=NA, legend=F, legendpos="topleft", legendlabs=NA, trueLine = F){

  require(splines)
  
  # Creamos el eje X
  x <- c(1:(nrow(data)))
  
  # Buscamos valor máximo y mínimo de todo el dataset para establecerlo como límites del eje Y, 
  # y que se vean todas las series dibujadas correctamente
  minval <- min(apply(data,2,min))
  maxval <- max(apply(data,2,max))
  
  # Seleccionamos un número N de colores si no han sido especificados
  if(all(is.na(colours))){
    colours <- palette(rainbow(ncol(data)))
  }
  
  # para controlar los colores hemos creado el indice j
  j<- 1
  for(i in seq(from=1, to=ncol(data), by=3)){
    # Extraemos la serie y sus intervalos de confianza
    serie <- data[,i]
    linf <- data[,i+1]
    lsup <- data[,i+2]
    
    # Ajustamos las curvas mediante splines mediante un número grande de puntos
    xx <- seq(from = x[1], to = x[length(x)], by = 0.001)
    fit <- smooth.spline(serie ~ x,df = length(x))
    yy <- predict(fit, x = data.frame(x=xx))
    
    xxinf <- seq(from = x[1], to = x[length(x)], by = 0.001)
    fitinf <- smooth.spline(linf ~ x,df = length(x))
    yyinf <- predict(fitinf, x = data.frame(x=xxinf))
    
    xxsup <- seq(from = x[1], to = x[length(x)], by = 0.001)
    fitsup <- smooth.spline(lsup ~ x,df = length(x))
    yysup <- predict(fitsup, x = data.frame(x=xxsup))
   
    
    # Obtenemos el color y lo convertimos a RGB
    colour <- colours[j]
    rgbcol <- rgb(col2rgb(colour)[1]/255, 
                  col2rgb(colour)[2]/255, 
                  col2rgb(colour)[3]/255, 0.3)
    # actualizamos color
    j <- j+1
    if(i == 1){

      if(all(is.na(y_lim))){
        ylim <- c((minval-0.1), (maxval+0.1))
      }else{
        ylim <- c(y_lim[1]-0.5, y_lim[2]+0.5)
      }
      
      plot(unlist(yy$x), 
           unlist(yy$y),
           type = "l", 
           ylim = ylim,
           col = colour,
           xlab = xlab,
           ylab = ylab,
           main = main,
           yaxt = "n", 
           xaxt = "n",
           xaxs = "i")
    }else{
      lines(unlist(yy$x), unlist(yy$y), type = "l", col = colour)
    }
    
    if(trueLine){
      lines(x, serie, type = "b", col = "red")
    }
    
    polygon(c(unlist(yy$x), rev(unlist(yy$x))),
            c(unlist(yyinf$y), rev(unlist(yysup$y))),
            col = rgbcol, border = F)
  }
  
  # Modificación de los ejes. 
  if(all(!is.na(labels))){
    # En el eje X se eliminan los labels y se sustituyen por los grupos de edad
    axis(1, at=1:(nrow(data)+1), labels=labels)
  }else{
    axis(1, at=1:(nrow(data)+1), labels=c(1:(nrow(data)+1)))
  }
  # En el eje Y se eliminan los labels originales y se sustituyen por los labels rotados
  if(all(is.na(sequence_y))){
    axis(2, las = 2)
  }else{
    axis(2, las = 2, at=sequence_y)
  }
  

  # Añadimos leyenda
  if(legend == T){
    
    if(all(is.na(legendlabs))){
      # Si se ha especificado que haya leyenda pero no se ha especificado labels
      # estos labels serán números de 1 a n/3 (número de series)
      legendlabs <- c(1:(ncol(data)/3))
    }
    
    legend(legendpos,
           legend = legendlabs,
           col = colours,
           lty = rep(1, ncol(data)),
           box.lty = 0,
           cex = 1)
  }
  
}
