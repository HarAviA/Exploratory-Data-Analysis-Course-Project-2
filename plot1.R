## Question 1
# Read the data from the working directory
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Get the total emissions by year
total_emmissions <- aggregate(Emissions ~ year, NEI, sum)

# Open a new graphics device in png
png(filename = "plot1.png", width = 640, height = 480, units = "px")

barplot((total_emmissions$Emissions)/10^6, names.arg = total_emmissions$year,
        xlab = "Year", ylab = expression("Total US "~ PM[2.5]~ "Emissions (10^6 Tons)"), ylim = c(0, 7.5),
        main = expression("Total PM"[2.5]*" Emissions - All United States"))
        
dev.off()
