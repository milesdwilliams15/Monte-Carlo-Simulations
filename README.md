# Monte-Carlo-Simulations
Practicing Monte Carlo Simulations Using My Thesis Dataset

[Back to Main Page](https://milesdwilliams15.github.io/)

Monte Carlo simulation is a great tool for data analysis that doesn't require you to assume many of the same basic assumptions required by traditional methods of statistical analysis. Monte Carlo is especially helpful when you're working with a limited number of cases but want to make generalizations regarding a larger population not captured by your sample.

For the examples below, I'm using a particular Monte Carlo method known as "bootstrapping" to measure uncertainty (an important measure in any kind of data analysis). This involves taking random resamples from an existing set of data "with replacement" -- i.e., if a case is randomly drawn from a sample of cases from a larger population, it can be redrawn more than once from the sample.

Iterating this procedure allows us to arrive at a some sort of a sense of the uncertainty of the distribution of a sample or the uncertainty regarding the strength of a relationship between any two given variables.

## Bootstrapping Dyadic US Aid Commitments to 123 Aid Recipients from 1993 to 2010
If you download the "US_Immigration" dataset included in this repository, you should be able to copy and past the below code and get the density plot shown below.

    windows() # or quartz() if you're using Mac
          # this will let us see the simulations plotted in real time.
    par(bty="n",col="darkblue",lwd=2)
    set.seed(555) # so we will get consistent results
    immig.boot<-numeric(0) # Resampling
    for(i in 1:1000){ # 1000 bootstrap iterations
      temp<-sample(US_Immigration$dAid, size = length(US_Immigration$dAid),replace=TRUE)
      immig.boot<-c(immig.boot,mean(temp))
      if(i>2){
        plot(density(immig.boot),
             main="Monte Carlo Simulation of the Density Distribution of\nBilateral US Aid Commitments to 123 Aid Recipients\nfrom 1993 to     2010")
        abline(v=mean(temp))
      }
    }

![density plot](https://cloud.githubusercontent.com/assets/23504082/21301589/9b63ffe8-c574-11e6-82dc-452562b45e4c.jpeg)

By applying the windows() or quartz() command (which one you use depends on whether you're using Windows or Mac), you can see the resampling being done in real time, which is pretty cool to watch. With each iteration, the density distribution for the mean amount of foreign aid the US has committed to non-OECD member countries narrows in on a fairly good estimate of the average US bilateral aid committed from 1993 to 2010 per aid recipient. This is an estimate because my dataset (my sample) not only contains some missing years per aid recipient, it also covers a limited sample of years and a limited sample of all countries that receive aid from the US.

We can also use the polygon() command to make a final density plot that looks like the following:

    # Use the polygon() command to make a better plot of the final distribution:
    windows()
    par(bty="n")
    # Make an empty plot to be filled in with the polygon() command.
    plot(density(immig.boot),axes=TRUE,col="white",
         xlab="Probability",ylab="Density",
         main="Density Distribution of Bilateral US Aid Commitments to\n123 Aid Recipients from 1993 to 2010\nAfter 1,000 Iterations")
    # Fill in the density distribution.
    polygon(c(density(immig.boot)$x,rev(density(immig.boot)$x)),
            c(density(immig.boot)$y,rep(0,length(density(immig.boot)$y))),
            col="darkblue",border="white",lwd=.01)

![density plot 2](https://cloud.githubusercontent.com/assets/23504082/21301593/a2323ce0-c574-11e6-978c-205d9743196d.jpeg)

## Using Bootstrapping to Determine Whether GDP/capita Has a Negative Effect on Unemployment
We can also invoke the bootstrap to determine whether there is a meaningful (i.e., non-zero) relationship between two variables.

In the below example, I take US GDP/capita (in 2005 US $) and plot its relationship with the unemployment rate (as estimated by the International Labor Organization estimate for the unemployment rate as a proportion of the population currently able/looking for work).

![scatter plot 2](https://cloud.githubusercontent.com/assets/23504082/21301837/a67360c0-c576-11e6-829a-edc28288bd5a.jpeg)

It's pretty clear that there's some sort of relationship here, but the right end of the plot has a lot of noise. 

Not only does this noise make it hard to make generalizations about the effect of GDP/capita on unemployment with certainty, the small number of cases make hypothesis testing with traditional statistical techniques next to impossible.

Enter the bootstrap!

Once you've downloaded the "US_Wealth" dataset available in this repository, you can enter the following code and watch in real time as the Monte Carlo simulations are iterated. While the plotted points from the orginal sample will remain the same, the lowess line for each iteration will be plotted one after the other and overlayed. I've given the color of the lowess lines a low degree of opacity in order to make it clearer where the majority of plotted lines fall.

    windows()
    par(bty="n",lwd=1)
    plot(US_Wealth$GDP.per.capita,US_Wealth$Unemployment,xlab="GDP per Capita",
         ylab="Unemployment",pch=19,col="darkblue",
         main="Monte Carlo Simulation\nof the Immpact of GDP per Capita\non Unemployment")
    set.seed(333)
    for(i in 1:1000){ # 1000 bootstrap iterations
      temp<-US_Wealth[sample(1:nrow(US_Wealth),replace=TRUE),]
      lines(lowess(temp$GDP.per.capita,temp$Unemployment,f=1),col="#88888815")
    }

The final result should be a plot that looks the one below.

![scatter plot](https://cloud.githubusercontent.com/assets/23504082/21301595/a6e57d38-c574-11e6-9ad4-7fb3cc0a34d2.jpeg)

The bootstrapping technique gives us a pretty clear sense for the central dendency of the data. With few exceptions, higher GDP/capita generally is associated with a lower unemployment rate. However, once GDP/capita reaches a certain point, its effect on unemployment appears to level off -- that is, it reaches a point of diminishing returns.

[Back to Main Page](https://milesdwilliams15.github.io/)
