#### This script is used to generate series datasets for this workshop
rm(list=ls())
library(dplyr)
library(MetaCycle)
## readin the liver dataset (1h / 2days)
set.seed(1)
livD <- read.delim("./data-raw/Hughes2009_MouseLiver1h.txt", stringsAsFactors = FALSE)
rownum <- nrow(livD)                 # the number of rows
curvnum <- 20                        # the number of selected probesets for the case 

## generate caseA dataset (4h / 2days begins with CT18), csv file
colnames(livD) <- c("ProbeID", 18:65)
caseA <- livD[sample(1:rownum, curvnum), c("ProbeID", seq(18, 62, by=4))]
write.csv(caseA, file = "./data/caseA.csv", quote = FALSE, row.names = FALSE)

## generate caseB dataset (6h/2days begins with CT20, with one missing time point), txt file
caseB <- livD[sample(1:rownum, curvnum), c("ProbeID", seq(20, 62, by=6))]
indexB <- sample(3:8, 1)
caseB[,indexB] <- NA
write.table(caseB, file = "./data/caseB.txt", sep = "\t", quote = FALSE, row.names = FALSE)

## generate caseC dataset (cell cycle, sampling interval is 16min, 11 samples in total, default  time for one cell cycle in this kind of yease is 85min), csv file
caseC <- cycYeastCycle
colnames(caseC) <- c("ProbeID", seq(2, 162, by=16))
write.csv(caseC, file = "./data/caseC.csv", quote = FALSE, row.names = FALSE)

## generate exerciseA dataset (4h / 1day begins with CT19), txt file
exerciseA <- livD[sample(1:rownum, curvnum), c("ProbeID", seq(19, 39, by=4))]
write.table(exerciseA, file = "./data/exerciseA.txt", sep = "\t", quote = FALSE, row.names = FALSE)

## generate exerciseB and exerciseC dataset
simuCurve <- function (records, replicates=1, cos.amp=1, sdv=1)
{
	## the function of generating cosine signals
	cospF <- function(t,amp,per,pha)
	{
		cosp <- amp*cos(2*pi/per*(t-pha))  
		return (cosp)
	}
	## prepare the parameters for generating cosine curves
	set.seed(records)	
	tm <- seq(0, 44, by=4)   
	cos.periods <- 24
	datapoints <- length(tm)*replicates
	cos.lag.factors <- runif(records,0,1)
	cos.parameters <- as.matrix( cbind(rep(cos.amp, records),rep(cos.periods, records),cos.lag.factors*cos.periods) )         
	## generate cosine curves
	cosp.sig <- t( apply(cos.parameters,1,function(para)
	                                                 { rep(cospF(t=tm,amp=para[1],per=para[2],pha=para[3]),each=replicates)   }
	                                                 ) )
	
	## generate noise values
	nois.sig <- rnorm(records*datapoints, mean=0,sd=sdv)
	nois.sig <- matrix(nois.sig, nrow=records, ncol=datapoints)
	## add noise values to cosine signals
	cosp.sig<-cosp.sig + nois.sig
	## prepare the output data
	shuffle <- sample(1:records)
	cosp.sig <- cosp.sig[shuffle,]
	cos.parameters <- round(cos.parameters[shuffle,],3)
	cosp.nam <- paste("cosp",cos.parameters[,2],cos.parameters[,3],cos.parameters[,1],1:nrow(cos.parameters),sep="_")
	dimnames(cosp.sig) <- list("r"=cosp.nam, "c"=paste("c", 1:ncol(cosp.sig), sep="_") )
	return (cosp.sig)
}

## exerciseB, simulated cosine curves with noise (4h / 2days, 3 replicates at each time point), csv file 
exerciseB <- simuCurve(records=curvnum, replicates=3, cos.amp=2, sdv=1)
exerciseB <- as.data.frame(exerciseB)
exerciseB <- mutate(exerciseB, "curveID" = rownames(exerciseB) )
exerciseB <- exerciseB[,c(ncol(exerciseB), 1:(ncol(exerciseB) - 1) )]
colnames(exerciseB) <- c("curveID", rep(seq(0, 44, by=4), each=3))
write.csv(exerciseB, file = "./data/exerciseB.csv", quote = FALSE, row.names = FALSE)

## exerciseC, simulated cosine curves with noise (4h / 2days, varied number of replicates[1,3] at each time point), csv file
rnum <- sample(1:3, 12, replace = TRUE)
indexC <- matrix(2:ncol(exerciseB), ncol=3, byrow = TRUE)
indexC <- cbind(indexC, rnum)
indexD <- apply(indexC, 1, function(z) { sample(z[1:3], z[4]) } )
indexD <- c(1, sort(unlist(indexD)) )
exerciseC <- exerciseB[, indexD]
colnames(exerciseC) <- colnames(exerciseB)[indexD]
write.csv(exerciseC, file = "./data/exerciseC.csv", quote = FALSE, row.names = FALSE)

## generate exerciseD dataset (3h / 2days, 3 replicates at each time points, random missing value at each time point), csv file
exerciseD <- cycMouseLiverProtein
colnames(exerciseD) <- c("geneSymbol", rep(seq(0, 45, by=3), each = 3)) 
write.csv(exerciseD, file = "./data/exerciseD.csv", quote = FALSE, row.names = FALSE)

## exerciseE, un-even sampled, with 16 timepoints
indexE <- sample(18:65, 16)
indexE <- sort(indexE)
exerciseE <- livD[sample(1:rownum, curvnum), c("ProbeID", indexE)]
write.csv(exerciseE, file = "./data/exerciseE.csv", quote = FALSE, row.names = FALSE)

## generate an experimental like data (2h / 2days begins with CT18), csv file
curvnum <- 20000
experimentA <- livD[sample(1:rownum, curvnum), c("ProbeID", seq(18, 64, by = 2))]
write.csv(experimentA, file = "./data/experimentA.csv", quote = FALSE, row.names = FALSE)

## generate datasets for discussion part
#### This script is used to generate series datasets for this workshop
rm(list=ls())
library(dplyr)
## readin the liver dataset (1h / 2days)
set.seed(10)
livD <- read.delim("./data-raw/Hughes2009_MouseLiver1h.txt", stringsAsFactors = FALSE)
colnames(livD) <- c("ProbeID", 18:65)
rownum <- nrow(livD)                 # the number of rows
curvnum <- 5000                      # the number of selected probesets for the case 
index <- sample(1:rownum, curvnum)

## generate discussionA_1h/1day dataset, csv file
discussionA_1day <- livD[index, c("ProbeID", 18:41)]
write.csv(discussionA_1day, file = "./data/discussionA_1day.csv", quote = FALSE, row.names = FALSE)

## generate discussionA_1h/2days dataset, csv file
discussionA_2days <- livD[index, c("ProbeID", 18:65)]
write.csv(discussionA_2days, file = "./data/discussionA_2days.csv", quote = FALSE, row.names = FALSE)

## generate discussionB_CT18 dataset, csv file
discussionB_CT18 <- livD[index, c("ProbeID", seq(18, 64, by = 2))]
write.csv(discussionB_CT18, file = "./data/discussionB_CT18.csv", quote = FALSE, row.names = FALSE)

## generate discussionB_CT19 dataset, csv file
discussionB_CT19 <- livD[index, c("ProbeID", seq(19, 65, by = 2))]
write.csv(discussionB_CT19, file = "./data/discussionB_CT19.csv", quote = FALSE, row.names = FALSE)
