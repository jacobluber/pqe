library(ggplot2)
library(dyplyr)
library(reshape2)
library(cowplot)
library(ggsci)

summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
  library(plyr)

  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }

  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  
  
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}

dnac <- read.csv("/Users/jacobluber/Desktop/pqe/output/dna.txt",header=TRUE,sep=',',check.names=FALSE)
rnac <- read.csv("/Users/jacobluber/Desktop/pqe/output/rna.txt",header=TRUE,sep=',',check.names=FALSE)
bugsc <- read.csv("/Users/jacobluber/Desktop/pqe/output/bugs.txt",header=TRUE,sep=',',check.names=FALSE)
dnae <- read.csv("/Users/jacobluber/Desktop/pqe/output/dna_all.txt",header=TRUE,sep=',',check.names=FALSE)
rnae <- read.csv("/Users/jacobluber/Desktop/pqe/output/norm_rna_all.txt",header=TRUE,sep=',',check.names=FALSE)
dna <- data.frame(Group="DNA",as.data.frame(dnac),check.names=FALSE)
rna <- data.frame(Group="RNA",as.data.frame(rnac),check.names=FALSE)
bugs <- data.frame(Group="Species",as.data.frame(bugsc),check.names=FALSE)
dnaer <- data.frame(Group="DNA [ERROR]",as.data.frame(dnae),check.names=FALSE)
rnaer <- data.frame(Group="RNA [ERROR]",as.data.frame(rnae),check.names=FALSE)
toplot <- melt(rbind(dna, rna, bugs, dnaer, rnaer))
toplot_summary <- summarySE(toplot, measurevar="value", groupvars=c("Group","variable"))
pd <- position_dodge(0.1) 
ggplot(toplot_summary, aes(x=variable, y=value, colour=Group, group=Group)) + 
  geom_errorbar(aes(ymin=value-se, ymax=value+se), colour="black", width=.1, position=pd) +
  geom_line(position=pd) +
  geom_point(position=pd, size=3, shape=21, fill="white") +
  xlab("Longitudinal Sample Comparison") +
  ylab("Jaccard Index") + 
  expand_limits(y=0) +                        # 
  theme(legend.justification=c(1,0),
        legend.position=c(1,0)) +               # 
  scale_color_jco()

