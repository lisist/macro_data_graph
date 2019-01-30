### Plotting US recession period on any economic chart
### Charting based on ggplot2
### need us_economic_cycle.csv which is referred from NBER.org
### The economic cycle is denoted after 1900s

library(ggplot2)
plot_recession <- function(target_value,target_date){

	us_cycle <- read.csv("us_economic_cycle.csv",header=T)  ## read US recession cycle
  
	peak <- as.Date(paste0(us_cycle$Peak,"-01"),format=c("%Y-%m-%d")) ## finding out US economic peak date
	trough <- as.Date(paste0(us_cycle$Trough,"-01"),format=c("%Y-%m-%d")) # finding out US economic trough date

	data_start_date <- target_date[1]

  ## modifying date data before plotting annotation graph
	
  peak_start <- peak[peak > data_start_date]  
	trough_start <- trough[trough > data_start_date]

	y_min <- round(min(target_value),0)
	y_max <- round(max(target_value),-1)+1

  ## plotting
  
	ggplot(data=data.frame(target_date,target_value),aes(x=target_date,y=target_value))+geom_line()+
	annotate("rect",xmin=peak_start,xmax=trough_start,ymin=y_min,ymax=y_max,alpha=0.1,fill="red")

}
