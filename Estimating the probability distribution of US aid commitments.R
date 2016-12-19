
## Monte Carlo Simulation Using Some Data from My Thesis.

path<-file.path("C:","Users","family","Documents","R","Projects","Monte Carlo","US_Immigration.csv")
US_Immigration<-read.csv(path)

# Let's try some bootstraping by estimating the mean level of US aid commitments to 
# aid recipients:
windows() # or quartz() if you're using Mac
          # this will let us see the simulations plotted in real time.
par(bty="n",col="darkblue",lwd=2)
set.seed(555) # so we will get consistent results
immig.boot<-numeric(0) # Resampling
for(i in 1:1000){
  temp<-sample(US_Immigration$dAid, size = length(US_Immigration$dAid),replace=TRUE)
  immig.boot<-c(immig.boot,mean(temp))
  if(i>2){
    plot(density(immig.boot),
         main="Monte Carlo Simulation of the Density Distribution of\nBilateral US Aid Commitments to 123 Aid Recipients\nfrom 1993 to 2010")
    abline(v=mean(temp))
  }
}


# Use the polygon() command to make a better plot of the final distribution:
windows()
par(bty="n")
plot(density(immig.boot),axes=TRUE,col="white",
     xlab="Probability",ylab="Density",
     main="Density Distribution of Bilateral US Aid Commitments to\n123 Aid Recipients from 1993 to 2010\nAfter 1,000 Iterations")

polygon(c(density(immig.boot)$x,rev(density(immig.boot)$x)),
        c(density(immig.boot)$y,rep(0,length(density(immig.boot)$y))),
        col="darkblue",border="white",lwd=.01)

# Now for some relationships
# I made a new data.fame called US_Wealth
windows()
par(bty="n",lwd=1)
plot(US_Wealth$GDP.per.capita,US_Wealth$Unemployment,xlab="GDP per Capita",
     ylab="Unemployment",pch=19,col="darkblue",
     main="Monte Carlo Simulation\nof the Immpact of GDP per Capita\non Unemployment")
set.seed(333)
for(i in 1:1000){
  temp<-US_Wealth[sample(1:nrow(US_Wealth),replace=TRUE),]
  lines(lowess(temp$GDP.per.capita,temp$Unemployment,f=1),col="#88888815")
}






