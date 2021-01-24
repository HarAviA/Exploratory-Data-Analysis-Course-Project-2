## Question 2
# Read the data from the working directory
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
        
# Subset NEI data by Baltimore's fip.
baltimore <- subset(NEI, fips == "24510")
        
# Get the total emissions by year for Baltimore
b_total_emissions <- aggregate(Emissions ~ year, baltimore, sum)

# Open a new graphics device in png
png(filename = "plot2.png", width = 640, height = 480, units = "px")
        
barplot(b_total_emissions$Emissions, names.arg = b_total_emissions$year,
  xlab = "Year", ylab = expression("PM"[2.5]*" Emissions (Tons)"), 
  main = expression("Total PM"[2.5]*" Emissions From All Baltimore City Sources"))
                
dev.off()
