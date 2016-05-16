#### This file contains functions used to draw figures shown in the demo files
## loading the required library
library(dplyr)
library(reshape2)
library(cowplot)
library(ggplot2)
#### This is the heatmap function
heatmapF <- function(inputD, minfold=0.8, maxfold=1.25) {
  ## set column names for the inputD
  colnames(inputD) <- c("CycID", "Per", "Pha", paste("sample", 1:(ncol(inputD) -3), sep=""))
  ## arrange the input data by phase information
  inputD <- arrange(inputD, Pha)
  ## median normalization of the expression profiles
  figM <- as.matrix(inputD[, -(1:3)])
  fig_median <- apply(figM, 1, median)
  figM <- figM / fig_median
  figM[figM < minfold] <- minfold
  figM[figM > maxfold] <- maxfold
  figD <- as.data.frame(figM)
  ## prepare the data frame for heatmap
  id_order <- as.character(inputD$CycID)
  id_factor <- as.factor(length(id_order):1)
  figD <- mutate(figD, id_factor = id_factor)
  cnum <- ncol(figD)
  figD <- figD[,c(cnum, 1:(cnum - 1))]
  figD.m <- melt(figD)
  ## draw the heatmap  
  p <- ggplot(figD.m, aes(variable, id_factor)) + geom_tile(aes(fill = value)) +
    scale_fill_gradient2(name="Exp/Med", low = "blue", mid="grey20", high = "yellow", midpoint=1, space="Lab")
  heat.plot <- p + labs(title="", x="", y="") + scale_x_discrete(expand = c(0, 0)) + scale_y_discrete(expand = c(0, 0)) + 
    theme(axis.line=element_blank(), axis.ticks = element_blank(), axis.text = element_blank() )    
  heat.out <- ggdraw() + draw_plot(heat.plot)
  return(heat.out)
}
#### This is the phase distribution function
phaseHist <- function(inputD, binvalue=seq(0,24,by=1), histcol = "blue")  {
  ## set column names for the inputD
  colnames(inputD) <- c("CycID", "Per", "Pha", paste("sample", 1:(ncol(inputD) -3), sep=""))
  figD <- select(inputD, CycID, Pha)
  p <- ggplot(figD, aes(Pha)) + 
       geom_histogram(breaks = binvalue, col="grey60", fill=histcol, show.legend = FALSE) +
       labs(title="", x="Phase value", y="Count") + scale_x_continuous(breaks = binvalue, labels = binvalue)
  phase.out <- ggdraw() + draw_plot(p)
  return(phase.out)
}

  