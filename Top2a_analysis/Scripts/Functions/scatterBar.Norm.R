scatterBar.Norm <- function(x,y, density) {
  zones <- matrix(c(2,0,1,3), ncol=2, byrow=TRUE)
  layout(zones, widths=c(5/7,2/7), heights=c(2/7,5/7))
  xrange <- range(x)
  yrange <- range(y)
  par(mar=c(3,3,1,1))
  plot(x, y, xlim=xrange, ylim=yrange, xlab="", ylab="", cex=0.5)
  xhist <- hist(x, plot=FALSE, breaks=seq(from=min(x), to=max(x), length.out=200))
  yhist <- hist(y, plot=FALSE, breaks=seq(from=min(y), to=max(y), length.out=200))
  top <- max(c(xhist$density, yhist$density))
  par(mar=c(0,3,1,1))
  barplot(xhist$density, axes=FALSE, ylim=c(0, top), space=0)
  if (density == TRUE){
    x.xfit <- seq(min(x),max(x),length.out=40)
    x.yfit <- dnorm(x.xfit, mean=mean(x), sd=sd(x))
    x.xscalefactor <- x.xfit / seq(from=0, to=199, length.out=40)
    lines(x.xfit/x.xscalefactor, x.yfit, col="red")
  }
  par(mar=c(3,0,1,1))
  barplot(yhist$density, axes=FALSE, xlim=c(0, top), space=0, horiz=TRUE)
  if (density == TRUE) {
    y.xfit <- seq(min(y),max(y),length.out=40)
    y.yfit <- dnorm(y.xfit, mean=mean(y), sd=sd(y))
    y.xscalefactor <- y.xfit / seq(from=0, to=199, length.out=40)
    lines(y.yfit, y.xfit/y.xscalefactor, col="red")
  }
}


