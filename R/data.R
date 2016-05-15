#### This script is used to generate series datasets for this workshop
rm(list=ls())
library(dplyr)
library(MetaCycle)
## readin the liver dataset (1h / 2days)
set.seed(1)
livD <- read.delim("./data-raw/Hughes2009_MouseLiver1h.txt", stringsAsFactors = FALSE)
rownum <- nrow(livD)                 # the number of rows
curvnum <- 20                        # the number of selected probesets for the case 

## generate caseB dataset (4h / 1day begins with CT19), txt file
caseB <- livD[sample(1:rownum, curvnum), ]
caseB <- select(caseB, ProbeID, num_range("CT", seq(19, 39, by=4), width = 2) )
write.table(caseB, file = "./data/caseB.txt", sep = "\t", quote = FALSE, row.names = FALSE)

## generate caseA dataset (4h / 2days begins with CT18), csv file
colnames(livD) <- c("ProbeID", 18:65)
caseA <- livD[sample(1:rownum, curvnum), c("ProbeID", seq(18, 62, by=4))]
write.csv(caseA, file = "./data/caseA.csv", quote = FALSE, row.names = FALSE)

## generate caseC dataset (6h/2days begins with CT20, with one missing time point), csv file
caseC <- livD[sample(1:rownum, curvnum), c("ProbeID", seq(20, 62, by=6))]
indexA <- sample(3:8, 1)
caseC[,indexA] <- NA
write.csv(caseC, file = "./data/caseC.csv", quote = FALSE, row.names = FALSE)

## generate caseD dataset (3h / 2days, 3 replicates at each time points, random missing value at each time point), csv file
caseD <- cycMouseLiverProtein
colnames(caseD) <- c("geneSymbol", rep(seq(0, 45, by=3), each = 3)) 
write.csv(caseD, file = "./data/caseD.csv", quote = FALSE, row.names = FALSE)

## generate caseE dataset (cell cycle, sampling interval is 16min, 11 samples in total, default  time for one cell cycle in this kind of yease is 85min), csv file
caseE <- cycYeastCycle
colnames(caseE) <- c("ProbeID", seq(2, 162, by=16))
write.csv(caseE, file = "./data/caseE.csv", quote = FALSE, row.names = FALSE)

## generate exerciseA and exerciseB dataset
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

## exerciseA, simulated cosine curves with noise (4h / 2days, 3 replicates at each time point), csv file 
exerciseA <- simuCurve(records=curvnum, replicates=3, cos.amp=2, sdv=1)
exerciseA <- as.data.frame(exerciseA)
exerciseA <- mutate(exerciseA, "curveID" = rownames(exerciseA) )
exerciseA <- exerciseA[,c(ncol(exerciseA), 1:(ncol(exerciseA) - 1) )]
colnames(exerciseA) <- c("curveID", rep(seq(0, 44, by=4), each=3))
write.csv(exerciseA, file = "./data/exerciseA.csv", quote = FALSE, row.names = FALSE)

## exerciseB, simulated cosine curves with noise (4h / 2days, varied number of replicates[1,3] at each time point), csv file
rnum <- sample(1:3, 12, replace = TRUE)
indexB <- matrix(2:ncol(exerciseA), ncol=3, byrow = TRUE)
indexB <- cbind(indexB, rnum)
indexC <- apply(indexB, 1, function(z) { sample(z[1:3], z[4]) } )
indexC <- c(1, sort(unlist(indexC)) )
exerciseB <- exerciseA[, indexC]
colnames(exerciseB) <- colnames(exerciseA)[indexC]
write.csv(exerciseB, file = "./data/exerciseB.csv", quote = FALSE, row.names = FALSE)

## exerciseC, un-even sampled, with 16 timepoints
indexD <- sample(18:65, 16)
indexD <- sort(indexD)
exerciseC <- livD[sample(1:rownum, curvnum), c("ProbeID", indexD)]
write.csv(exerciseC, file = "./data/exerciseC.csv", quote = FALSE, row.names = FALSE)

## generate an experimental like data (2h / 2days begins with CT18), csv file
curvnum <- 10000
experimentA <- livD[sample(1:rownum, curvnum), c("ProbeID", seq(18, 64, by = 2))]
write.csv(experimentA, file = "./data/experimentA.csv", quote = FALSE, row.names = FALSE)

