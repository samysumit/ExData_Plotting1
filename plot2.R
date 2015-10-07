library(dplyr)

#Getting Work Dir
wrkdir <- getwd()

#Checking if the zip file exists if not then downloading the file
if(!file.exists("powerconsump.zip"))
{
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileurl,destfile="powerconsump.zip",method="curl")
}

#Unzipping the file
unzip(zipfile="powerconsump.zip",exdir="PlotProj")

#setting the unzip folder as the work directory
wd <- file.path(wrkdir,"PlotProj")
setwd(wd)

#creating a data frame that holds all the data
df_hpc <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
#updating date column to reflect class as date
df_hpc$Date <- as.Date(df_hpc$Date,"%d/%m/%Y")
#subsetting the data frame to only have data set corresponding to 2007-02-01 and 2007-02-02 
df_hpc <- filter(df_hpc,Date =="2007-02-01" | Date == "2007-02-02")
#updating time column to reflect class as date
df_hpc$Time <- strptime(paste(df_hpc$Date,df_hpc$Time,sep=" "),"%Y-%m-%d %H:%M:%S")
#Omitting NA rows
df_hpc <- na.omit(df_hpc)

#Setting up the margin for the plot
par(mar= c(5,5,2,1))
#Calling plot function to plot the graph
plot(df_hpc$Time,df_hpc$Global_active_power,type="l",ylab = "Global Active Power (kilowatts)",xlab="")
#using the dev.copy function to create the png file
dev.copy(png, filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
#shutting down device
dev.off()
#setting the workdirectory back to the original work directory
setwd(wrkdir)