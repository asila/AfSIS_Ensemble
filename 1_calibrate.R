calibration <- read.csv('~/AfSIS reference data with ZnSe MIR.csv')

library(soil.spec)

library(caret)

raw <- calibration[,-c(2:20)]

ref <- calibration[,1:20]

ref <- ref[,-c(2:3)]

colnames(ref)[1] <- "SSN"

# Set B < 0  to missing

b <- which(ref$B<0)

ref$B[b] <- NA

rpz <- function(x){
	zp <- which((x < 00000.1)==TRUE)
	x[zp] <- NA
	x
}

ref[,-1] <- sapply(ref[,-1],rpz)

#ref <- ref[,-c(2:7)]

# Do Ensemble
source('~/Dropbox/Tansis_opus/Code/0_ensemble.R', chdir = TRUE)

# Select 70% for calibration and 30% for validation
wd <- "~/Dropbox/Tansis_opus/Models"

set.seed(809892)

hout <- 0.2 # Use 20% of the calibrtaion set for testing the fitted models

ensemble(wd = wd ,infrared.data = raw,reference.data = ref, hout = hout , process = "derivative")


