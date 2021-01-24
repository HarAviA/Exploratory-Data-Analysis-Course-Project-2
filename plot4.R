## Question 4

# Read the data from the working directory
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# First I subset coal combustion source factors NEI data.
# Subset coal combustion related NEI data

combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

# Load the required packages
library(ggplot2)

# Open a new graphics device in png
png(filename = "plot4.png", width = 640, height = 480, units = "px")

ccp <-  ggplot(combustionNEI, aes(factor(year), Emissions/10^5, fill = year)) +
  geom_bar(stat = "identity", width = 0.75) +
  theme_bw() +  
  labs(x = "year", y = expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title = expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(ccp)

dev.off()
