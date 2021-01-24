## Question 5

# Read the data from the working directory
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# First I subset the motor vehicles, which we assume is anything like Motor Vehicle in SCC.Level.Two.
# Gather the subset of the NEI data which corresponds to vehicles

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Next I subset for motor vehicles in Baltimore,

baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips==24510,]

# Finally I plot using ggplot2,

# Load the required packages
library(ggplot2)

# Open a new graphics device in png
png(filename = "plot5.png", width = 640, height = 480, units = "px")

mvbp <- ggplot(baltimoreVehiclesNEI, aes(factor(year), Emissions, fill = year)) +
  geom_bar(stat = "identity", width=0.75) +
  theme_bw() + guides(fill=FALSE) +
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008")) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)"))

print(mvbp)

dev.off()
