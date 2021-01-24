## Question 3
# Read the data from the working directory
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
                
# Load the required packages
library(ggplot2)
                
# Subset NEI data by Baltimore's fip.
baltimore <- subset(NEI, fips == "24510")
                
# Get the total emissions by year for Baltimore
baltimoretype <- aggregate(Emissions ~ year + type, baltimore, sum)
                
# Open a new graphics device in png
png(filename = "plot3.png", width = 640, height = 480, units = "px")
                
# facet for each source type
g <- ggplot(baltimoretype, aes(factor(year), Emissions, fill = type)) +
  geom_bar(stat = "identity") +
  theme_bw() + 
  facet_wrap(. ~ type) +
  labs(title = expression("Total Baltimore PM"[2.5]*" Emissions by Type and Year")) +
  labs(x = "year", y = expression("Total Baltimore PM"[2.5]*" Emissions (Tons)")) 
print(g)
                
dev.off()
