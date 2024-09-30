# install the package
install.packages("gen3sis")

# check the package version, we are on 1.5.11
packageVersion("gen3sis")

library(gen3sis)

source("support.R")
# packages to load and install if necessary
load_install_pkgs(c("terra", "raster", "here", "ape", "phytools", "picante", "caret"))


# read the R data file
landscape <- readRDS(file.path(data_dir,"landscapes", "SouthAmerica", "landscapes.rds"))

# class
class(landscape)

# dimensions
dim(landscape$temp)

# take a look at first elements
landscape$temp[1:10, 1:10]

# column names
colnames(landscape$temp)


# Present Day South America
SA_1 <- rast(landscape$temp[ ,c("x", "y", "1")])
SA_65 <- rast(landscape$temp[,c("x", "y", "65")])

# plot present day
plot(SA_1)

# plot 65 Million years ago
plot(SA_65)




# overlay
plot(SA_65, col=rgb(1,0,0))
plot(SA_1, col=rgb(0,0,1,0.5,1), add=T)



config <- gen3sis::create_input_config(config_file = file.path("configs", "config_southamerica_Day1Prac1.R"))
names(config$gen3sis)


names(config$gen3sis$general)


sim <- run_simulation(config = file.path("configs", "config_southamerica_Day1Prac1.R"), 
                      landscape = file.path(data_dir,"landscapes", "SouthAmerica"),
                      output_directory = "output/SouthAmerica",
                      verbose=1)

# read phylogeny
phy <- read.nexus(file.path("output", "SouthAmerica", "config_southamerica_Day1Prac1", "phy.nex" ))

# plot phylogeny
plot(phy, cex=0.1, type="fan")
