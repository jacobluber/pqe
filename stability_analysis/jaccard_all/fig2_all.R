library(Rcpp)
Rcpp::sourceCpp("jaccard_all.cpp")
args <- commandArgs(trailingOnly = TRUE)
v <- function(...) cat(sprintf(...), sep='', file=stderr())
dff <- read.csv(args[1],header=TRUE,row.names=1,sep='\t',check.names=FALSE)
idx <- 1
while(idx < 312){
print(idx)
a<-as.vector(dff[,idx])
b<-as.vector(dff[,idx+1])
c<-as.vector(dff[,idx+2])
d<-as.vector(dff[,idx+3])
j1 <- JaccardIndex(a,a)
j2 <- JaccardIndex(a,b)
j3 <- JaccardIndex(a,c)
j4 <- JaccardIndex(a,d)
v("%f,%f,%f,%f\n", j1, j2, j3, j4)
idx <- idx+4
}
