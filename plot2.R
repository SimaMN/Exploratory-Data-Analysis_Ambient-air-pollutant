

library("data.table")
library(dplyr)
library(ggplot2)


path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

################Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
################(\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? Use 
################the base plotting system to make a plot answering this question. 

baltcitymary.emissions<-summarise(group_by(filter(NEI, fips == "24510"), year), Emissions=sum(Emissions))
clrs <- c("red", "green", "blue", "yellow")
x2<-barplot(height=baltcitymary.emissions$Emissions/1000, names.arg=baltcitymary.emissions$year,
            xlab="years", ylab=expression('total PM'[2.5]*' emission in kilotons'),ylim=c(0,4),
            main=expression('Total PM'[2.5]*' emissions in Baltimore City-MD in kilotons'),col=clrs)

## Add text at top of bars
text(x = x2, y = round(baltcitymary.emissions$Emissions/1000,2), label = round(baltcitymary.emissions$Emissions/1000,2), pos = 3, cex = 0.8, col = "black")