## Question 6

# Read the data from the working directory
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Gather the subset of the NEI data which corresponds to vehicles

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Comparing emissions from motor vehicle sources in Baltimore City (fips == "24510") with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"),

vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
vehiclesBaltimoreNEI$city <- "Baltimore City"

vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame

bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

# Now we plot using the ggplot2 system,

# Load the required packages
library(ggplot2)

# Open a new graphics device in png
png(filename = "plot6.png", width = 640, height = 480, units = "px")

mvba <- ggplot(bothNEI, aes(x = factor(year), y = Emissions, fill = city)) +
 geom_bar(aes(fill = year), stat = "identity") +
 facet_grid(scales = "free", space = "free", .~city) +
 guides(fill = FALSE) + theme_bw() +
 labs(title = expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008")) + 
 labs(x = "year", y = expression("Total PM"[2.5]*" Emission (Kilo-Tons)"))
 
print(ggp)

dev.off()
